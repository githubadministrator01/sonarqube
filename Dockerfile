FROM jenkins/jenkins

# Install jenkins plugins
RUN jenkins-plugin-cli --plugins git ansicolor timestamper blueocean kubernetes kubernetes-credentials

# Change to root 
USER root

# Install Helm
RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
chmod +x kubectl && \
mv ./kubectl /usr/local/bin/kubectl

# Change to jenkins user again

USER jenkins