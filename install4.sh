## install portainer
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

## install nginx proxy manager
docker compose up -d -f /nmp/docker-compose.yml

## install ddclien behind npm
docker compose up -d -f /ddclient/docker-compose.yml

git clone https://github.com/GofioDesign/wordpress-nginx-docker-armv7.git
mv wordpress-nginx-docker-armv7/ wp1/
docker compose up -d -f /wp1/docker-compose.yml
