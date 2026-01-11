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
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    script {
                        def backendFile = ''
                        if (env.BRANCH_NAME == 'prod') { backendFile = 'backend-prod.conf' }
                        else if (env.BRANCH_NAME == 'stage') { backendFile = 'backend-stage.conf' }
                        else { backendFile = 'backend-dev.conf' }
                        sh """
                            export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                            export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                            terraform init -backend-config=${backendFile}
                        """
                    }
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                script {
                    def envFile = ''
                    if (env.BRANCH_NAME == 'prod') { envFile = 'prod.tfvars' }
                    else if (env.BRANCH_NAME == 'stage') { envFile = 'stage.tfvars' }
                    else { envFile = 'dev.tfvars' }
                    sh "terraform plan --var-file=${envFile} -out=tfplan"
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
                withCredentials([
                    string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh """
                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                        terraform apply -auto-approve tfplan
                    """
                }
            }
        }
    }
    post {
        always {
            script {
                sh "terraform output || true"
            }
        }
    }
}
