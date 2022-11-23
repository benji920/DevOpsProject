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

To print a current date into the `/etc/vagrant_provisioned_at` file we replace in the `Vagrantfile` with this:

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


## Authors

Benjamin DAVID <https://github.com/benji920>
Robin VAN DESSEL <https://github.com/vdRobin>
