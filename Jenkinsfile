pipeline {
    agent any

    environment {
        IMAGE_NAME = "Ngnix-jenkins"
        IMAGE_TAG = "test1"
            }
    
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/AnandVishnu92/practice-jenkinsfile-ECR-Fargate-loadbalance.git'
            }
        }

     stage('Build Docker Image') {
            steps {
                sh """
                docker build -t ${IMAGE_NAME}:${IMAGE_TAG}.
                """
            }
        }
      stage('Run Container (Optional Test)') {
            steps {
                sh """
                echo "Running Docker Container to Validate"
                docker run -d -p 8080:80 --name temp-container ${IMAGE_NAME}:${IMAGE_TAG}
                sleep 5
                docker rm -f temp-container
                """
            }
        }
    }

    post {
        success {
            echo "🎉 Docker build completed successfully"
        }
        failure {
            echo "❌ Docker build failed"
        }
            }
        }
