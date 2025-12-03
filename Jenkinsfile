pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Sandhyagito/Jenkins-CI-CD-Pipeline-for-a-Web-Application.git'
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Deploys the HTML page using a Docker container with NGINX
                    sh '''
                        docker run --name Sandhya-Webserver -d -p 8081:80 -v "$(pwd):/usr/share/nginx/html" nginx
                    '''
                }
            }
        }
    }
}
