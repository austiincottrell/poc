# poc_coalfire
Hello! Check the diagram below to see the architect that will be created above.

![Architecture](https://github.com/quiik/poc_coalfire/blob/main/image.jpg?raw=true)

<p>Resources attached to architecture that is not listed in the diagram are security groups and an elastic ip attached to the NAT gateway.</p>

<h2> Step 1: Download Repo </h2>

- The download link is above

<h2> Step 2: Run ssh-keygen command </h2>
    
    
    ssh-keygen -q -f <Your File Location>/poc_coalfire/keys/sshkey -t rsa -N '' -b 4096
    

<h2> Step 3: Create a terraform.tfvars file inside the directory </h2>
<p> List these values in the .tfvars file </p>

    myip = "<Your IP>/32"

    home_dir = "C:/Users/<Your Username>/"
    
<h2> Step 4: Open up a terminal and go to the repo where all the files are </h2>

    $ ~/poc_coalfire

<h2> Step 5: Run a terraform init and double check with a terraform plan to make sure that the values above are put in correctly </h2>


<h2> Step 6: Run a terraform apply and watch the infrastructure setup </h2>

<p> Side note: Built and tested on mac os </p>
