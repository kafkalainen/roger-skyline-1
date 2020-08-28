#!/bin/bash
mkdir /home/kafkan223/hiddengames
cd /home/kafkan223/hiddengames
npm install -g yarn
npm init react-app /home/kafkan223/hiddengames
npm install --prefix /home/kafkan223/hiddengames express
npm install --prefix /home/kafkan223/hiddengames body-parser
npm install --prefix /home/kafkan223/hiddengames mariadb
rm /home/kafkan223/hiddengames/server.js
touch /home/kafkan223/hiddengames/server.js
echo "const express = require('express')">>/home/kafkan223/hiddengames/server.js
echo "const bodyParser = require('body-parser')">>/home/kafkan223/hiddengames/server.js
echo "const mariadb = require('mariadb')">>/home/kafkan223/hiddengames/server.js
echo "const pool = mariadb.createPool({">>/home/kafkan223/hiddengames/server.js
echo "        host: 'localhost',">>/home/kafkan223/hiddengames/server.js
echo "        user: 'exaltedone',">>/home/kafkan223/hiddengames/server.js
echo "        password: 'pannacotta',">>/home/kafkan223/hiddengames/server.js
echo "	database: 'hiddenvault232',">>/home/kafkan223/hiddengames/server.js
echo "        connectionLimit: 5">>/home/kafkan223/hiddengames/server.js
echo "});">>/home/kafkan223/hiddengames/server.js
echo "const app = express()">>/home/kafkan223/hiddengames/server.js
echo "const port = 3000">>/home/kafkan223/hiddengames/server.js
echo -e "\n">>/home/kafkan223/hiddengames/server.js
echo "app.use(">>/home/kafkan223/hiddengames/server.js
echo "  bodyParser.urlencoded({">>/home/kafkan223/hiddengames/server.js
echo "    extended: true">>/home/kafkan223/hiddengames/server.js
echo "  })">>/home/kafkan223/hiddengames/server.js
echo ")">>/home/kafkan223/hiddengames/server.js
echo "">>/home/kafkan223/hiddengames/server.js
echo "app.use(bodyParser.json())">>/home/kafkan223/hiddengames/server.js
echo "">>/home/kafkan223/hiddengames/server.js
echo "app.use((req, res, next) => {">>/home/kafkan223/hiddengames/server.js
echo "  res.header('Access-Control-Allow-Origin', '*');">>/home/kafkan223/hiddengames/server.js
echo "  res.header('Access-Control-Allow-Headers', 'Content-Type')">>/home/kafkan223/hiddengames/server.js
echo "  res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');">>/home/kafkan223/hiddengames/server.js
echo "  next();">>/home/kafkan223/hiddengames/server.js
echo "});">>/home/kafkan223/hiddengames/server.js
echo "">>/home/kafkan223/hiddengames/server.js
echo "async function checkAnswer(response) {">>/home/kafkan223/hiddengames/server.js
echo "	const result = await pool.query(\"SELECT * FROM answers WHERE task_id = 1\");">>/home/kafkan223/hiddengames/server.js
echo "	console.log(result[0].answer);">>/home/kafkan223/hiddengames/server.js
echo "	if (!result[0].answer) {">>/home/kafkan223/hiddengames/server.js
echo "		throw new Error('Didnt find the answer');">>/home/kafkan223/hiddengames/server.js
echo "	}">>/home/kafkan223/hiddengames/server.js
echo "	if (result[0].answer === response) {">>/home/kafkan223/hiddengames/server.js
echo "		console.log('true');">>/home/kafkan223/hiddengames/server.js
echo "		return (true);">>/home/kafkan223/hiddengames/server.js
echo "	} else {">>/home/kafkan223/hiddengames/server.js
echo "		console.log('false');">>/home/kafkan223/hiddengames/server.js
echo "		return (false);">>/home/kafkan223/hiddengames/server.js
echo "	}">>/home/kafkan223/hiddengames/server.js
echo "}">>/home/kafkan223/hiddengames/server.js
echo "app.use(express.static(__dirname + '/build'));">>/home/kafkan223/hiddengames/server.js
echo "app.post('/checktheanswer', async (req, res) => {">>/home/kafkan223/hiddengames/server.js
echo "	console.log(req.body.answer)">>/home/kafkan223/hiddengames/server.js
echo "	const result = await checkAnswer(req.body.answer);">>/home/kafkan223/hiddengames/server.js
echo "	res.json(result);">>/home/kafkan223/hiddengames/server.js
echo "});">>/home/kafkan223/hiddengames/server.js
echo "app.listen(port, () => console.log(\`Hidden Games app listening on port \${port}!\`))">>/home/kafkan223/hiddengames/server.js
