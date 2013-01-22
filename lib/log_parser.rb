def generate_list_of_times(file,percentile_targets)
  list_of_times = []
  time_file = CSV.read(file)
  time_file.each {|row| list_of_times << row[1].to_i}
  report = ""
  percentile_targets.each { |p|
    report << p.to_s + "\t" + percentile_of(list_of_times, p).to_s + "\n"
    }
  report <<  "Max" + "\t" + list_of_times.first.to_s + "\n"
  report <<  "Min" + "\t" + list_of_times.last.to_s + "\n"
  report <<  "Mean" + "\t" + mean(list_of_times).to_i.to_s + "\n"
  report <<  "Std Dev" + "\t" + standard_dev(list_of_times).to_i.to_s + "\n"
  return report
end

def log_processor(file, type)
  `awk '{for(i=1;i<=NF;i++){if($i~/^#{type}=/){print $i}}}' #{file} > #{file}_s1`
  `tr '=' ',' <#{file}_s1 > #{file}_s2`
  `tr 'ms' ',ms'<#{file}_s2 > #{file}_#{type}times.csv`
end

def clean_up(file, types)
  `rm #{file}_s1 #{file}_s2`
  types.each { |type|
    `rm #{file}_#{type}times.csv`
    }
end
 
def log_parser(file,percentile_targets,time)
  
  log_processor(file, "service")
  report =  `cat #{file}_servicetimes.csv | wc -l`.to_i.to_s + " total requests captured" + " in " + time.to_s + " minutes\n"
  report << "\n"
  report <<  "Service Times\n"
  report <<  "=-=-=-=-=-=-=-=-=-=\n"
  report << generate_list_of_times("#{file}_servicetimes.csv",percentile_targets)
  report << "\n"
  
  log_processor(file, "wait")
  report << "\n"
  report <<  "Wait Times\n"
  report <<  "=-=-=-=-=-=-=-=-=-=\n"
  report << generate_list_of_times("#{file}_waittimes.csv",percentile_targets)
  report << "\n"

  log_processor(file, "queue")
  report << "\n"
  report <<  "Queue Times\n"
  report <<  "=-=-=-=-=-=-=-=-=-=\n"
  report << generate_list_of_times("#{file}_queuetimes.csv",percentile_targets)
  report << "\n"

  log_processor(file, "connect")
  report << "\n"
  report <<  "Connect Times\n"
  report <<  "=-=-=-=-=-=-=-=-=-=\n"
  report << generate_list_of_times("#{file}_queuetimes.csv",percentile_targets)
  report << "\n"
  
  clean_up(file, ["queue", "service", "wait", "connect"]) 

  # Count the number of H12's, H13's
  
  heroku_errors = ["H10","H11","H12", "H13","H18","H19","H20","R10","R12","R14","R15"]
  heroku_error_results = []
  total_log_lines = `cat #{file} | wc -l`
  report << "\n"
  report <<  "Heroku Errors\n"
  report <<  "=-=-=-=-=-=-=-=-=-=\n" 
  heroku_errors.each { |e|
    heroku_error_results = `grep code=#{e} #{file} |wc -l`
    report <<  e + "\t" + heroku_error_results.to_i.to_s + "\t" + ((heroku_error_results.to_f/total_log_lines.to_f)*100).to_i.to_s + "%\n"
  }
  
  return report

end