heroku log analyzer
===================

Depends on:

* Heroku toolbelt.
* GNU/Timeout - on OSX do ``brew install coreutils``. Linux should have it.

Pull and get stats from Heroku logs
  
    Usage:
    runner [options]
    where [options] are:
        --sudo, -s:   Run with sudo. Requires the sudo plugin. (Default: False)
      --screen, -f:   Display to the screen. (Default: False)
     --app, -a <s>:   App Name to pull logs for.
    --time, -t <i>:   Number of minutes to pull logs for. (Default: 5)
        --help, -h:   Show this message

