require 'csv'

file_name = "123"
percentile_targets[99.9, 99, 80, 50]
puts

#Get the service times out of the raw logs
`awk '{for(i=1;i<=NF;i++){if($i~/^service=/){print $i}}}' #{file_name} > #{file_name}_s1`
`tr '=' ',' <#{file_name}_s1 > #{file_name}_s2`
`tr 'ms' ',ms'<#{file_name}_s2 > #{file_name}_servicetimes.csv`
`rm #{file_name}_s1 #{file_name}_s2`
service_times = []
service_time_file = CSV.read("#{file_name}_servicetimes.csv")
service_time_file.each {|row| service_times << row[2]}
puts "Service Time Percentiles"
puts
percentile_targets.each { |p|
  puts p + percentile_of(service_times, p)
  }



#get the wait times out of the logs

`awk '{for(i=1;i<=NF;i++){if($i~/^wait=/){print $i}}}' #{file_name} > #{file_name}_w1`
`tr '=' ',' <#{file_name}_w1 > #{file_name}_w2`
`tr 'ms' ',ms' <#{file_name}_w2 > #{file_name}_waittimes.csv`
`rm #{file_name}_w1 #{file_name}_w2`

# Get the 99.9th, 99th, 80th, and 50th percentile


# Count the number of H12's, H13's

heroku_errors = ["H12", "H13", "R13"]
heroku_error_results = []
heroku_errors.each { |e|
  
  heroku_error_results = `grep #{e} #{file_name} |wc -l`
  
  #for testing
  puts e + `grep #{e} #{file_name} |wc -l`
  }
  
def percentile_of(list_of_numbers, type=99.9)
  
  list_of_numbers.sort!
  p = (type/100)
  return list_of_numbers[p]
  
end
  
