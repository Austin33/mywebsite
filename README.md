# mywebsite - austinlynum.com
This is my website which is basically my professional resume and artistic portfolio. I started on this project 3 years ago as way to learn Python and Django. I was maintaining it for about year but recently picked it back up again.


#Deployment Instructions

Step 1: Clone the repo to your local system

Step 2: Go to https://miniwebtool.com/django-secret-key-generator/ to generate a secret key.

Step 3: Create a .env file in the repo's home directory and paste the secret key there with the following syntax: SECRET_KEY=

Step 4: Load up your favorite CLI tool, navigate to the home directory of the repo and type: docker-compose -f /mywebsite/docker-compose.yml up -d

Step 5: Wait a few minutes for the container to spin up then you should be able to access the site via localhost:8000

For Terraform, locate the terraform deployment script within the project home folder and run that to deploy in an AWS environment. You can access it by navigating to the public ip address that will display once terraform is finished. Port 8000 of-course.
