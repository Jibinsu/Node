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

        stage('Build NGINX Image') {
            steps {
                sh "echo 'Building nginx image'" 
                sh 'docker build -t mynginx -f Dockerfilenginx .'
            }
        }

        stage('Build Node.js App Image') {
            steps {
                echo 'Building Node.js app image'
                sh "docker build -t nodeimage:${JOB_NAME} ."
            }
        }

        stage('Run NGINX Container') {
            steps {
                echo "Running NGINX container"
                sh "docker run -d -p 80:80 --network NodeNet --name mynginx mynginx"
            }
        }

        stage('Run Node.js App Container') {
            steps {
                echo "Running Node.js app container"
                sh "docker run -d --network NodeNet --name nodeappcont nodeimage:${JOB_NAME}"
            }
        }
    }
 }
