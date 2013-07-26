### prereqs
[See directions here](http://wiki.basho.com/Installing-Erlang.html) or use [homebrew](http://mxcl.github.com/homebrew/) if you're on a Mac:

    brew install erlang
    
Install heroku gem:

    gem install heroku
    

### install

Clone this repo with `git clone git://github.com/6/heroku-erlang-example.git`

`cd` into it, and then:

    make
    ./start.sh
    
This will start the web server locally at [http://localhost:8000](http://localhost:8000)

### running on heroku with [erlang buildpack](https://github.com/heroku/heroku-buildpack-erlang)

    heroku create --stack cedar
    heroku config:add BUILDPACK_URL=http://github.com/heroku/heroku-buildpack-erlang.git
    
Then just push it to heroku with `git push heroku master`
