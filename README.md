## Immutable Deployment with ansible, packer, & terraform
# Chadev demo

This repo contains the source files for a demo talk by Jay Baker on using ansible, packer, and terraform for Immutable server deployment. The video can be seen here: https://www.youtube.com/watch?v=kNhkkZkKyW0

It's focused around AWS, but the principles will apply to any cloud platform that terraform supports (though the terraform config will have to be changed if you use a different provider).

To follow along, you'll need AWS access keys with sufficient privileges to create EC2 isntances and virtual networking.

NOTE: AWS is not free! This demo just uses a single server so it shouldn't cost much to play with for a few days, but be warned that you will be charged. Also, don't forget to run `terraform destroy` when you're done playing around ;)

## Usage

To get started, you will need ansible, packer, and terraform installed on your local machine. Alternatively, you can use the included `Dockerfile` to build a Fedora based image with the tools already installed.

To do so:

```
$ git clone https://github.com/bnlconsulting/chadev-immutable-demo
$ cd chadev-immutable-demo
$ docker build -t “immutable-demo” .
$ docker run -it -e "AWS_ACCESS_KEY_ID=<your access key>" -e "AWS_SECRET_ACCESS_KEY=<your secret access key>" -e "AWS_DEFAULT_REGION=us-east-1" -v <path to git repo>:/root/chadev-immutable-demo
 immutable-demo
```

# Ansible
Ansible is a configuration management tool, written in python, which uses YAML as its configuration language. The `ansible` directory contains various "playbooks," which describe what roles to apply to a given server. the `ansible/roles` directory contains collections of playbooks which are used to add functionality or configure a server in a certain way.

Ansible is very powerful and can be used to fully configure and orchestrate entire infrastructure stacks. For this project however, we will be using it to provision the immutable images created by packer. Ansible's simple, declarative syntax makes this incredibly easy.

Ansible's documentation and a getting started guide can be found here: [docs.ansible.com/](http://docs.ansible.com/).

# Packer
Packer is used as a tool to build immutable Amazon Machine Images (AMIs), written in Go, which uses JSON as its configuration language. The `packer` directory contains different templates for various server types and roles.

Packer launches a temporary instance on AWS, and uses ansible to provision that server. It then saves an AMI of our configured server.

As expected, HashiCorp has excellent documentation on packer which can be found here: [packer.io/docs/](https://www.packer.io/docs/). There is also an easy to follow [getting started guide](https://www.packer.io/intro/getting-started/setup.html).

The basic commands you need are:

* `packer validate template.json` - This will validate the JSON and any interpolated variables; denonted like so `{{uuid}}`. `{{uuid}}` generates a unique string for use in tagging or naming images, for example.
* `packer build template.json` - This command will build an AMI for the specified template.


# Terraform
Terraform is an infrastructure as code tool, written in Go, which accepts both HashiCorp Config Language (HCL) and JSON as its configuration language.

If you've never used terraform, it's best to start here: [Terraform: getting started](https://www.terraform.io/intro/getting-started/install.html). Terraform's cli tool is very simple, most of the complexity lies in the configuration.  The basic commands you need are:

* `terraform plan` - This command will read over all of the `*.tf` files in the present working directory. It will return a list of steps it would take to create the infrastructure described there.
* `terraform apply` - Must be run after `terraform plan`. It executes a plan file, creating the described infrastructure.
* `terraform refresh` - Will refresh the local state with the actual state of your infrastructure. Useful if someone else has made changes from their branch.
* `terraform destroy` - Just like it sounds. This command will destroy any infrastructure described in `*.tf` files in the present working directory. Great power, great responsibility, etc., etc. ...

