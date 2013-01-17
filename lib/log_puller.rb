def log_pull(sudo, app, time)
  # Log Puller
  file_name = "./logs/" + app + "." + Time.now().to_i.to_s + ".log"
  if sudo.true? 
    runner_string = "heroku sudo "
  else
    runner_string = "heroku "
  end 
  runner_string << "logs -t -a " + app + " > " + file_name 

  #do the work
  `timeout #{time}m #{runner_string}`
  return file_name
end