
pipeline {
    agent any
    stages {
        stage(' Test App ') {
            steps {
                script {
                    sh "echo \"my-region = \\\" \${region}\\\" \"  > terraform.tfvars "
                    sh "echo \"my-access-key = \\\" \${access_key}\\\" \"  >> terraform.tfvars "
                    sh "echo \"my-secret-key = \\\" \${secret_key}\\\" \"  >> terraform.tfvars "
                    sh "echo \"session-token = \\\" \${session_token}\\\" \"  >> terraform.tfvars "
                    sh "echo \"vpc_CIDR = \\\" \${vpc_CIDR}\\\" \"  >> terraform.tfvars "
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
