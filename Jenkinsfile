pipeline {
    agent any
    environment {
        IMAGE_REPO_NAME="log4shell-fgallego"
        //REPLACE XXX WITH YOUR STUDENT NUMBER
        IMAGE_TAG= "tdc1"
        REPOSITORY_URI = "gru.ocir.io/fortinetoraclecloud1/log4shell-fgallego"
        REGISTRY_USERNAME = "fortinetoraclecloud1/fgallego"
        REG_AUTH_TOKEN = credentials('REGISTRY_TOKEN')
        
    }
   
    stages {
                
    
    stage('Clone repository') { 
            steps { 
                script{
                checkout scm
                }
            }
        }  
  
    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}-${env.BUILD_NUMBER}"
        }
      }
    }
   
    // Uploading Docker images into the registry

    stage('Pushing to OCIR') {
     steps{  
         script {
                sh """docker login -u '${REGISTRY_USERNAME}' -p '${REG_AUTH_TOKEN}' gru.ocir.io"""
                sh """docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG}-${env.BUILD_NUMBER} ${REPOSITORY_URI}:$IMAGE_TAG-${env.BUILD_NUMBER}"""
                sh """docker push ${REPOSITORY_URI}:${IMAGE_TAG}-${env.BUILD_NUMBER}"""
         }
        }
      }
      /*stage('SAST'){
            steps {
                 sh 'env | grep -E "JENKINS_HOME|BUILD_ID|GIT_BRANCH|GIT_COMMIT" > /tmp/env'
                 sh 'docker pull registry.fortidevsec.forticloud.com/fdevsec_sast:latest'
                 sh 'docker run --rm --env-file /tmp/env --mount type=bind,source=$PWD,target=/scan registry.fortidevsec.forticloud.com/fdevsec_sast:latest'
            }
        }*/
      stage('Deploy'){
            steps {
                 sh 'sed -i "s/<TAG>/${IMAGE_TAG}-${BUILD_NUMBER}/" deployment.yml'
                 sh 'kubectl apply -f deployment.yml'
                 

            }
        } 
       /*stage('DAST'){
            steps {
                 sh 'env | grep -E "JENKINS_HOME|BUILD_ID|GIT_BRANCH|GIT_COMMIT" > /tmp/env'
                 sh 'docker pull registry.fortidevsec.forticloud.com/fdevsec_dast:latest'
                 sh 'docker run --rm --env-file /tmp/env --mount type=bind,source=$PWD,target=/scan registry.fortidevsec.forticloud.com/fdevsec_dast:latest'
            }
        }*/
    }
}
