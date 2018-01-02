
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
          return

        if res.statusCode isnt 200
          msg.send "Request didn't come back HTTP 200 :( #{res.statusCode}"
          return

        msg.send "Got #{msg.match[1]}"

