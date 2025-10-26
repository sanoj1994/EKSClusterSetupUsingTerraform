pipeline {
    agent any

    parameters {
        choice(name: 'action', choices: ['plan', 'apply', 'destroy'], description: 'Terraform action to apply')
        choice(name: 'ENVIRONMENT', choices: ['dev', 'qa'], description: 'Deployment Environment')
    }

    stages {
        stage('init') {
            steps {
                sh 'rm -rf .terraform'
                sh "terraform init -no-color -backend-config='${params.ENVIRONMENT}/${params.ENVIRONMENT}.tfbackend'"
            }
        }

        stage('validate') {
            steps {
                sh 'terraform validate -no-color'
            }
        }

        stage('plan') {
            when {
                expression { params.action == 'plan' || params.action == 'apply' }
            }
            steps {
                sh "terraform plan -no-color -input=false -out=tfplan --var-file=${params.ENVIRONMENT}.tfvars"
            }
        }

        stage('approval') {
            when {
                expression { params.action == 'apply' }
            }
            steps {
                sh 'terraform show -no-color tfplan > tfplan.txt'
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Apply The Plan?",
                          parameters: [text(name: 'plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }

        stage('apply') {
            when {
                expression { params.action == 'apply' }
            }
            steps {
                sh 'terraform apply -no-color -input=false tfplan'
            }
        }

        stage('preview-destroy') {
            when {
                expression { params.action == 'destroy' }
            }
            steps {
                sh "terraform plan -no-color -destroy -out=tfplan --var-file=${params.ENVIRONMENT}.tfvars"
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }

        stage('destroy') {
            when {
                expression { params.action == 'destroy' }
            }
            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Delete The Stack?",
                          parameters: [text(name: 'plan', description: 'Please review the plan', defaultValue: plan)]
                }
                sh 'terraform destroy -no-color --auto-approve'
            }
        }
    }
}
