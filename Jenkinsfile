pipeline{
    	agent any
 	stages{
     	stage('Git Checkout'){
      	steps{
            	git([url: 'https://github.com/qtreeumesh/terraform', branch: 'master'])
        	}
     	}
        stage('Changing access_key'){
      	steps{
            	sh label: '', script: 'sed -i 's/Access_key/AKIAYDHPQWDCXCINQWDY/' main.tf'
        	}
     	}
        stage('Changing Secret_key'){
      	steps{
            	sh label: '', script: 'sed -i 's/Secret_key/8C0TQn/YjuAu2ljfYh41kQDh4Q9WeVvGChsb7OaE/' main.tf'
        	}
     	}
     	stage('Terraform Init'){
      	steps{
            	sh label: '', script: 'terraform init'
        	}
     	}
     	stage('Terraform Apply'){
      	steps{
            	sh label: '', script: 'terraform apply -auto-approve'
        	}
     	}
 	}
}
