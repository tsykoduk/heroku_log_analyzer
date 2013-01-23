heroku log analyzer
===================

Depends on:

* Heroku toolbelt.
* GNU/Timeout - on OSX do ``brew install coreutils``. Linux should have it.
* Run bundle install in it's directory and it will grab the gems that it requires
* Tested on OSX with Ruby 1.9.3

Pull and get stats from Heroku logs
  
    Usage:
    runner [options]
    where [options] are:
        --sudo, -s:   Run with sudo. Requires the sudo plugin. (Default: False)
      --screen, -f:   Display to the screen. (Default: False)
     --app, -a <s>:   App Name to pull logs for.
    --time, -t <i>:   Number of minutes to pull logs for. (Default: 5)
        --help, -h:   Show this message
         --log, -l:   Pass it a logfile already pulled to run stats on