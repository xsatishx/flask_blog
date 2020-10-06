pipeline {
  agent any
   stages {
        // Stage 1 : Clone the git Repo
        stage('Cloning Git Repo') {
            steps {
            //git 'https://github.com/xsatishx/CICD-demo.git'
            git 'https://github.com/xsatishx/flask_blog.git'
            sh 'pwd'
            }
        }
        
        // Stage 2 : Perform static code analysis using SonarQube
        stage('Code analysis') {
            environment {
              scannerHome = tool 'sonar-scanner'
            }
            steps {
              withSonarQubeEnv('Sonar') {
               sh "${scannerHome}/bin/sonar-scanner"
              }
            }
        }
       
       // Stage 3: Build a Docker Image
       stage('Build Docker Image') {
            steps {
             sh "sudo docker image build . --tag='devops-repo:1.0'"
             sh "image_name=\$(sudo docker images | awk '{print \$3}' | awk 'NR==2') && sudo docker tag \$image_name 065603381703.dkr.ecr.us-west-2.amazonaws.com/devops-repo"
            }
        }
        
       // Stage 4: Push the image to registry    
       stage('Push to Registry') {
            steps {
             sh "sudo aws ecr get-login-password --region us-west-2 |sudo docker login --username AWS --password-stdin 065603381703.dkr.ecr.us-west-2.amazonaws.com"
             sh "sudo docker push 065603381703.dkr.ecr.us-west-2.amazonaws.com/devops-repo:1.0"

            }
        }
        
        // Stage 5: Do a YAML static test
         stage('Kubernetes static Test') {
            steps {
             sh "kubeval demoapp.yaml"
             sh "conftest test demoapp.yaml"
            }
        }
        
        // Stage 6: Deploy to test
         stage('Depoy to UAT') {
            steps {
             sh "sudo kubectl create -f demoapp.yaml"
             sh "sleep 10s"
             sh "echo 'IP : 34.215.146.71'"
             sh "sudo kubectl get svc | grep flask-service"
            }
        }
 }
}
