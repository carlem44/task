node {

    stage 'checkout'
    git 'https://github.com/dewyatt/pastely-backend.git'

    stage 'testing'
    sh './deploy/test.sh'

    stage 'build-staging'
    project_id="$(gcloud config get-value project -q)"
    sh "./deploy/build.sh $project_id staging"

    stage 'deploy-staging'
    sh "./deploy/deploy.sh $project_id staging"

    deploy_prod=input message: 'Deployed to staging. Do you want to deploy to production?'
    stage 'build-production'
    sh "./deploy/build.sh $project_id production"

    stage 'deploy-production'
    sh "./deploy/deploy.sh $project_id production"
}
