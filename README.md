High level Overview

Install the required tools:

1. Provision ubuntu virtual machine via vagrant
Vagrantfile
Bash script to automate configuration of the server

2. Deploy kube-prometheus-stack
helm install -nmonitoring prometheus prometheus-community/kube-prometheus-stack

3. Deploy Jenkins
helm upgrade -i my-jenkins -njenkins -f values-jenkins.yaml jenkins/jenkins
Custom values provided as per the needs
Dockerfile
Custome Docker image for jenkins created and pushed to docker hub (contains helm and kubectl needed for the CI/CD pipeline)
Prometheus monitoring enabled

4. Deploy Ingress-controller
helm upgrade -i -nsonarqube-dce ingress-nginx -f ingress-nginx-values.yaml ingress-nginx/ingress-nginx
Custom values provided as per the needs
Prometheus monitoring enabled

5. Deploy sonarqube dce
The deployment is done via Jenkins CI/CD
Custom values provided as per the needs
Create tls cert and key
Create k8s secret to store the selfsigned cert and key for the ingress
Prometheus monitoring enabled
Adjusted sonarqube chart templates and values in order to prometheus-operator be able to discover sonarqube podmonitor
Sonarqube integrated with Jenkins and Sonar code quality analysis enabled against the code repo