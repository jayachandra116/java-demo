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
                sh 'docker build -t java-demo .'
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