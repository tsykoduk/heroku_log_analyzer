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
percentile_targets = [0.999, 0.990,0.950,0.900,0.750,0.500,0.250,0.100,0.050,0.010,0.001]

##
# Pull in command line switches
#
app = "ttm-production"
time = 1 #minutes
sudo = true
#file_name = "./logs/ttm.logs"


##
# Generate a log file
##

file_name = log_pull(sudo, app, time)

##
# Build out a log run
#
log_parser(file_name,percentile_targets)
