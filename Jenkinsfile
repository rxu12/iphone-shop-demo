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
        TF_VAR_app_acr_name = "${WEB_APP.replace("-", "")}acr"
        TF_VAR_acr_link = "${TF_VAR_app_acr_name}.azurecr.io"
        TF_VAR_docker_image_tag = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Create Resource Group & ACR') {
            when {
                anyOf {
                    branch 'master'
                }
            }
            steps {
                dir('infra') {
                    withCredentials(
                        [ azureServicePrincipal('azure-jenkins-sp') ]
                    ) {
                        sh 'chmod -R +x ./'
                        sh './bash/tfRun.sh rg'
                        sh './bash/tfRun.sh acr'
                    }
                }
            }
        }

        // stage('Install npm packages') {
        //     steps {
        //         sh 'npm install'
        //     }
        // }

        // stage('Unit Test') {
        //     steps {
        //         sh 'npm run test:ci'
        //     }
        // }

        stage('Build Docker Containers') {
            steps {
                dir('infra/bash/') {
                    sh 'chmod +x ./build.sh'
                    sh './build.sh'
                }
            }
        }

        stage('Push To ACR') {
            steps {
                dir('infra/bash/') {
                    withCredentials(
                        [ azureServicePrincipal('azure-jenkins-sp') ]
                    ) {
                        sh 'chmod +x ./push-acr.sh'
                        sh './push-acr.sh'
                    }
                }
            }
        }

        stage('Deploy To APP SVC') {
            steps {
                dir('infra') {
                    withCredentials(
                        [ azureServicePrincipal('azure-jenkins-sp') ]
                    ) {
                        sh "chmod +x ./bash/tfRun.sh"
                        sh "./bash/tfRun.sh as"
                    }
                }
            }
        }
    }
}
