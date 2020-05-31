dependency 'vrp'

ui_page "html/index.html"

files {
  "html/index.html",
  "html/inc/styling/js/index.js",
  "html/inc/styling/js/handling.js",
  "html/inc/styling/css/index.css"
}

client_script {
  'client.lua'
}

server_script {
  '@vrp/lib/utils.lua',
  'server.lua'
}
