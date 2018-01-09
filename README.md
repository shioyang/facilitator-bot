# facilitator-bot

It's a slack bot.

Reply a comment for posted URL articles.

## Prerequisite

1. Add Hubot to your slack workspace. And, keep the API Token as HUBOT_SLACK_TOKEN.
2. Create an account for docomo Developer support, apply an app, and keep API key for dialogue API as HUBOT_DIALOGUE_APIKEY.

### Run on local

```
$ export HUBOT_SLACK_TOKEN=abc123
$ export HUBOT_DIALOGUE_APIKEY=def456
$ npm install
$ npm start
```

### Run on docker

```
$ cd docker
$ docker build -t tag_name ./
$ docker run -it -e "HUBOT_SLACK_TOKEN=abc123" -e "HUBOT_DIALOGUE_APIKEY=def456" tag_name
```
