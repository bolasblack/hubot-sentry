# Description
#   A hubot script to support sentry-webhooks.
#
# Webhook:
#   POST /hubot/sentry
#
# Author:
#   c4605 <bolasblack@gmail.com>

_ = require 'lodash'

module.exports = (robot) ->
  robot.router.post '/hubot/sentry', (req, res) ->
    room = req.param 'room'
    type = req.param 'type'

    paramNames = 'project_name url level message'.split ' '
    params = _.zipObject paramNames, paramNames.map(req.param.bind req)

    envelope = user: {type: type}
    envelope.room = envelope.user.room = room

    template = "Project \"${project_name}\" triggered a new ${level}, message: \"${message}\", detail: \"${url}\""

    robot.send envelope, _.template(template) params
    res.status(201).end 'OK'
