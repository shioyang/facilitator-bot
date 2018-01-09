# facilitator-bot


## Run on local

$ HUBOT_SLACK_TOKEN=abc123
$ HUBOT_DIALOGUE_APIKEY=def456
$ export HUBOT_SLACK_TOKEN
$ export HUBOT_DIALOGUE_APIKEY
$ npm install
$ npm start

## Run on docker

$ docker build -t tag_name ./
$ docker run -it -e "HUBOT_SLACK_TOKEN=abc123" -e "HUBOT_DIALOGUE_APIKEY=def456" tag_name
