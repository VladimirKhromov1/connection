// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.


import "./settings_channel"
import "./vote_channel"
import "./member_vote_channel"
import "./attendance_channel"


const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)
