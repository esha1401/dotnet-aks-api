pipeline {
    agent any

    environment {
        ACR_NAME = 'integratedacr0103'
        AZURE_CREDENTIALS_ID = 'azure-service-principal'
        ACR_LOGIN_SERVER = "${ACR_NAME}.azurecr.io"
        IMAGE_NAME = 'api-kubernetes0103'
        IMAGE_TAG = 'latest'
        RESOURCE_GROUP = 'rg-integrated-aks'
        AKS_CLUSTER = 'integratedaks010'
        TF_WORKING_DIR = 'Terraform'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/esha1401/dotnet-aks-api.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %ACR_LOGIN_SERVER%/%IMAGE_NAME%:%IMAGE_TAG% -f docker&kubernetes/Dockerfile docker&kubernetes"
            }
        }

       stage('Terraform Init') {
            steps {
                withCredentials([azureServicePrincipal(credentialsId: AZURE_CREDENTIALS_ID)]) {
                    bat "terraform init"
                    bat "terraform paln -out=tfplan"
                    bat "terraform apply -auto-approve tfplan"
                    
                }
            }
        }

            stage('Login to ACR') {
            steps {
                bat "az acr login --name %ACR_NAME%"
                bat "docker push %ACR_LOGIN_SERVER%/%IMAGE_NAME%:%IMAGE_TAG%"
                bat "kubectl apply -f deployment.yml"
            }
        }
    }

        

    post {
        success {
            echo 'All stages completed successfully!'
        }
        failure {
            echo 'Build failed.'
        }
    }
}
