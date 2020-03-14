# Solution on Technical Test

### **System architecture**  

------

The solution discussed in this article is base on AWS cloud service.  According to our design, we are going to use terraform to spin up the entire platform on AWS by using Ubuntu 18.04lts OS and deploy our ruby web application by running a single bash script.

 In short, after we get all the related scripts ready, what we need to do is to go to the command line tool and type in a single command,  then the entire platform will be set up on AWS and our application will be deployed onto it from scratch.

The architectural design of the platform is shown as follows: 







### **Major decisions on the design**

------

1. **Deployment of the web application**

In order to simplifie the deployment of the application, I created a `deploy.sh`script in which I define all the related dependencies and steps to run the application. Also, passenger is served as a light-weight web server for our sinatra ruby applicaition.

2. **Security of the platform**

The architecture of the entire platform is consisted of two-tiers. Public subnet where the ELB and bastion hosts stand and the private subnet where the actual application severs are deployed. 

Security groups are used to control the access to different tiers. With regard to the public subnet, port 22 is exposed to the internet in order for our engineers to log into the jump servers and then to access the internal application servers. Also, port 80 is available from the internet just as per the requirement of this test.

As for private subnet, only port 22 and port 3000(applicaiton port) are available and there is restriction on the source to only allow IP from the public subnets to access the internal private subnets.

Besides, NAT gateway is placed in each public subnet. The application servers in the private subnets can update libraries and download patches from the internet only via NAT gateway.

3. **Reliability and Scalability**

I have designed two public subnets and two private subnets respectively for the platform, so that our platform could be more reliable. Also, application servers are attached to an ELB which will evenly forward the incoming traffic to the backend applcaition servers. In this way, even if something wrong with the network in one subnet or one of our applicaiton servers broke down, we  can still ganrantee our service to the public without any problems.

Also, I have set the field of ec2 instance type and the number of ec2 instance as parameters. We can dynamically change the values of these two attributes and scale up the capability of the platform according to our business requirement. 

In addiition, It comes to me that ASG function provided by AWS can also be used to provide reliability for our platform. Once one of the ec2 instance broke down, ASG would atomatically spin up additional ec2 instance accoding to our predefination. But in this solution, I still adopt the method of attaching serveral applcaiton server to the ELB and leave the use of ASG module in the future tasks.

### **How to setup the infrastucture on AWS and deploy the web application**

------

#### **Prerequisite before running the code**

------

1. You need to have Terraform installed on your local laptop;
2. You need to have an AWS account;
3. Create an AWS crendential in the AWS management web console, store the AWS_Access_Key and AWS_Secret_Access_Key for building up the infrastructure.
4. Install AWS CLI tool on your local laptop, run `aws configure`to set up AWS Region, AWS_Access_Key and AWS_Secret_Access_Key;
5. Create an SSH key pair  from AWS web console, download the ***.pem file and store it on your local laptop.

#### **Steps to setup the infra and deploy the application**

------

It is quite simple to build the code and deploy the entire infrastructure on AWS and deploy our sinatra ruby application onto the newly created platform. Please type in the command in sequence in your command line tool and finally you will get the output, which is the DNS name of the ELB. 

```
git clone https://github.com/a30001784/realestate-test.git
```

Copy your ***.pem file to the home directory of the code base you just download, modify the `dev.tfvars`file and change the values of the `ssh_key_name`and `private_key_path`to your own pem file. 

 Also, you can easily modify the number and instance type for the bastion hosts and web application servers in this `dev.tfvars`file as I have set these fields as parameters.

Type in the following command to build the code and deploy the application to the web servers.

```
terraform init
terraform apply -var-file=./dev.tfvars -auto-approve
```

A few minutes later , you will get the outcome of the DNS name for ELB from your command line console. In my case, the output is `elb-1211280535.ap-southeast-2.elb.amazonaws.com` .Wait for a few more minutes, as it  takes some time for the system to execute the `deploy.sh`file to run the Passenger Web Server.  

During this period of time, you can go to the AWS web console and check the status of the building up of infrastructure. Go to `Load Balancing` tab in the EC2 panel, press the `instance`button on the right to see if web application servers are up and ready. When the status of the instances changing form out of service to in service. then you can jump over to your favourite web browser, type in the address of the ELB, Yeah~~~ Congratulations! You will see the familiar `Hello World!`page. 

![Snapshot](https://tva1.sinaimg.cn/large/00831rSTly1gctnvrt4uqj30vu0hlmy6.jpg)

Finally, if you want to clean up the entire system and release all the resources on AWS, you can simply run the following command to tear down the infrastructure. 

```
terraform destroy -var-file=./dev.tfvars -auto-approve
```

