pipeline {
    agent any

    tools {
        maven 'MAVEN3.9' 
        jdk 'JDK17'
    }

    environment {
        IMAGE_NAME = "java-demo"
    }

    stages {

        stage('Build with Maven (Docker)') {
            steps {
                echo 'Building ...'
                sh 'mvn clean compile'
            }
        }

        stage('Test'){
            steps {
                echo 'Running tests ...'
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                echo 'Packaging JAR/WAR...'
                sh 'mvn package -DskipTests'
            }
        }

        stage('Verify Build') {
            steps {
                sh '''
                echo "Checking target folder..."
                ls -l target/
                '''
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker image...'
                script {
                    def tag ="${env.BUILD_NUMBER}"
                    sh """
                    docker build -t ${IMAGE_NAME}:${tag} .
                    docker tag ${IMAGE_NAME}:${tag} ${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                    sh '''
                    echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin
                    docker tag java-demo:latest $DOCKERHUB_USERNAME/java-demo:latest
                    docker push $DOCKERHUB_USERNAME/java-demo:latest
                    '''
                }
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