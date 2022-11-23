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

## Authors

Benjamin DAVID <https://github.com/benji920>
Robin VAN DESSEL <https://github.com/vdRobin>
