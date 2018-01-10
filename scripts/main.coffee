libxmljs = require 'libxmljs'

###
  docomo dialogue API
    https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=dialogue&p_name=api_usage_scenario
###
dialogue_api = "https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue?APIKEY=" + process.env.HUBOT_DIALOGUE_APIKEY


module.exports = (robot) ->


  robot.hear /hello/i, (res) ->
    res.send "Hello!"


  robot.hear /(h?ttps?:\/\/[-a-zA-Z0-9@:%_\+.~#?&\/=]+)/i, (msg) ->
    console.log "[facilitator] URL: #{msg.match[1]}"

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

        console.log "[facilitator] Got #{msg.match[1]}"

        xmlDoc = libxmljs.parseHtmlString(body)
        title = xmlDoc.get('//title').text().trim()

        if title
          console.log "[facilitator]   Title: #{title}"

          obj =
            utt: ""
            age: "30"

          if title
            title = title.split('|')[0]
            obj.utt = title.trim() if title

          data = JSON.stringify(obj)
          robot.http(dialogue_api)
            .header('Content-Type', 'application/json')
            .post(data) (err, res, body) ->
              if err
                msg.send "Encountered an error :( #{err}"
                return

              body_obj = JSON.parse body
              # Wait for wait_sec sec
              wait_sec_list = [20, 30, 40, 50]
              wait_sec = msg.random wait_sec_list
              console.log "wait #{wait_sec} sec..."
              setTimeout ->
                msg.send "#{body_obj.utt}" if body_obj.utt
              , wait_sec * 1000


