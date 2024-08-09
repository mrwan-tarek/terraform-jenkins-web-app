
pipeline {
    agent any
    stages {
        stage(' Test App ') {
            steps {
                script {
                    sh "echo \"my-region = \${region}\"  > variables "
                    sh "echo \"my-access-key = \${access_key}\"  >> variables "
                    sh "echo \"my-secret-key = \${secret_key}\"  >> variables "
                    sh "echo \"session-token = \${session_token}\"  >> variables "
                    sh "echo \"vpc_CIDR = \${vpc_CIDR}\"  >> variables "
                    sh "cat variables"
                    sh 'sed \'s/^/\\\" /; s/$/\\\"/\' variables > terraform.tfvars'                    
                    sh "cat terraform.tfvars"
                }
            }
        }
        stage(' Test App 2 ') {
            steps {
                script {
                    sh "terraform init "
                    sh "terraform apply --auto-approve "
                }
            }
        }
        
    }   
}
