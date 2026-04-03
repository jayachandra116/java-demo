pipeline {
    agent any

    environment {
        IMAGE_NAME = "java-demo"
    }

    stages {
        stage('Build with Maven (Docker)') {
            agent {
                docker {
                    image 'maven:3.9.6-eclipse-temurin-17'
                }
            }
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker rm -f java-demo-container || true
                docker run -d -p 8081:8080 --name java-demo-container $IMAGE_NAME
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}