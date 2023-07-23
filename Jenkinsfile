node {
    try {
        sh 'might fail'
    } catch (err) {
        echo "Caught: ${err}"
        currentBuild.result = 'FAILURE'
    }
    step([$class: 'Mailer', recipients: 'chris@kalazzerx.com'])
}

