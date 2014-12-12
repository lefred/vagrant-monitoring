#!/usr/bin/ruby

require 'rubygems'
require 'mysql2'
require 'elasticsearch'
require 'json'

# don't forget to enable the collection in PFS
# update performance_schema.setup_consumers set ENABLED='YES' where NAME like 'events_statements_histo%';
# you can set this in my.cnf [mysqld]
# performance-schema-consumer-events_statements_history=1
# performance-schema-consumer-events_statements_history_long=1


es = Elasticsearch::Client.new(:host => '192.168.90.2', :log => true)

#results = client.query("select *,date_sub(now(),INTERVAL (select VARIABLE_VALUE from information_schema.global_status where variable_name='UPTIME')-TIMER_START*10e-13 second) start_time, timer_wait/10E-8 wait_ms from performance_schema.events_statements_history_long;")

time = Time.new
index_name = 'mysql-' + time.strftime("%Y.%m.%d")
puts "index = " + index_name
if not es.indices.exists(:index => index_name)
puts "FRED"
	es.indices.create(:index => index_name, :body => { :mappings => 
		{ :'mysql-digest' => {
		    :properties => { 
		       :start_time => 
		       { :type => 'date', :format => 'dateOptionalTime' }
		   } 
		  }
		} 
	})
#	es.indices.put_mapping(:index => index_name, :type => 'mysql-digest', :body => {
#	  :'mysql-digest' => {
#	    :properties => {
#	      :start_time => { :type => 'date', :format => 'dateOptionalTime' }
#	    }
#	  }
#	})
end
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "fred")
results = client.query("select *,concat(date_format(date_sub(now(),INTERVAL (select VARIABLE_VALUE from information_schema.global_status where variable_name='UPTIME')-TIMER_START*10e-13 second),'%Y-%m-%dT%T'),'.000Z') start_time, timer_wait/10E-8 wait_ms from performance_schema.events_statements_history_long;")
client.query("truncate table performance_schema.events_statements_history_long")
results.each do |row|
   es.index(:index => index_name, :type => 'mysql-digest', :body => row.to_json) 
end

