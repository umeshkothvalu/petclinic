pipeline{
    agent any
    environment{
        nexusUrl="http://43.205.238.123:8082"
        nexusCredentials="nexus"
        registryName="petclinic"
        gitUrl="https://github.com/umeshkothvalu/petclinic.git"
        image=""
    }
    stages{
        stage("Clone.."){
            steps{
                echo "Cloning code from git.."
                git gitUrl
            }
        }

        stage("Build Archive"){
            steps{
                echo "Building code"
                sh "mvn clean package"
            }

        }

        stage("Buid Image.."){
            steps{
                echo "Building Image"
                script{
                image = docker.build registryName + ":$BUILD_NUMBER"
                }

            }
        }

        stage("Push Image"){

            steps{
                echo "Pushin Image to registry"
                script{
                    docker.withRegistry( nexusUrl , nexusCredentials ){
                        image.push()
                    }
                }
            }
        }

        stage("Remove Local Image"){
            steps{
               // sh "docker rmi $registry:$BUILD_NUMBER"
                 echo "Removing Images"
            }
        }


    }
}
