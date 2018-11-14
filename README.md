Canary
======

Get notified on slack each time someone sends a http request to a fake resource. 

An alternative to https://canarytokens.org/generate which supports
- forwarding any data you pass in the url
- slack webhooks

**How is this useful?** It can be useful to test XSS vulnerabilities or track when a document is loaded.




## Deploy to Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

Remember to set webhook url as config/environment variable in Heroku either from CLI
```
heroku config:set canary_slack_web_hook_url="https://hooks.slack.com/services/abc/defg/1234"
```

or via Heroku dashboard like this

![Dashboard](https://user-images.githubusercontent.com/3652587/48548657-cd978880-e8cd-11e8-985a-b8e668dd62ef.png)




## Local development

### First time

    $ brew install rbenv
    $ rbenv init # and do what it tells you to
    $ rbenv install $(cat ".ruby-version")
    $ gem install bundler
    $ bundle install --binstubs
    $ export canary_slack_web_hook_url="https://hooks.slack.com/services/abc/defg/1234" # replace with your webhook url



## Run application locally

    $ bundle install --binstubs
    $ bundle exec puma -C puma/config.rb


## Debug application locally

1. Open code (VSCode) and install Ruby plugin (rebornix.ruby) from Peng Lv
2. Hit `cmd` + `shift` + `F5`
3. Go to [127.0.0.1:3000](http://127.0.0.1:3000/)

