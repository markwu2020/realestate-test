# realestate-test

### **SYSTEM ARCHITECTURE** 

------



### **MAJOR DECISION ON THE SOLUTION** 

------



### **HOW TO DEPLOY THE INFRASTRUCTURE AND THE APPLICATION**

------

I try to create two modules for the network and instance respectively, so that we can reuse the module in our main.tf scrpt, which also greatly simplify the lines of code in the main file. 

#### **Prerequisite before running the code**

1. You need to have an AWS account;
2. Create an AWS crendential in the AWS management web console, and you will get the access_key and secret_access_key to build up the infrastructure.
3. Install AWS cli on your local laptop, run `aws configure`to set up aws region, access_key as well as secret_access_key, then you will be able to connect to your aws account via the command line tool and reay to deploy the code.
4. Create an ssh key pair, download the ***.pem file. 

#### **Steps to run the code**

It is quite simple to build the code and deploy the entire infrastructure on AWS and deploy our sinatra ruby application onto the newly create platform. Please type in the command in sequence in your command line tool and finally you will get the output, which is the DNS name of the ELB. 

```
git clone https://github.com/a30001784/realestate-test.git
```

Copy your ***.pem file to the home directory of the code base you just downloaded, modify the `dev.tfvars`file and change the values of the `ssh_key_name`and `private_key_path`to your own pem file.  Also, you can easily modify the number and instance type for the bastion host and web application server in this `dev.tfvars`file as I have set these fields as parameters, which make it very easy for us to dynamically pass in different variables.

After finishing setup the variable file, type in the following command to build the code and deploy the application servers.

```
terraform init
terraform apply -var-file=./dev.tfvars -auto-approve
```

A few minutes later , you will get the outcome of the DNS name for ELB from your command line console. In my case, the output is `elb-757284977.ap-southeast-2.elb.amazonaws.com` .Wait for a few more minutes, as it  takes some time for the system to execute the `deploy.sh`file to run the Passenger Web Server.  

During this period of time, you can go to the AWS web console and check the status of the building up of infrastructure. Go to `Load Balancing` tab in the EC2 panel, press the `instance`button to see if web application servers are up and ready. When the status of the instances changing form out of service to in service. then you can jump over to your favourite web browser, type in the address of the ELB, Yeah~~~ Congratulations! You will see the familiar `Hello World!`page. 

![Snapshot](https://tva1.sinaimg.cn/large/00831rSTly1gctnvrt4uqj30vu0hlmy6.jpg)