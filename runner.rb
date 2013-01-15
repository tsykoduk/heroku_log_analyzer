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

require 'lib/prereqs.rb'

##
# Pull in command line switches
#
app = "App_Name"
time = 30 #minutes
sudo = true
#
##

##
# Build out a log run f 