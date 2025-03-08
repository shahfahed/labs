

What is configuration management?
Changing somthin on a server/VM in an automated way.
any action that is performed on a machine after logged in.

```
create / modify / delete file
create / modify / delete dir
stop / start /restart a process / service
install /uninstall /upgrade a software
deploy a war to tomcat server
```

Configuration management tool help to automate the changes to be implmented on servers simaltaneously.

```
-- Ansible
-- Puppet
-- chef
-- salt
-- cf engine
-- bladelogic etc
```

# Ansible

Ansible is a tool developed using PYTHON

Ansible is know as
```
--> push model architecture configureation management too
--> Agent less architecture configuration management too
    --> Because we do not install any ansible related software on remote servers
    --> since it uses the ssh / winrm protocol to login, which are default with OS
```
How does ansible login to remote servers
```
--> network
--> IP address
--> username
--> password / key (pem/ppk)
```
Ansible uses default ssh (linux servers) / winrm (windows servers) to login

We can set-up a common username and password as login credentials for all the servers to simplify the login and ease the automation.
```
How does ansible knows the remote servers on which the changes should be done.

IP address of the remote servers should be updated in the inventory file
```

# Inventory file

Ansible default configuration file → /etc/ansible/ansible.cfg
Inventory file name can be anything and we can create our own inventory file.

Default inventory file is host
/etc/ansible/hosts

We can have our inventory file
any number of inventory files can be created.


##How to inplement changes with ansibles?
##How to write automation with ansible?
```
--> ansible gives pre defined modules to implement any changes on a remote server / VM.

What is this module?
--> module is a pre defined executable code given by ansible (like a function)

2 ways to implement changes with ansible
- ad-hoc way / single change or task / one liner command
```

```
Disbale host-key checking
 --> host_key_checking=False
Update default inventory file path
```
