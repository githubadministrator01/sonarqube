def repo = "https://SonarSource.github.io/helm-chart-sonarqube"

pipeline {
    agent any
    
    options {
        ansiColor('xterm')
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')
        timestamps()
    }

    environment {
        KUBECONFIG = credentials('kubeconfig')
    }

    parameters {
        booleanParam defaultValue: false, description: 'Run in dry_run mode e.g --dry-run', name: 'dry_run'
        string defaultValue: 'sonarqube-dce', description: 'k8s namespace to deploy to', name: 'namespace'
    }

    stages{		
        stage("Validate kubectl and helm installation") {
            steps {
                sh """
                    helm version
                    kubectl version
                    kubectl get no
                """
            }
        }
        stage("add Sonar repo") {
            steps {
                sh """
                    helm repo add sonarqube ${repo}
                    helm repo update
                """
            }
        }
        stage("Run in dry-run mode") {
            steps {
                script {
                    if (params.dry_run) {
                        sh "helm upgrade -i -n${params.namespace} sonarqube-dce -f sonar-values.yaml sonarqube-dce/ --dry-run"
                    } 
                }
            }
        }
	    stage("Deploy Sonar") {
            input {
                message 'Do you want to deploy?'
                id 'helm_deployment'
                ok 'Yes?'
            }
            steps {
                sh "helm upgrade -i -n${params.namespace} sonarqube-dce -f sonar-values.yaml sonarqube-dce/"
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            sh "kubectl get all -n${params.namespace}"
        }
    }
}
