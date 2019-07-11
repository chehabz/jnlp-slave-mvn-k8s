def label = "jenkins-slave-mvn-${UUID.randomUUID().toString()}"

podTemplate(
label: label,
imagePullSecrets: ['docker-registry-secret'],
yaml: """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: maven
    image: mbrhe.azurecr.io/jenkins-slave-mvn:latest
    command:
    - cat
    tty: true
"""
) 
{
    node(label) {
        stage('Prepare') {
            git 'https://github.com/chehabz/whale-detector-crypto'
        }
        
        stage('Clean  &  Install Packages') {
            container('maven') {
                sh 'mvn -f src/pom.xml clean install'
            }
        }

        stage('Kubectl') {
            container('maven') {
                sh 'kubectl version'
            }
        }
        stage('Helm version') {
            container('maven') {
                sh 'helm help'
            }
        }
         stage('Helm version') {
            container('maven') {
                sh 'docker -v'
            }
        }
        stage('List the directory') {
            container('maven') {
                sh 'ls -l'
            }
        }
    }
}