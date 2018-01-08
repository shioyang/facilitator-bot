
FROM node:9.3

# update sources list
RUN apt-get clean
RUN apt-get update

# install basic commands
#   -q  Loggable output - no progress indicator
#   -y  Assume Yes to all queries and do not prompt
RUN npm install -g coffee-script

# clone facilitator-bot
RUN git clone https://github.com/shioyang/facilitator-bot.git

# get required node modules
RUN npm install

# set env
ENV HUBOT_SLACK_TOKEN=dummy
ENV HUBOT_DIALOGUE_APIKEY=dummy

#CMD npm start

######
# Should replace these two enviroment variables.
#   > docker run -e "HUBOT_SLACK_TOKEN=xxxxxxxxxx" -e "HUBOT_DIALOGUE_APIKEY=xxxxxxxxxx"
######
