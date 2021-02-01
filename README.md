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

    terraform init
    
    terraform plan

<h2> Step 6: Run a terraform apply and watch the infrastructure setup </h2>

    terraform apply
     
<h2> Step 7: Run the bastion ssh command </h2>

    ssh private-instance    

- if you see an error from the bastion command check the .ssh/config file and make sure it looks like this:
    <p>
    Host bastion-instance <br>
     HostName 34.201.171.10 <br>
     User ec2-user <br>
     <br>
    Host private-instance <br>
     HostName 10.0.3.247 <br>
     User ec2-user <br>
     ProxyCommand ssh -q -W %h:%p bastion-instance <br>
    </p>
<h2> Step 8: Run the script to install/configure httpd </h2>


    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    echo '<h1> Hello Coalfire from Austin! </h1>' > /var/www/html/html.index
    echo '<virtualhost *:80> 
    servername www.poctest.com 
    serveradmin root@<Private IP>
    documentroot /var/www/html/ 
    </virtualhost>' > /etc/httpd/conf.d/mytest.conf
    echo '<Private IP> www.poctest.com' >> /etc/hosts
    sudo systemctl start httpd
    sudo systemctl enable httpd
    
   
<p> Side note: Built and tested on mac os </p>
