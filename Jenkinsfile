pipeline {
    agent { label 'terraform' }
    environment {
        AWS_DEFAULT_REGION = 'eu-west-1'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                dir('CICDInfra/Project3-ALB') {
                    script {
                        def backendFile = ''
                        if (env.BRANCH_NAME == 'prod') { backendFile = 'backend-prod.conf' }
                        else if (env.BRANCH_NAME == 'stage') { backendFile = 'backend-stage.conf' }
                        else { backendFile = 'backend-dev.conf' }                        
                        sh """
                                terraform init -backend-config=${backendFile} -input=false -reconfigure
                        """


                    }
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                dir('CICDInfra/Project3-ALB') {
                    script {
                        def envFile = ''
                        if (env.BRANCH_NAME == 'prod') { envFile = 'prod.tfvars' }
                        else if (env.BRANCH_NAME == 'stage') { envFile = 'stage.tfvars' }
                        else { envFile = 'dev.tfvars' }
                        sh "terraform plan --var-file=${envFile} -out=tfplan"
                    }
                }
            }
        }
        stage('Terraform Apply') {
            when {
                anyOf {
                    branch 'dev'
                    branch 'stage'
                    branch 'prod'
                }
            }
            steps {
                input message: "Apply changes to ${env.BRANCH_NAME}?"
                dir('CICDInfra/Project3-ALB') {
                    sh """
                        terraform apply -auto-approve tfplan
                    """
                }
            }
        }
    }
    post {
        always {
            dir('CICDInfra/Project3-ALB') {
                script {
                    sh "terraform output || true"
                }
            }
        }
    }
}
