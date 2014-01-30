# Symfony Vagrant Box

A basic Ubuntu 12.04, PHP 5.5, and MySQL 5.5 Vagrant setup for Symfony or any other PHP based framework. The puppet modules were based on the [laravel4-vagrant](https://github.com/bryannielsen/Laravel4-Vagrant) setup. A working knowledge of Vagrant

## Additional Packages
- curl
- git
- phpunit
- composer

## Requirements
1. VirtualBox
2. Vagrant
3. Git

## Installation
1. Clone this repo.
2. Run `vagrant up` in the newly created directory.
3. SSH into the box and run `composer create-project symfony/framework-standard-edition /var/www/project/ 2.4.1`
4. Add `192.168.56.101 local.dev` to your HOSTS file.
5. You should be able to go to http://local.dev/

## Default MySQL Password
- Username: root
- Passwrod: root
- Database: development

## Default Apache Virtual Host
- ServerName: local.dev
- ServerAlias: www.local.dev
- DocumentRoot: /var/www/project/web