libxmljs = require 'libxmljs'

dialogue_api = "https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue?APIKEY=" + process.env.HUBOT_DIALOGUE_APIKEY


module.exports = (robot) ->

  robot.hear /hello/i, (res) ->
    res.send "Hello! 1"
    res.send "Hello! 2"

  robot.hear /(h?ttps?:\/\/[-a-zA-Z0-9@:%_\+.~#?&\/=]+)/i, (msg) ->
    msg.send "URL: #{msg.match[1]}"

    robot.http(msg.match[1])
      .get() (err, res, body) ->
        if err
          msg.send "Encountered an error :( #{err}"
          return

        if res.statusCode is 302
          msg.send "Request came back HTTP 302. The resource was found, should redirect to the location URL."
          location = res.headers['location'] if res.headers['location']
          if location
            msg.send "  ->> #{location}"
          return

        if res.statusCode isnt 200
          msg.send "Request didn't come back HTTP 200 :( #{res.statusCode}"
          return

        msg.send "Got #{msg.match[1]}"

        xmlDoc = libxmljs.parseHtmlString(body)
        title = xmlDoc.get('//title').text().trim()

        msg.send "  Title: #{title}" if title

        obj =
          utt: ""
          context: ""
          nickname: "Hikari"
          nickname_y: "ヒカリ"
          age: "30"
          place: "東京"

        obj.utt = title if title
        data = JSON.stringify(obj)
        robot.http(dialogue_api)
          .header('Content-Type', 'application/json')
          .post(data) (err, res, body) ->
            if err
              msg.send "Encountered an error :( #{err}"
              return

            body_obj = JSON.parse body
            msg.send "Got #{body_obj.utt}"

