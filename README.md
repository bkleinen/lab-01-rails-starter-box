# A Virtual Machine for Ruby on Rails Application Development

## Introduction

This project automates the setup of a development environment for general Ruby on Rails application development. 

Inspired by the book ["Deploying Rails"](http://pragprog.com/book/cbdepra/deploying-rails) and fxn's [rails-dev-box](https://github.com/rails/rails-dev-box). Forked from https://github.com/jasonk47/rails-starter-box, which in turn was forked from https://github.com/amaia/rails-starter-box

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

## How To Build The Virtual Machine

Building the virtual machine is this easy:

    host $ git clone https://github.com/web-engineering/rails-starter-box.git
    host $ cd rails-starter-box
    host $ git submodule init
    host $ git submodule update
    host $ vagrant up

If the base box is not present that command fetches it first. 

    host $ vagrant ssh
    Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.2.0-23-generic-pae i686)
    ...
    vagrant@rails-starter-box:~$

Port 3000 in the host computer is forwarded to port 3000 in the virtual machine. 
Thus, applications running in the virtual machine can be accessed via localhost:3000 in the host computer.

The directory rails-starter-box is also available inside the box as /Vagrant.
Start your rails projects there, and you will be able to use you windows IDE to
edit the files.

## What's In The Box

* Git

* SQLite3, MySQL, and Postgres

* RVM (with ruby 1.9.3-p194 and 2.0.0-p247 installed)

* Bundler, Rails and Rake gems for both rubies

## actually, you can get rid of the repository now

If your machine is up and running you don'r really need
the git repository any more.  you can do a 

    cd rails-starter-box
	rm -rf .git
	
to get rid of the repository. This will make it easier
for you to create your own repositories for your own rails projects
inside the box.
    

## Recommended Workflow

The recommended workflow is

start the project in the virtual machine

    cd /Vagrant
    rails new my-new-project
    cd my-new-project
    
use rails, rake, rails console, git in the virtual machine

    cd /Vagrant/my-new-project
    rails generate scaffold thing name
    git add .
    git commit -m 'scaffold for things'

edit files in the host computer

    Point your IDE to ....rails-starter-box/my-new-project
    edit app/model/thing.rb 

run within the virtual machine

    cd /Vagrant/my-new-project
    rails server

use your browsers on the host machine

    point them to http://localhost:3000/
    
    

## Virtual Machine Management

When done just log out with and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://vagrantup.com/v1/docs/index.html) for more information on Vagrant.
