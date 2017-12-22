node {

    stage 'checkout'
    git 'https://github.com/dewyatt/pastely-backend.git'

    stage 'testing'
    sh './deploy/test.sh'

    stage 'build-staging'
    project_id="$(gcloud config get-value project -q)"
    sh 'git rev-parse HEAD | head -c 40 > GIT_COMMIT'
    git_sha1=readFile('GIT_COMMIT')
    sh "./deploy/build.sh $project_id staging $git_sha1"

    stage 'deploy-staging'
    sh "./deploy/deploy.sh $project_id staging $git_sha1"

    deploy_prod=input message: 'Deployed to staging. Do you want to deploy to production?'
    stage 'build-production'
    sh "./deploy/build.sh $project_id production $git_sha1"

    stage 'deploy-production'
    sh "./deploy/deploy.sh $project_id production $git_sha1"
}
