#!/bin/bash

docker stop test
docker rm test
cd /home/gossart/camomile-web-frontend
git pull
docker rmi web-dev
docker build -t web-dev .
docker run -d -p 8080:8070 -e CAMOMILE_API=http://vmjoker:32781 -e CAMOMILE_LOGIN=admin -e CAMOMILE_PASSWORD=p455w0rd --name test web-dev

