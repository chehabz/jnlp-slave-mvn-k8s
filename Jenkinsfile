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
        stage('Get a Maven project') {
            git 'https://github.com/jenkinsci/kubernetes-plugin.git'
            container('maven') {
                stage('Build a Maven project') {
                    sh 'mvn -B clean install'
                    sh 'kubectl version'
                    sh 'helm help'
                    sh 'echo Finsihed'
                }
            }
        }
    }
}