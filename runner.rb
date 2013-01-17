#!/usr/bin/env ruby -wKU

##
# We want this to run for a certian amount of time
# pulling the log files from a speific app
# and then run some analysis on them
#
# Find things like # of H12's, # of dyno restarts
# Longest running transactions, and most importantaly the
# 99.9, 99 and 50 percentile transaction times
##

require './lib/prereqs.rb'


##
# Pull in command line switches
#
percentile_targets = [0.999, 0.990,0.950,0.900,0.750,0.500,0.250,0.100,0.050,0.010,0.001]
app = "ttm-production"
time = 1 #minutes
sudo = true
screen = false

puts "starting run"

##
# Generate a log file
##
puts "grabbing " + time.to_s + " minutes of logs from the app called " + app
file_name = log_pull(sudo, app, time)
report = "Preformance Report for " + app + "\nGenerated on" + Time.now() + "\n"

##
# Build out a log run
#
puts "building out the report"
report << log_parser(file_name,percentile_targets, time)

if screen
  printf report
else
  puts "Generating the report"
  File.open(file_name + ".report", 'w') do |f|
      f << report
  end
  puts "you should find it in a file called " + file_name + ".report"
end