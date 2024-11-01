pipeline {
    agent any
    environment {
        nodeimage = "node-app"
        nodeappcont = "node_app_container"
        networkname = "nodejsnetwork"
    }
    stages {
        stage('Cleanup') {
            steps {
                echo "Running cleanup script"
                sh 'chmod +x cleanup.sh'
                sh './cleanup.sh'
            }
        }

        stage('Create Network') {
            steps {
                echo 'Creating Docker network'
                sh "docker network create NodeNet || true"
            }
        }

        stage('Build Node.js App Image') {
            steps {
                echo 'Building Node.js app image'
                sh "docker build -t nodeimage:${JOB_NAME} ."
            }
        }

        stage('Run Node.js App Container') {
            steps {
                echo "Running Node.js app container"
                sh "docker run -d --network NodeNet --name nodeappcont nodeimage"
            }
        }
    }
 }