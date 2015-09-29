#!/bin/bash

## Stop and restart frontend from Git sources

docker stop web-dev
docker rm web-dev
cd /home/gossart/camomile-web-frontend
git pull
docker rmi klm8/camomile-web-frontend-dev
docker build -t klm8/camomile-web-frontend-dev .
docker run -d --restart=always -p 8080:8070 -e CAMOMILE_API=http://vmjoker.limsi.fr:32781 -e CAMOMILE_LOGIN=admin -e CAMOMILE_PASSWORD=p455w0rd --name web-dev klm8/camomile-web-frontend-dev

