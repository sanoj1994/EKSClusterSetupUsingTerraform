pipeline {
   agent any
   parameters {
       choice(
           choices: ['plan', 'apply', 'destroy'],
           description: 'Terraform action to apply',
           name: 'action')
       choice(
           choices: ['dev', 'qa'],
           description: 'Deployment Environment',
           name: 'ENVIRONMENT')
   }
   stages {
       stage('init') {
          steps {
             sh 'rm -rf .terraform'
             sh 'terraform init -no-color -backend-config="${ENVIRONMENT}/${ENVIRONMENT}.tfbackend"'
  }
}
  stage ('validate') {
   steps {
      sh 'terraform validate -no-color'
    }
    }
  stage('plan') {
   when {
     expression {params.action =='plan' || params.action =='apply'}
    }
    steps {
     sh 'terraform plan -no-color -input=false -out=tfplan --var-file =${ENVIRONMENT}.tfvars'
    }
  }
stage('approval') {
    when {
        expression {params.action == 'apply'}
   }
   steps {
         sh 'terraform show -no-color tfplan > tfplan.txt'
         script {
              def plan = readFile 'tfplan.txt'
              input message : "Apply The Plan ?",
              parameters : [text(name:'plan', description:'please review the plan', defaultValue: plan)]
     }
    }
   }
   stage('apply') {
       when { 
          expression {params.action =='apply'}
         }
         steps {
             sh 'terraform apply -no-color -input=false tfplan'
        }
       }
       stage ('preview-destroy') {
           when { 
              expression { params.action == 'destroy'}
          }
          steps {
              sh 'terraform plan -no-color -destroy -out = tfplan --var-filr = ${ENVIRONMENT}.tfvars'
              sh 'terraform show -no-color tfplan > tfplan.txt'
            }
          }
        stage('destroy') {
            when {
              expression {params.action =='destroy'}
             }
             steps {
                 script {
                      def plan = readFile 'tfplan.txt'
                      input message : "Delete The Stack?", params:[text(name: 'plan', description: 'please review the plan', defaultValue: plan)]
                   }
                   sh 'terraform destroy -no-color --auto-approve'
           }
        }
     }
  }
