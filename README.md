# Solution on The Technical Test

### **System architecture**  

------

The solution discussed in this article is based on AWS cloud service.  Terraform is used to spin up the entire platform on AWS and the Ruby web application can be deployed with a single bash script.

 In short, after getting all the related scripts ready, what you need to do is to go to the command line tool and type in a single `terraform apply`command,  then everything will be deployed from scratch.

The architectural design of the platform is shown as below: 

![Architectural Design](https://tva1.sinaimg.cn/large/00831rSTly1gcu72afyq7j30nn0f1myk.jpg)

### **Major decisions on the design**

------

1. **Deployment of the web application**

In order to simplify the deployment of the application,  A`deploy.sh`script is created to download all the related dependencies and to run the application. Also, passenger is introduced to serve as a light-weight web server for the sinatra ruby applicaition.

2. **Security of the platform**

The architecture of the entire platform is consisted of two-tiers. Public subnet is the area where the ELB and bastion hosts stand and the private subnet is designed to host the web application severs. 

Security groups are used to control the access to different tiers. For public subnet, port 22 is exposed to the internet in order for allowing engineers to log into the bastion host and then to access the internal application servers. Also, port 80 is available to provide the web service.

As for private subnet, only port 22 and port 3000(applicaiton port) are available and there is a restriction control on the source to only allow traffic from public subnets to access the internal private subnets.

Besides, NAT gateway is placed in each public subnet. The application servers in the private subnets can update libraries and download patches from the internet only via NAT gateway.

3. **Reliability and Scalability**

There are two public subnets and two private subnets within the system architecture, so that the platform could be more reliable. Also, application servers are attached to an ELB which will evenly forward the incoming traffic to the backend applcaition servers. In this way, even if something wrong with the network in one subnet or one of the applicaiton servers broke down, web service can still be accessible without any problems.

In addition, the fields of ec2 instance type and the number of ec2 instance are set as parameters. You can dynamically change the values of these two attributes and scale up the capability of the platform according to the business requirement. 

### **How to setup the infrastucture on AWS and deploy the web application**

------

#### **Prerequisite before running the code**

------

1. You need to have Terraform installed on your local laptop;
2. You need to have an AWS account;
3. You need to create an AWS crendential in advance, store the AWS_Access_Key and AWS_Secret_Access_Key for building up the infrastructure.
4. Install AWS CLI tool on your local laptop, run `aws configure`to set up AWS Region, AWS_Access_Key and AWS_Secret_Access_Key;
5. Create an SSH key pair  from AWS web console, download the ***.pem file and store it on your local laptop.

#### **Steps to setup the infrastructure and deploy the application**

------

First of all, fork the code from Github repository. 

```
git clone https://github.com/markwu2020/realestate-test.git
```

Copy your own ***.pem file into the home directory of the code base, modify the `dev.tfvars`file and change the values of the `ssh_key_name`and `private_key_path`to your own pem file. 

 Also, you can modify the number and instance type for the bastion hosts and web application servers in this `dev.tfvars`file.

Type in the following command to build the code and deploy the application to the web servers.

```
terraform init
terraform apply -var-file=./dev.tfvars -auto-approve
```

A few minutes later , you will get the outcome of the DNS name for ELB from your command line console. Wait for a few more minutes, as it  takes some time for the system to execute the `deploy.sh`file to run the Passenger Web Server.  

During this period of time, you can go to the AWS web console and check the status of the deployment of the application. Go to `Load Balancing` tab in the EC2 panel, press the `instance`button on the right side to see if web application servers are up and ready. When the status of the instances changing form out of service to in service. then you can jump over to your favourite web browser, type in the address of the ELB. Congratulations! You will see the familiar `Hello World!`page. 

![Snapshot](https://tva1.sinaimg.cn/large/00831rSTly1gctnvrt4uqj30vu0hlmy6.jpg)

Finally, if you want to clean up the entire system and release all the resources on AWS, you can simply run the following command to tear down the infrastructure. 

```
terraform destroy -var-file=./dev.tfvars -auto-approve
```

