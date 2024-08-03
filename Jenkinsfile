
pipeline {
    agent any
    stages {
        stage(' Test App ') {
            steps {
                script {
                    sh "echo \"my-region = \${region}\"  > terraform.tfvars "
                    sh "echo \"my-access-key = \${access-key}\"  >> terraform.tfvars "
                    sh "echo \"my-secret-key = \${secret-key}\"  >> terraform.tfvars " 
                }
            }
        }
        stage(' Test App 2 ') {
            steps {
                script {
                    sh "cat terraform.tfvars" 
                }
            }
        }
        
    }   
}
