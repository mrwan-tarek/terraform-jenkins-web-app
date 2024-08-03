
pipeline {
    agent any
    stages {
        stage(' Test App ') {
            steps {
                script {
                    sh """echo "my-region = ${region}"  > terraform.tfvars 
                          echo "my-access-key = ${access-key}"  >> terraform.tfvars 
                          echo "my-secret-key = ${secret-key}"  >> terraform.tfvars """
                    sh "cat terraform.tfvars" 
                }
            }
        }
        
    }   
}
