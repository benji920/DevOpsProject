# Instructions

## Installation

This application is written on NodeJS and it uses Redis database.

1. [Install NodeJS](https://nodejs.org/en/download/)

2. [Install Redis](https://redis.io/download)

3. Install application

Go to the root directory of the application (where `package.json` file located) and run:

```
npm install 
```

## Usage

1. Start a web server

From the root directory of the project run:

```
npm start
```

It will start a web server available in your browser at http://localhost:3000.

2. Create a user

Send a POST (REST protocol) request using terminal:

```bash
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"username":"koleoptere","firstname":"robin","lastname":"vandessel"}' \
  http://localhost:3000/user
```

It will output:

```
{"status":"success","msg":"OK"}
```

Another way to test your REST API is to use [Postman](https://www.postman.com/).


## Testing

From the root directory of the project, run:

```
npm test
```


# Project Report

First semester project of DevOps.

## 1. Create a web application
The web application was developed using **NodeJS** and configured to run on port 3000. **Redis** was used as the database, and the routes and controllers folders were used to make changes to the database, such as creating a user. The application was covered with 20 tests to ensure its proper functioning, including tests for configuration, the Redis connection, and the user CRUD methods as well as the REST API. This testing strategy helps to ensure that the different components of the application are working correctly and that the API is able to handle expected requests and responses.
- The little user API application with CRUD:

Create:
 
![image](https://user-images.githubusercontent.com/53627391/209705485-bd3e7ef8-9b8d-4f12-afee-7d30c2db93ab.png)

Read:

![image](https://user-images.githubusercontent.com/53627391/209705912-25ff801a-7c40-426b-8b7b-67b96d512d7d.png)

Update:

![image](https://user-images.githubusercontent.com/53627391/209706279-959d51d4-8e02-4622-a149-da15bacd0af9.png)

![image](https://user-images.githubusercontent.com/53627391/209706303-a88dca1f-2297-41c4-b563-db128e292f7c.png)

Delete:

![image](https://user-images.githubusercontent.com/53627391/209706494-49252f4c-c42d-4049-ac11-17d880aa8c3e.png)

![image](https://user-images.githubusercontent.com/53627391/209706530-36d7fb7b-46cc-49d3-877f-ffa7925048b7.png)

- The storage in Redis database:

![image](https://user-images.githubusercontent.com/53627391/209721976-e97d3066-bd16-4e7a-a4cf-0149bf52de80.png)

- All tests: unit, API, configuration, connection & the health check endpoint ensuring an application is functional:

![image](images/npmtest.png)

- - - -

## 2. Apply CI/CD pipeline

For applying CI/CD, we use a configuration file named [main.yaml](./github/workflows/main.yaml)

### Continuous Integration
First, we applied continuous integration using GitHub Actions:

![image](https://user-images.githubusercontent.com/53627391/209723215-92ce271a-1018-4d76-804d-8fb000ff961a.png)

![image](https://user-images.githubusercontent.com/53627391/209722866-7b7e3319-31fd-460e-bda6-b59d2b1584f5.png)

### Continuous Deployments
Second, we applied continuous deployments using Heroku:

![image](https://user-images.githubusercontent.com/53627391/209723844-3ffb19f1-ffe4-4cd2-8b35-343069f58214.png)

![image](https://user-images.githubusercontent.com/53627391/209723861-0247f465-200b-4d95-8a4a-4688c757547d.png)


- - - -

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
- - - -
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
If you want the docker-compose to work, you need to do it twice, for the moment this is the only way we were capable of obtain a good result.
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

- - - -
## 6. Make docker orchestration using Kubernetes

First, we install minikube with the command:
```bash
minikube start
```
After we create some pods, services and deployments:
```bash
kubectl apply -f pv.yaml
kubectl apply -f redis-deployment.yaml
kubectl apply -f redis-pvc.yaml
kubectl apply -f redis-service.yaml
kubectl apply -f web-deployment.yaml
kubectl apply -f web-service.yaml
```
We check if they successfully run:
![image](https://user-images.githubusercontent.com/53627391/207895776-827c1538-9ea7-4d82-a5dd-9a574cd512c2.png)

We can start the web service:
![image](https://user-images.githubusercontent.com/53627391/207895545-a837f193-5c61-40a2-9e4f-920dfe346903.png)
- - - -
## 7. Make a service mesh using Istio

To begin, we download Istio with the command:
```bash
curl -L https://istio.io/downloadIstio | sh -
```
After, we move to the Istio package directory, and we add the istioctl client to our path:
```bash
cd istio-1.16.1
export PATH=$PWD/bin:$PATH
```
We need to start minikube:
```bash
minikube config set driver kvm2
minikube start --memory=4000mb --cpus=4 --kubernetes-version=v1.20.2
```
![image](https://user-images.githubusercontent.com/53627391/209521709-f9f8c144-77ec-49f4-84d1-48dfe95bd5eb.png)

In another terminal we type:
```bash
minikube tunnel --cleanup
```
![image](https://user-images.githubusercontent.com/53627391/209521499-6971596d-4b31-4170-8039-62bc2b9afdcd.png)

We install istio with the demo configuration file:
```bash
istioctl install --set profile=demo -y
```
![image](https://user-images.githubusercontent.com/53627391/209522100-b6b24127-cbcb-4ff3-97f8-f171864bda9d.png)

We add a namespace label to instruct Istio to automatically inject Envoy sidecar proxies when we deploy our application later:
```bash
kubectl label namespace default istio-injction=enabled
```
We go to the k8s folder and deploy our application:
```bash
cd k8s
kubectl apply -f .
```
![image](https://user-images.githubusercontent.com/53627391/209521849-1bb16559-39eb-4566-aff7-a93800db6619.png)

We set the ingress host and ports:
```bash
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
```

We set GATEWAY_URL:
```bash
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
```

We can start now the application:
```bash
minikube service web
```
![image](https://user-images.githubusercontent.com/53627391/209522416-3178128a-51cf-472b-b832-d47ca0876ba2.png)
![image](https://user-images.githubusercontent.com/53627391/209580462-650d2e5c-66eb-438b-9346-75b0be2512bf.png)
- - - -
## 8. Implement Monitoring to your containerized application

# Links

- [Node.js](https://nodejs.org/en/)
- [Github Action](https://github.com/features/actions)
- [Heroku](heroku.com)
- [Istio](https://istio.io/)
  - [Kiali](https://kiali.io/)
  - [Prometheus](https://istio.io/latest/docs/ops/integrations/prometheus/)
- [Docker](https://www.docker.com/)
- [Vagrant](https://www.vagrantup.com/)
  - [Ansible](https://www.ansible.com/)
- [Kubernetes](https://kubernetes.io/)
- [Postman](https://www.postman.com/)
- [Docker Hub](https://hub.docker.com/)


# Authors

[Benjamin DAVID](https://github.com/benji920)
[Robin VAN DESSEL](https://github.com/vdRobin)
