
module.exports = (robot) ->

  robot.hear /(h?ttps?:\/\/[-a-zA-Z0-9@:%_\+.~#?&\/=]+)/i, (msg)->
    robot.http(msg.match[1])
      .get() (err, res, body) ->
        if err
          res.send "Encountered an error :( #{err}"
          return

        if res.statusCode isnt 200
          res.send "Request didn't come back HTTP 200 :( #{res.statusCode}"
          return

        res.send "Got #{msg.match[1]}"
