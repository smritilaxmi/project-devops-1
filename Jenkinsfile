pipeline {
    agent any

    stages {
        stage('Install and configure puppet agent on the slave node') {
            steps {
                puppetAgentInstaller()
            }
        }
        stage('Push an Ansible configuration on test server to install Docker') {
            steps {
                ansiblePlaybook(
                    playbook: 'install_docker.yml',
                    inventory: 'test_server'
                )
            }
        }
        stage('Pull the PHP website and Dockerfile from the Git repo and build and deploy your PHP Docker container') {
            steps {
                git 'https://github.com/smritilaxmi/project-devops-1.git'
                script {
                    docker.build('my-php-website:latest', '.')
                    docker.withServer('tcp://test-server:2376', 'test-server') {
                        docker.image('my-php-website:latest').push()
                        docker.image('my-php-website:latest').run('-p 8080:80', '--name my-php-container')
                    }
                }
            }
        }
    }

    post {
        failure {
            stage('If Job 3 fails, delete the running container on Test Server') {
                steps {
                    script {
                        docker.withServer('tcp://test-server:2376', 'test-server') {
                            docker.image('my-php-website:latest').remove()
                        }
                    }
                }
            }
        }
    }
}
