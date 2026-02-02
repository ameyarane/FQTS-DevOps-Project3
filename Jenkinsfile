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
        stage('Load Config') {
            steps {
                script {
                    // Read YAML config
                    config = readYaml file: 'CICDInfra/config.yaml'

<br />

                    // Detect current env
                    def envName = (env.BRANCH_NAME == 'prod') ? 'prod' : env.BRANCH_NAME
                    envConfig = config[envName]

<br />

                    // Store flags for downstream use
                    currentBuild.displayName = "#${env.BUILD_NUMBER} [${envName}]"
                    echo "Config for branch ${envName}: ${envConfig}"
                }
            }
        }
        stage('Terraform Init/Plan/Apply') {
            when {
                expression {
                    // Run only if ALB is enabled in config for this env
                    envConfig && envConfig['alb']['enable'] == true
                }
            }
            steps {
                script {
                    def albConf = envConfig['alb']
                    def backendFile = ''
                    if (envName == 'prod') { backendFile = 'backend-prod.conf' }
                    else if (envName == 'stage') { backendFile = 'backend-stage.conf' }
                    else { backendFile = 'backend-dev.conf' }

<br />

                    dir(albConf['path']) {
                        sh "terraform init -backend-config=${backendFile} -input=false -reconfigure"
                        sh "terraform plan --var-file=${albConf['tfvars']} -out=tfplan"

<br />

                        // If delete flag, run destroy, else run apply
                        if (albConf['delete'] == true) {
                            input message: "Destroy ALB resources for ${envName}?"
                            sh "terraform destroy --var-file=${albConf['tfvars']} --auto-approve"
                        } else {
                            input message: "Apply ALB changes for ${envName}?"
                            sh "terraform apply -auto-approve tfplan"
                        }
                    }
                }
            }
        }
        stage('Terraform Init/Plan/Apply (EC2)') {
            when {
                expression {
                    // Run only if EC2 is enabled in config for this env
                    envConfig && envConfig['ec2']['enable'] == true
                }
            }
            steps {
                script {
                    def ec2Conf = envConfig['ec2']
                    def backendFile = ''
                    if (envName == 'prod') { backendFile = 'backend-prod.conf' }
                    else if (envName == 'stage') { backendFile = 'backend-stage.conf' }
                    else { backendFile = 'backend-dev.conf' }

<br />

                    dir(ec2Conf['path']) {
                        sh "terraform init -backend-config=${backendFile} -input=false -reconfigure"
                        sh "terraform plan --var-file=${ec2Conf['tfvars']} -out=tfplan"
                        if (ec2Conf['delete'] == true) {
                            input message: "Destroy EC2 resources for ${envName}?"
                            sh "terraform destroy --var-file=${ec2Conf['tfvars']} --auto-approve"
                        } else {
                            input message: "Apply EC2 changes for ${envName}?"
                            sh "terraform apply -auto-approve tfplan"
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            script {
                // Output for ALB if enabled
                if (envConfig && envConfig['alb']['enable'] == true) {
                    dir(envConfig['alb']['path']) {
                        sh "terraform output || true"
                    }
                }
                // Output for EC2 if enabled
                if (envConfig && envConfig['ec2']['enable'] == true) {
                    dir(envConfig['ec2']['path']) {
                        sh "terraform output || true"
                    }
                }
            }
        }
    }
}
