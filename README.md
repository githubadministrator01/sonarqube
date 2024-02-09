# High level Overview

## Install the required tools:

1. Provision Ubuntu virtual machine via vagrant
- Vagrantfile created to provision Ubuntu VM
- Bash script to automate configuration of the server
2. Deploy kube-prometheus-stack
- helm install -nmonitoring prometheus prometheus-community/kube-prometheus-stack
3. Deploy Jenkins
- helm upgrade -i my-jenkins -njenkins -f values-jenkins.yaml jenkins/jenkins
- Custom values provided as per the needs
- Custom Jenkins Dockerfile created
- Custome Docker image for jenkins created and pushed to docker hub (contains helm and kubectl installed as they are needed for the CI/CD pipeline)
- Prometheus monitoring enabled
4. Deploy Ingress-controller
- helm upgrade -i -nsonarqube-dce ingress-nginx -f ingress-nginx-values.yaml ingress-nginx/ingress-nginx
- Custom values provided as per the needs
- Prometheus monitoring enabled
5. Deploy sonarqube-dce
- The deployment is done via Jenkins CI/CD
- Custom values provided as per the needs
- Create tls certificate and key
- Create Kubernetes secret to store the self-signed certificate and key for the ingress
- Prometheus monitoring enabled
- Adjusted sonarqube chart template "prometheus-podmonitor.yaml" and values in order to prometheus-operator be able to discover sonarqube podmonitor
