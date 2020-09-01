#!/bin/bash
mkdir /var/www/hiddengames
cd /var/www/hiddengames
npm install -g yarn
sudo chown -R www-data:www-data /var/www/hiddengames
npm init react-app /var/www/hiddengames
npm install --prefix /var/www/hiddengames express
npm install --prefix /var/www/hiddengames body-parser
npm install --prefix /var/www/hiddengames mariadb
rm /var/www/hiddengames/server.js
touch /var/www/hiddengames/server.js
echo "const express = require('express')">>/var/www/hiddengames/server.js
echo "const bodyParser = require('body-parser')">>/var/www/hiddengames/server.js
echo "const mariadb = require('mariadb')">>/var/www/hiddengames/server.js
echo "const pool = mariadb.createPool({">>/var/www/hiddengames/server.js
echo "        host: 'localhost',">>/var/www/hiddengames/server.js
echo "        user: 'exaltedone',">>/var/www/hiddengames/server.js
echo "        password: 'pannacotta',">>/var/www/hiddengames/server.js
echo "	database: 'hiddenvault232',">>/var/www/hiddengames/server.js
echo "        connectionLimit: 5">>/var/www/hiddengames/server.js
echo "});">>/var/www/hiddengames/server.js
echo "const app = express()">>/var/www/hiddengames/server.js
echo "const port = 3000">>/var/www/hiddengames/server.js
echo -e "\n">>/var/www/hiddengames/server.js
echo "app.use(">>/var/www/hiddengames/server.js
echo "  bodyParser.urlencoded({">>/var/www/hiddengames/server.js
echo "    extended: true">>/var/www/hiddengames/server.js
echo "  })">>/var/www/hiddengames/server.js
echo ")">>/var/www/hiddengames/server.js
echo "">>/var/www/hiddengames/server.js
echo "app.use(bodyParser.json())">>/var/www/hiddengames/server.js
echo "">>/var/www/hiddengames/server.js
echo "app.use((req, res, next) => {">>/var/www/hiddengames/server.js
echo "  res.header('Access-Control-Allow-Origin', '*');">>/var/www/hiddengames/server.js
echo "  res.header('Access-Control-Allow-Headers', 'Content-Type')">>/var/www/hiddengames/server.js
echo "  res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');">>/var/www/hiddengames/server.js
echo "  next();">>/var/www/hiddengames/server.js
echo "});">>/var/www/hiddengames/server.js
echo "">>/var/www/hiddengames/server.js
echo "async function checkAnswer(response) {">>/var/www/hiddengames/server.js
echo "	const result = await pool.query(\"SELECT * FROM answers WHERE task_id = 1\");">>/var/www/hiddengames/server.js
echo "	console.log(result[0].answer);">>/var/www/hiddengames/server.js
echo "	if (!result[0].answer) {">>/var/www/hiddengames/server.js
echo "		throw new Error('Didnt find the answer');">>/var/www/hiddengames/server.js
echo "	}">>/var/www/hiddengames/server.js
echo "	if (result[0].answer === response) {">>/var/www/hiddengames/server.js
echo "		console.log('true');">>/var/www/hiddengames/server.js
echo "		return (true);">>/var/www/hiddengames/server.js
echo "	} else {">>/var/www/hiddengames/server.js
echo "		console.log('false');">>/var/www/hiddengames/server.js
echo "		return (false);">>/var/www/hiddengames/server.js
echo "	}">>/var/www/hiddengames/server.js
echo "}">>/var/www/hiddengames/server.js
echo "app.use(express.static(__dirname + '/build'));">>/var/www/hiddengames/server.js
echo "app.post('/checktheanswer', async (req, res) => {">>/var/www/hiddengames/server.js
echo "	console.log(req.body.answer)">>/var/www/hiddengames/server.js
echo "	const result = await checkAnswer(req.body.answer);">>/var/www/hiddengames/server.js
echo "	res.json(result);">>/var/www/hiddengames/server.js
echo "});">>/var/www/hiddengames/server.js
echo "app.listen(port, () => console.log(\`Hidden Games app listening on port \${port}!\`))">>/var/www/hiddengames/server.js
