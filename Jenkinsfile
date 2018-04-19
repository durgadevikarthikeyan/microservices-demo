pipeline {
    agent any

    options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
}
    
    environment {
    // Environment variable identifiers need to be both valid bash variable
    // identifiers and valid Groovy variable identifiers. If you use an invalid
    // identifier, you'll get an error at validation time.
    // Right now, you can't do more complicated Groovy expressions or nesting of
    // other env vars in environment variable values, but that will be possible
    // when https://issues.jenkins-ci.org/browse/JENKINS-41748 is merged and
    // released.
        VERSION= "${BUILD_ID}"
        app_image= "hmdemo/userapp"
        stack_name= "userapp"
        stack_file= "userapp-stack.yaml"
     }
    
    stages {
        stage("app build") {
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId:'HMDockerCreds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                sh '''
                      rm -rf DockerSwarm-microservices
                      git clone https://github.com/HM-demo/DockerSwarm-microservices.git
                      cd DockerSwarm-microservices
                      sudo docker build -t userapp .
                      #sed -i -e 's/maven-sample/maven-sample:'${VERSION}'/g' ../sample-stack.yaml
                      sudo docker login -u $USERNAME -p $PASSWORD
                      sudo docker tag userapp ${app_image}:${VERSION}
                      sudo docker tag userapp ${app_image}
                      sudo docker push ${app_image}:${VERSION}
                      sudo docker push ${app_image}
                   '''                         
                }
            }
        }
        stage("Docker Stack Deployment") {
            
            steps {
                sh '''
                sudo docker stack deploy -c ${stack_file} ${stack_name}
                '''
            }
        }
     }  
}
