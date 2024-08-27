
pipeline {
    agent any
    stages {
        stage(' creating .tfvars file ') {
            when { environment name: 'job_type', value: 'build' }
            steps {
                script {
                    sh "echo \"my-region = \\\"\${region}\\\" \"  > terraform.tfvars "
                    sh "echo \"aws_profile = \\\"\${aws_profile}\\\" \"  >> terraform.tfvars "
                    sh "echo \"session-token = \\\"\${session_token}\\\" \"  >> terraform.tfvars "
                    sh "echo \"vpc_CIDR = \\\"\${vpc_CIDR}\\\" \"  >> terraform.tfvars "
                    sh "echo \"public_subnet_cidr_block_1 = \\\"\${public_subnet_1_CIDR_block}\\\" \"  >> terraform.tfvars "
                    sh "echo \"public_subnet_cidr_block_2 = \\\"\${public_subnet_2_CIDR_block}\\\" \"  >> terraform.tfvars "
                    sh "echo \"private_subnet_cidr_block_1 = \\\"\${private_subnet_1_CIDR_block}\\\" \"  >> terraform.tfvars "
                    sh "echo \"private_subnet_cidr_block_2 = \\\"\${private_subnet_2_CIDR_block}\\\" \"  >> terraform.tfvars "
                    sh "echo \"private_subnet_cidr_block_3 = \\\"\${private_subnet_3_CIDR_block}\\\" \"  >> terraform.tfvars "
                    sh "echo \"private_subnet_cidr_block_4 = \\\"\${private_subnet_4_CIDR_block}\\\" \"  >> terraform.tfvars "
                    sh "echo \"ami = \\\"\${AMI_id}\\\" \"  >> terraform.tfvars "
                    sh "echo \"instance_type = \\\"\${instance_type}\\\" \"  >> terraform.tfvars "
                    sh "echo \"key_pair = \\\"\${key_pair_name}\\\" \"  >> terraform.tfvars "
                    sh "echo \"min_size = \\\"\${min_size_ASG}\\\" \"  >> terraform.tfvars "
                    sh "echo \"max_size = \\\"\${max_size_ASG}\\\" \"  >> terraform.tfvars "
                    sh "echo \"desired_size = \\\"\${desired_size_ASG}\\\" \"  >> terraform.tfvars "
                    sh "echo \"db_instance_type = \\\"\${RDS_instance_type}\\\" \"  >> terraform.tfvars "
                }
            }
        }
        stage(' initiate terraform ') {
            when { environment name: 'job_type', value: 'build' }
            steps {
                script {
                    sh "terraform init "
                    //sh "aws s3 cp s3://terraform-jenkins-app/terraform state/ `pwd` --recursive --profile ${aws_profile}"
                }
            }
        }
        stage(' applying terraform infrastructure ') {
            when { environment name: 'job_type', value: 'build' }
            steps {
                script {
                    sh "cat /home/mrwan/.aws/credentials"
                    sh "terraform apply --auto-approve"
                    //sh "aws s3 cp terraform.tfstate s3://terraform-jenkins-app/terraform state/ --profile ${aws_profile}"
                }
            }
        }
        stage(' trying ') {
            when { environment name: 'job_type', value: 'destroy' }
            steps {
                script {
                    sh "terraform init "
                   // sh "aws s3 cp s3://terraform-jenkins-app/terraform state/terraform.tfstate `pwd` --recursive --profile ${aws_profile}"
                    sh "terraform destroy --auto-approve"
                    //sh "aws s3 cp terraform.tfstate s3://terraform-jenkins-app/terraform state/ --profile ${aws_profile}"

                }
            }
        } 
        
    }   
}
