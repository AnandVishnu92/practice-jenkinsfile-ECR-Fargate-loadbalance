pipeline {
    agent any

    environment {
        DOCKER_HOST_USER = "ubuntu"
        DOCKER_HOST_IP = "44.197.250.44"
        IMAGE_NAME = "Ngnix-jenkins"
        IMAGE_TAG = "test1"
            }
    
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/AnandVishnu92/practice-jenkinsfile-ECR-Fargate-loadbalance.git'
            }
        }
      stage('Copy Files to Docker Server') {
            steps {
                sshagent(['docker-ssh-key']) {
                    sh """
                    scp -o StrictHostKeyChecking=no -r ./* ${DOCKER_HOST_USER}@${DOCKER_HOST_IP}:/home/${DOCKER_HOST_USER}/app/
                    """
                }
            }
        }
        stage('Build Docker Image on Remote Host') {
            steps {
                sshagent(['docker-ssh-key']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${DOCKER_HOST_USER}@${DOCKER_HOST_IP} "
                    cd /home/${DOCKER_HOST_USER}/app &&
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} . &&
                    docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
                    "
                    """
                }
            }
        }
        stage('Optional: Run Test Container') {
            steps {
                sshagent(['docker-ssh-key']) {
                    sh """
                    ssh ${DOCKER_HOST_USER}@${DOCKER_HOST_IP} "
                    docker rm -f test-container || true
                    docker run -d --name test-container -p 8080:80 ${IMAGE_NAME}:${IMAGE_TAG}
                    sleep 5
                    docker rm -f test-container
                    "
                    """
                }
            }
        }
    }

    post {
        success {
            echo "🚀 Docker image built on remote EC2 successfully!"
        }
        failure {
            echo "❌ Build failed — check logs."
        }
    }
}
