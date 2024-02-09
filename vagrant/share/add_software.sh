#!/bin/bash

# ******Instal software******
sudo apt update && sudo apt install -y git curl software-properties-common

# *****Add kubeconfig to .kube*****
sudo mkdir -p ~/.kube && \
sudo cp /vagrant/kubeconfig-sonar-dev ~/.kube/kubeconfig-sonar-dev && \
echo 'export KUBECONFIG="${KUBECONFIG}:${HOME}/.kube/config:${HOME}/.kube/kubeconfig-sonar-dev"' >> ~/.bashrc && \
source ~/.bashrc

# ******Instal kubectl and verify it******
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
sudo chmod +x kubectl && \
sudo mv ./kubectl /usr/local/bin/kubectl && \
kubectl version

# ******Instal helm and verify it******
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null && \
sudo apt-get install apt-transport-https --yes && \
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list && \
sudo apt-get update && \
sudo apt-get install helm && \
helm version

# *****Enable helm bash auto completion*****
echo 'source <(helm completion bash)' >> ~/.bashrc

# *****Add kubectl aliases to .bashrc*****
echo 'alias k=kubectl' >> ~/.bashrc && \
echo "alias kcn='kubectl config set-context $(kubectl config current-context) --namespace '" >> ~/.bashrc && \
echo "alias kcu='kubectl config use-context'" >> ~/.bashrc && \
echo "alias kcg='kubectl config get-contexts'" >> ~/.bashrc

# *****Enable kubectl bash auto completion*****
echo 'source <(kubectl completion bash)' >> ~/.bashrc && \
echo 'complete -o default -F __start_kubectl k' >> ~/.bashrc

# *****Make vi default editor*****
echo 'export VISUAL=vim' >> ~/.bashrc && \
echo 'export EDITOR="$VISUAL"' >> ~/.bashrc && \
source ~/.bashrc

# ******Instal docker and verify it******
sudo apt-get update && \
sudo apt-get -y install apt-transport-https \
     ca-certificates \
     redis-tools \
     curl \
     gnupg2 \
     software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; sudo apt-key add /tmp/dkey && \
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
sudo apt-get update && \
sudo apt-get -y install docker-ce
sudo docker version

# *****Change owner on docker.sock*****
sudo chown vagrant:docker /var/run/docker.sock

# *****Print the contexts*****
kcg

# Check docker version
docker version