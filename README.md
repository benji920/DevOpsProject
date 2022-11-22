# DevOps Project

First semester project of DevOps.

## 3. Configure and provision a virtual environment and run your application using the IaC approach

To create a VM with Vagrant, we created a [Vagrantfile](./iac/Vagrantfile) inside the iac folder. We copied the project file into the VM using `config.vm.provision "file", source: "..", destination: "$HOME/devopsproject"` 

## Authors

Benjamin DAVID <https://github.com/benji920>
Robin VAN DESSEL <https://github.com/vdRobin>
