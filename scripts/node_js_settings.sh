#!/bin/bash
mkdir /home/kafkan223/hiddengames
cd /home/kafkan223/hiddengames
npm install -g yarn
npm init /home/kafkan223/hiddengames
npm install --prefix /home/kafkan223/hiddengames express
rm /home/kafkan223/hiddengames/server.js
touch /home/kafkan223/hiddengames/server.js
echo -e "const express = require('express')">>/home/kafkan223/hiddengames/server.js
echo "const app = express()">>/home/kafkan223/hiddengames/server.js
echo "const port = 3000">>/home/kafkan223/hiddengames/server.js

echo -e "app.get('/', (req, res) => res.send('Hello World!'))">>/home/kafkan223/hiddengames/server.js

echo 'app.listen(port, () => console.log(`Example app listening on port ${port}!`))'>>/home/kafkan223/hiddengames/server.js
node /home/kafkan223/hiddengames/server.js&
