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
            git 'https://github.com/jglick/simple-maven-project-with-tests.git'
            container('maven') {
                stage('Build a Maven project') {
                    sh 'mvn -f src/pom.xml clean install'
                    sh 'kubectl version'
                    sh 'helm help'
                    sh 'echo Finsihed'
                }
            }
        }
    }
}