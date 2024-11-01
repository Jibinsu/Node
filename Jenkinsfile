pipeline {
    agent any
    environment {
        nodeimage = "MyNodeImage"
        nodeappcont = "node_app_container"

    }
    stages {
        stage('Cleanup') {
            steps {
                echo "Running cleanup script"
                sh 'chmod +x cleanup.sh'
                sh './cleanup.sh'
            }
        }


        stage('Build Node.js App Image') {
            steps {
                echo 'Building Node.js app image'
                sh 'docker build -t node-app .'
            }
        }


        stage('Run Node.js App Container') {
            steps {
                echo "Running Node.js app container"
                sh "docker run -d --network nodejsnetwork --name nodeappcont node-app"
            }
        }


                    }
                }
      