require 'csv'

file_name = "123"
@percentile_targets = [0.999, 0.99, 0.80, 0.50]

def percentile_of(list_of_numbers, type)
  list_of_numbers.sort!.reverse
  p = type*list_of_numbers.count
  return list_of_numbers[p]
  
end

def generate_list_of_times(file)
  list_of_times = []
  time_file = CSV.read(file)
  time_file.each {|row| list_of_times << row[1].to_i}
  @percentile_targets.each { |p|
    puts p.to_s + " " + percentile_of(list_of_times, p).to_s
    }
end

puts

#Get the service times out of the raw logs
`awk '{for(i=1;i<=NF;i++){if($i~/^service=/){print $i}}}' #{file_name} > #{file_name}_s1`
`tr '=' ',' <#{file_name}_s1 > #{file_name}_s2`
`tr 'ms' ',ms'<#{file_name}_s2 > #{file_name}_servicetimes.csv`
`rm #{file_name}_s1 #{file_name}_s2`
puts "Service Times"
generate_list_of_times("#{file_name}_servicetimes.csv")


#get the wait times out of the logs

`awk '{for(i=1;i<=NF;i++){if($i~/^wait=/){print $i}}}' #{file_name} > #{file_name}_w1`
`tr '=' ',' <#{file_name}_w1 > #{file_name}_w2`
`tr 'ms' ',ms' <#{file_name}_w2 > #{file_name}_waittimes.csv`
`rm #{file_name}_w1 #{file_name}_w2`
puts "Wait Times"
generate_list_of_times("#{file_name}_waittimes.csv")

# Count the number of H12's, H13's

heroku_errors = ["H12", "H13", "R13"]
heroku_error_results = []
heroku_errors.each { |e|
  
  heroku_error_results = `grep #{e} #{file_name} |wc -l`
  
  #for testing
  puts e + `grep #{e} #{file_name} |wc -l`
  }

  
