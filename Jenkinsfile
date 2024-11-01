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



        stage('Security Scan with Trivy') {
            steps {
                echo "Running Trivy security scan"
                sh "trivy fs -f json -o trivy_results.json ."
            }
            post {
                always {
                    archiveArtifacts artifacts: 'trivy_results.json', onlyIfSuccessful: true
                }
            }
        }

        stage('Run Tests') {
            steps {
                echo 'Running Unit Tests'
                script {
                    catchError(buildResult: "UNSTABLE", stageResult: "UNSTABLE") {
                        sh '''
                        # Set up virtual environment
                        python3 -m venv .venv

                        # Activate virtual environment
                        . .venv/bin/activate

                        # Install dependencies
                        pip install -r requirements.txt

                        # Run tests
                        python3 -m unittest test_node_app.py

                        # Deactivate virtual environment
                        deactivate
                        '''
                    }
                }
            }
        }
    }
}
