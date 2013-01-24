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


Copyright (c) 2013, Greg Nokes

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of Heroku, Heroku Log Analyzer nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.