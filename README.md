# facilitator-bot


## Run on local

```
$ export HUBOT_SLACK_TOKEN=abc123
$ export HUBOT_DIALOGUE_APIKEY=def456
$ npm install
$ npm start
```

## Run on docker

```
$ cd docker
$ docker build -t tag_name ./
$ docker run -it -e "HUBOT_SLACK_TOKEN=abc123" -e "HUBOT_DIALOGUE_APIKEY=def456" tag_name
```
