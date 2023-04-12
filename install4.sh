## install portainer
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

## install nginx proxy manager
docker network create npm
cd npm
docker compose up -d
cd ..

## install ddclien behind npm
cd ddclient
docker compose -f /ddclient/docker-compose.yml up -d
cd ..

git clone https://github.com/GofioDesign/wordpress-nginx-docker-armv7.git
mv wordpress-nginx-docker-armv7/ wp1/
cd wp1
docker compose up -d
cd ..
echo "go to $host port 9443 to see portainer"
