pipeline{
    agent any
    stages{
        stage("init"){
            steps{

                echo "Initializing the application"
            }
         
        }
        stage("build"){
            steps{
                echo "building the application"
            }
            script{
             def test = 2=3 > 6 ? "false" : "true"  
                echo "${test}"
            }
        }
        stage("test"){
            steps{
                echo "Testing the application"
            }
         
        }
        stage("deploy"){
            steps{
                echo "Deploying the application"
            }
         
        }
    }
}
