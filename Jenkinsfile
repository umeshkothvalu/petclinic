pipeline {
   agent any
  
   stages {
      stage('getscm') {
         steps {
               git credentialsId: 'git-cred', url: 'https://github.com/nareshkotari/spring3-mvc-maven-xml-hello-world.git'
          
         }
      }
         
     stage('build') {
          steps{
                  sh 'mvn  clean package'
             }
         }
    }
}
