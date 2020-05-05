#!/usr/bin/env groovy
pipeline {
    agent {
        docker {
            image 'xrayray/nodejs-terraform-azure:1.1.3'
            args '-v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/local/bin/docker'
        }
    }

    environment {
        HOME = '.'
        APPSVC_VERSION = "${env.BUILD_NUMBER}"
        AZURE_CRED_ID = 'jenkinsSP'
        RES_GROUP = 'jenkins-resource-grp'
        WEB_APP = 'iphone-search'
        TF_VAR_app_name = "${WEB_APP}"
    }

    stages {
        stage('Setup ECR') {
            when {
                anyOf {
                    branch 'master'
                }
            }
            steps {
                dir('infra') {
                    sh "chmod +x ./"
                    sh "terraform init & terraform apply"
                }
            }
        }

        stage('Install npm packages') {
            steps {
                sh 'npm install'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'npm run test:ci'
            }
        }

        // stage('Build Docker Containers') {
        //     steps {
        //         dir('infra/bash/') {
        //             sh "chmod +x ./build.sh"
        //             sh "./build.sh"
        //         }
        //     }
        // }

        // stage('Push To ECR') {
        //     steps {
        //         dir('infra/bash/') {
        //             sh "chmod +x ./push-ecr.sh"
        //             sh "./push-ecr.sh"
        //         }
        //     }
        // }

    // stage('Deploy To ECS') {
    //     steps {
    //         dir('infra/cf-stack') {
    //             sh "chmod +x ../bash/deploy.sh"
    //             sh "../bash/deploy.sh ecs"
    //         }
    //     }
    // }
    }
}
