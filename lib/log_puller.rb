# Log Puller

file_name = Time.now().to_i

if sudo.true? 
  runner_string = "heroku sudo "
else
  runner_string = "heroku "
end 

runner_string << "logs -t -a " + app + " > " + file_name 

##TODO make this run for time in minutes some how