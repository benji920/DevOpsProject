# DevOps Project

First semester project of DevOps.

## 1. Create a web application
We use the web application from Labs, we must add update and delete in the web app.
We also need to add tests on update and delete.
images/npmtest.png
## 2. Apply CI/CD pipeline

## 3. Configure and provision a virtual environment and run your application using the IaC approach

To create a VM with Vagrant, we created a [Vagrantfile](./iac/Vagrantfile) inside the iac folder. 
We copied the project file into the VM using `config.vm.provision "file", source: "..", destination: "$HOME/devopsproject"` 

* To print a current date into the `/etc/vagrant_provisioned_at` file we replace in the `Vagrantfile` with this:

```ruby
# Start provisioning
$script = <<-SCRIPT
echo I am provisioning...
date > /etc/vagrant_provisioned_at
SCRIPT

config.vm.provision "shell", inline: $script
```

Then, we run:

```bash
vagrant provision
```

We enter to the VM and read the `/etc/vagrant_provisioned_at` file content:

```bash
vagrant ssh
# ... entering to VM
cat /etc/vagrant_provisioned_at
```
We show the result below:

![image](https://user-images.githubusercontent.com/57796628/203652239-2057ee26-7bdb-4aaf-88c8-2fb773a3dda9.png)

* redis is correctly installed and connected:

![image](https://user-images.githubusercontent.com/57796628/203652686-58eb14c1-c86b-46b6-9f95-eebb42c6a3df.png)

* nodejs is correctly installed and application is running:

![image](https://user-images.githubusercontent.com/57796628/203658341-b05152ff-cc65-4029-8843-d6beaa59b87c.png)

* Our application can be started in the VM:
![image](https://user-images.githubusercontent.com/53627391/207389597-dde98ebb-37ec-413b-bfa1-a47aa3f26cfb.png)
![image](https://user-images.githubusercontent.com/53627391/207389688-5463abae-8162-47e2-975e-cbcac8948a4a.png)

* To be able to use sync_folder we were needed to install the vbguest-plugin by typing theses commands:
```bash
vagrant plugin install vagrant-vbguest
vagrant vbguest
```

* healthcheck is correctly installed :

![image](https://user-images.githubusercontent.com/57796628/203654346-c97824a5-8770-4f75-b172-eb4e6f226775.png)

## 4. Build Docker image of your application

We create a Docker image by adding a [Docker file](./Dockerfile) and running:
```bash
docker build -t rovandessel/devopsproject .
```

![image](https://user-images.githubusercontent.com/57796628/204084866-7e5a6042-d7bc-49cc-ab0a-31b6029c3520.png)

We run:
```bash
docker push rovandessel/devopsproject
```

![image](https://user-images.githubusercontent.com/57796628/204085128-1289cf5c-ae06-4a21-8b29-d48a140e6091.png)

## 5. Make container orchestration using Docker Compose

We create a [docker-compose](./docker-compose.yml) and we run:
```bash
docker-compose up
```
We obtain this:
![image](https://user-images.githubusercontent.com/53627391/207567768-aeaed5fa-0960-490a-bd59-10c5ac7b6f55.png)

We can test that the application is currently running by entering the container and typing:
```bash
curl "localhost:3000"
```
The result is the following:
![image](https://user-images.githubusercontent.com/53627391/207567845-0612b4e2-ee38-4d68-816c-1a5aa67d2af5.png)

We can also test if redis is working well with the command:
```bash
docker exec devopsproject_redis_1  sh -c "redis-cli ping"
```
We obtain this:
![image](https://user-images.githubusercontent.com/53627391/207570151-e637f9ae-1cba-45c3-a0b8-b80dcfeb1b87.png)


## 6. Make docker orchestration using Kubernetes

We install 

## Authors

Benjamin DAVID <https://github.com/benji920>
Robin VAN DESSEL <https://github.com/vdRobin>
