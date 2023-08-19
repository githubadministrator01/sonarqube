High level Overview

Install the required tools:

1. Provision ubuntu virtual machine via vagrant
1.1 Vagrantfile
1.2 Bash script to automate configuration of the server

2. Deploy kube-prometheus-stack
2.1 helm install -nmonitoring prometheus prometheus-community/kube-prometheus-stack

3. Deploy Jenkins
3.1 helm upgrade -i my-jenkins -njenkins -f values-jenkins.yaml jenkins/jenkins
3.2 Custom values provided as per the needs
3.3 Dockerfile
3.4 Custome Docker image for jenkins created and pushed to docker hub (contains helm and kubectl needed for the CI/CD pipeline)
3.5 Prometheus monitoring enabled

4. Deploy Ingress-controller
4.1 helm upgrade -i -nsonarqube-dce ingress-nginx -f ingress-nginx-values.yaml ingress-nginx/ingress-nginx
4.2 Custom values provided as per the needs
4.3 Prometheus monitoring enabled

5. Deploy sonarqube dce
5.1 The deployment is done via Jenkins CI/CD
5.2 Custom values provided as per the needs
5.3 Create tls cert and key
5.4 Create k8s secret to store the selfsigned cert and key for the ingress
5.5 Prometheus monitoring enabled
5.6 Adjusted sonarqube chart templates and values in order to prometheus-operator be able to discover sonarqube podmonitor
5.7 Sonarqube integrated with Jenkins and Sonar code quality analysis enabled against the code repo