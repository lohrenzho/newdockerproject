pipeline { 
    environment { 
        registry = "lohrenzho/newrepo" 
        registryCredential = 'dockerhub'
        dockerImage = '' 
    }
    agent any 
    stages { 
        stage('Cloning our Git') { 
            steps { 
                git 'https://github.com/lohrenzho/newdockerproject.git' 
            }
        } 
        stage('Building image Docker') { 
            steps { 
                script { 
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 
                }
            } 
        }
        stage('Deploy image to Dockerhub') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push()
                        dockerImage.push('latest') 
                    }
                }
            }
        } 
        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        }
        stage('Run container on ECS') { 
            steps { 
                withAWS(region:'us-east-1', credentials:'aws-cred' ) {
               sh 'aws ecs update-service --cluster ecs-cluster --service ecs-service --task-definition ecs-td --force-new-deployment'
            }
            }
        }
         
    }
}
