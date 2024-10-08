from node:12.2.0-alpine
workdir app
copy . .
run npm install
expose 3000
cmd ["node", "server.js"]
