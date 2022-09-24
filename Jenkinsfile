pipeline {
   agent any  
   stages {
      stage('getscm') {
         steps {
               git credentialsId: 'git-cred', url: 'https://github.com/umeshkothvalu/petclinic.git'
          
         }
      }         
     stage('build') {
          steps{
                  sh 'mvn  clean package'
             }
         }
    }
}
