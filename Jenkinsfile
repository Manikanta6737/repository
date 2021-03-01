pipeline {

  environment {
    PROJECT = "manikanta-305806"
    IMAGE_TAG = "gcr.io/${PROJECT}/sample:latest"
    JENKINS_CRED = "${PROJECT}"
  }

  agent {
    kubernetes {
      label 'sample-app'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  # Use service account that can deploy to all namespaces
  
  containers:
  - name: gcloud
    image: gcr.io/google.com/cloudsdktool/cloud-sdk:latest
    command:
    - cat
    tty: true
  - name: helm
    image: alpine/helm
    command:
    - cat
    tty: true
"""
}
  }
  stages {
    stage('Build and push image with Container Builder') {
      steps {
        container('gcloud') {
          sh "gcloud auth list" 
          sh "PYTHONUNBUFFERED=1 gcloud builds submit -t ${IMAGE_TAG} ."
        }
      }
    }
    stage('Deploy ') {
      steps {
        container('helm') {
          sh """
          helm ls
          gcloud container clusters get-credentials proc --zone us-central1-c --project manikanta-305806
          kubectl get pods --namespace default
          helm install sampleapp sampleapp/ --namespace default
          helm ls
          kubectl get pods --namespace default
          """ 
        }
      }
    }
 }
}
