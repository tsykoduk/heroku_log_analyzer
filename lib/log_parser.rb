
def percentile_of(list_of_numbers, type)
  list_of_numbers.sort!.reverse!
  p = type*list_of_numbers.count
  return list_of_numbers[p]
  
end

def generate_list_of_times(file,percentile_targets)
  list_of_times = []
  time_file = CSV.read(file)
  time_file.each {|row| list_of_times << row[1].to_i}
  percentile_targets.each { |p|
    printf p.to_s + "\t" + percentile_of(list_of_times, p).to_s + "\n"
    }
    printf "Max" + "\t" + list_of_times.first.to_s + "\n"
    printf "Min" + "\t" + list_of_times.last.to_s + "\n"
    printf "Mean" + "\t" + mean(list_of_times).to_i.to_s + "\n"
    printf "Std Dev" + "\t" + standard_dev(list_of_times).to_i.to_s + "\n"
end

def log_parser(file,percentile_targets)
  puts

  #Get the service times out of the raw logs
  `awk '{for(i=1;i<=NF;i++){if($i~/^service=/){print $i}}}' #{file} > #{file}_s1`
  `tr '=' ',' <#{file}_s1 > #{file}_s2`
  `tr 'ms' ',ms'<#{file}_s2 > #{file}_servicetimes.csv`
  `rm #{file}_s1 #{file}_s2`
  puts
  puts "Service Times"
  puts "=-=-=-=-=-=-=-=-=-="
  generate_list_of_times("#{file}_servicetimes.csv",percentile_targets)
  puts


  #get the wait times out of the logs

  `awk '{for(i=1;i<=NF;i++){if($i~/^wait=/){print $i}}}' #{file} > #{file}_w1`
  `tr '=' ',' <#{file}_w1 > #{file}_w2`
  `tr 'ms' ',ms' <#{file}_w2 > #{file}_waittimes.csv`
  `rm #{file}_w1 #{file}_w2`
  puts
  puts "Wait Times"
  puts "=-=-=-=-=-=-=-=-=-="
  generate_list_of_times("#{file}_waittimes.csv",percentile_targets)
  puts
  
  #get the queue times out of the logs
  #not really useful yet for ruby apps

  `awk '{for(i=1;i<=NF;i++){if($i~/^queue=/){print $i}}}' #{file} > #{file}_w1`
  `tr '=' ',' <#{file}_w1 > #{file}_w2`
  `tr 'ms' ',ms' <#{file}_w2 > #{file}_queuetimes.csv`
  `rm #{file}_w1 #{file}_w2`
  puts
  puts "Queue Times"
  puts "=-=-=-=-=-=-=-=-=-="
  generate_list_of_times("#{file}_queuetimes.csv",percentile_targets)
  puts

  # Count the number of H12's, H13's
  
  heroku_errors = ["H10","H11","H12", "H13","H18","H19","H20","R10","R12","R14","R15"]
  heroku_error_results = []
  total_log_lines = `cat #{file} | wc -l`
  puts
  puts "Heroku Errors"
  puts "=-=-=-=-=-=-=-=-=-=" 
  heroku_errors.each { |e|
    heroku_error_results = `grep code=#{e} #{file} |wc -l`
    printf e + "\t" + heroku_error_results.to_i.to_s + "\t" + ((heroku_error_results.to_f/total_log_lines.to_f)*100).to_i.to_s + "%\n"
  }
end
  
