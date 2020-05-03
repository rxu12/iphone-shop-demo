#!/usr/bin/env groovy test123
pipeline {
    agent {
        docker {
            image 'xrayray/nodejs-sceptre:v1.25'
            args '-v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/local/bin/docker'
        }
    }

    environment {
        HOME = '.'
        APPSVC_NAME = "iphone-search"
        APPSVC_VERSION = "${env.BUILD_NUMBER}"
        AZURE_CRED_ID = "jenkinsSP"
        RES_GROUP = "jenkins-resource-grp"
        WEB_APP = APPSVC_NAME
    }

    stages {
        // stage('Setup ECR') {
        //     when {
        //         anyOf {
        //             branch 'master'
        //         }
        //     }
        //     steps {
        //         dir('infra/cf-stack') {
        //             sh "sceptre launch -y repository"
        //         }
        //     }
        // }

        stage('Install npm packages') {
            steps {
                sh "npm install"
            }
        }

        stage('Unit Test') {
            steps {
                sh "npm run test:ci"
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