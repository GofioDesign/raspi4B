# perform docker installation

## Uninstall previous versions
sudo apt-get remove docker docker-engine docker.io containerd runc
## Setup repository
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
## Install docker enging
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

##Do post install
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world

## Configure Docker to start on boot with systemd
sudo systemctl enable docker.service
sudo systemctl enable containerd.service