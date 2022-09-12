pipeline{
    agent any
    environment{
        nexusUrl="http://43.205.238.123/:8082"
        //nexusCredentials="nexus"
        registryName="petclinic"
        gitUrl="https://github.com/umeshkothvalu/petclinic.git"
        image=""
         // This can be nexus3 or nexus2
        NEXUS_VERSION = "nexus3"
        // This can be http or https
        NEXUS_PROTOCOL = "http"
        // Where your Nexus is running. 'nexus-3' is defined in the docker-compose file
        NEXUS_URL = "43.205.238.123/:8081"
        // Repository where we will upload the artifact
        NEXUS_REPOSITORY = "warfiles"
        // Jenkins credential id to authenticate to Nexus OSS
        NEXUS_CREDENTIAL_ID = "nexus"




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
        stage("Push Archive"){
         steps{
            script {
                    // Read POM xml file using 'readMavenPom' step , this step 'readMavenPom' is included in: https://plugins.jenkins.io/pipeline-utility-steps
                    pom = readMavenPom file: "pom.xml";
                    // Find built artifact under target folder
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                    // Print some info from the artifact found
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    // Extract the path from the File found
                    artifactPath = filesByGlob[0].path;
                    // Assign to a boolean response verifying If the artifact name exists
                    artifactExists = fileExists artifactPath;
                    
                    if(artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                        
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: pom.version,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                // Artifact generated such as .jar, .ear and .war files.
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging],

                                // Lets upload the pom.xml file for additional information for Transitive dependencies
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );

                    } else {
                        error "*** File: ${artifactPath}, could not be found";
                    }
                }
         }
        }
        stage("Push Image"){

            steps{
                echo "Pushin Image to registry"
                script{
                    docker.withRegistry( nexusUrl , NEXUS_CREDENTIAL_ID ){
                        image.push()
                    }
                }
            }
        }

        stage("Remove Local Image"){
            steps{
                sh "docker rmi $registryName:$BUILD_NUMBER"
                 echo "Removing Images"
            }
        }


    }
}
