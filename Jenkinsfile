
pipeline {
    agent any
    stages {
        stage(' Test App ') {
            steps {
                script {
                    sh """
                    cat <<EOF > terraform.tfvars
                    my-region = $region
                    my-access-key = $access-key
                    my-secret-key = $secret-key
                    EOF"""
                    sh "cat terraform.tfvars" 
                }
            }
        }
        
    }   
}
