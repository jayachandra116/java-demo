pipeline {
    agent any

    tools {
        maven 'MAVEN3'
        jdk 'JDK21'
    }

    environment {
        IMAGE_NAME = "java-demo"
    }

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/jayachandra116/java-demo.git'
            }
        }
        stage('Build with Maven (Docker)') {
            agent {
                docker {
                    image 'maven:3.9.6-eclipse-temurin-21'
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

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                    sh '''
                    echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin
                    docker tag $IMAGE_NAME $DOCKERHUB_USERNAME/$IMAGE_NAME:latest
                    docker push $DOCKERHUB_USERNAME/$IMAGE_NAME:latest
                    '''
                }
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