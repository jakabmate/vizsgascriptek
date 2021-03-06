#!/bin/bash
#Docker engine felrakása
username='ubuntu'
sudo apt-get update
sudo apt-get install nano git apt-transport-https -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo systemctl status docker | grep docker.service
sudo usermod -aG docker $username && echo 'OK'
#Dockerfile léterhozása
cd ~
mkdir Docker
cd Docker
mkdir web
touch Dockerfile
cat <<EOF> Dockerfile
FROM nginx
COPY web /usr/share/nginx/html
RUN cd /usr/share/nginx/html/ && rm *
COPY web /usr/share/nginx/html
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
EOF
#Kész Dockerfile, html oldal beillesztése
touch web/index.html
cat <<EOF> web/index.html
<h1>Sikeres a vizsga!!!</h1>
EOF
#Dockerimage kreálása és futtatása
cd ~
cd Docker
sudo docker build -t nginx .
sudo docker run -p 80:80 -d nginx
