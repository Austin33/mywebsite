# mywebsite - austinlynum.com
This is my website is basically my professional resume and artistic portfolio. I started on this project 3 years ago as way to learn Python and Django. I was maintaining it for about year but then just stopped but I figured I'd boot this project back up!


#Deployment Instructions

Due to my DevOps background, I've created a docker image that can be downloaded as well as a Terraform script to launch in AWS. 

You pick your poison! ;) 

Docker Compose - Once you have cloned the repo, navigate to the home directory of this project and run:
docker-compose -f /mywebsite/docker-compose.yml up -d

For Terraform, locate the terraform script within the project home folder and run that to deploy to host this on your AWS account.
