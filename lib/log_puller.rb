def log_pull(sudo, app, time)
  # Log Puller

  file_name = "./logs/" + app + "." + Time.now().to_i.to_s + ".log"
  if sudo
    runner_string = "heroku sudo "
  else
    runner_string = "heroku "
  end

  runner_string << "logs -t -a " + app + " > " + file_name 

  os_version = `uname`
  if os_version == "Darwin"
    timeout = "gtimeout"
  else
    timeout = "timeout"
  end
  
  #do the work
  `#{timeout} #{time}m #{runner_string}`
  return file_name
end