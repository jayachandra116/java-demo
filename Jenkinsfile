pipeline {
    agent any

    tools {
        maven 'MAVEN3.9' // Name used in Global Tool Configuration
        jdk 'JDK17'      // Name used in Global Tool Configuration
    }

    environment {
        IMAGE_NAME = "java-demo"
    }

    stages {

        stage('Build with Maven (Docker)') {
            steps {
                sh 'mvn clean package'
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