# **This is terraform repository for automate creation environment for testing Pipeline from repository [elb-ecs-cp](https://github.com/kkkooosss/elb-ecs-cp)**

To create all components of the environment use the following commands.

_Note. You should have AWS admins credentials configured._ 
```
git clone https://github.com/kkkooosss/Terraform-creation_environment_for_elb-ecs-cp.git
```
```
cd Terraform-creation_environment_for_elb-ecs-cp
```
Generate ssh key pair for ECS-instances. If you want to access them.
```
ssh-keygen -f ecs-key
```
```
terraform init
```
```
terraform plan
```
You can find all resources which will be created in your AWS account.

Output.

```
...
Plan: 15 to add, 0 to change, 0 to destroy.
...
```

```
terraform apply
```

Say "yes" for create resources.

After the process will be accomplished, you have to see a similar output.

![Output terraform apply](https://github.com/kkkooosss/Terraform-creation_environment_for_elb-ecs-cp/blob/main/pictures/Output_terraform_apply.png)

Now you have to go to your Consul and check all resources that were created. 

For use Pipeline, we have to change security groups attached to RDS postgres instance and ElastiCash for Redis to our new security group "db-redis-sg"

Now you can go to  repository [elb-ecs-cp](https://github.com/kkkooosss/elb-ecs-cp) and test Pipeline.

_Note! Do not forget to remove all resources after you finish._

Command for removing.

``` 
terraform destroy
```
Say "yes"

After the process will be accomplished, you have to see a similar output.

![Output terraform destroy](https://github.com/kkkooosss/Terraform-creation_environment_for_elb-ecs-cp/blob/main/pictures/Output_terraform_destroy.png)

Good Luck.
