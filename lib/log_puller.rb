def log_pull(sudo, app, time,os)
  file_name = "./work/" + app + "." + Time.now().to_i.to_s + ".log"
  if sudo
    runner_string = "heroku sudo "
  else
    runner_string = "heroku "
  end

  runner_string << "logs -t -a " + app + " > " + file_name 

  
  if os == "Darwin"
    timeout = "gtimeout"
  else
    timeout = "timeout"
  end
  
  `#{timeout} #{time}m #{runner_string}`
  return file_name
end


def real_time_log_pull(sudo, app)
  #todo add ablity to pull logs every minute, updating stats on the fly
  #I want to push this to a CLI screen, or perhaps a webby type thing
  #Not sure yet
end
