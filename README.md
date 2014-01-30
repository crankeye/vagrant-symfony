# Symfony Vagrant Box

A basic Ubuntu 12.04, PHP 5.5, and MySQL 5.5 Vagrant setup for Symfony or any other PHP based framework. The puppet modules were based on the [laravel4-vagrant](https://github.com/bryannielsen/Laravel4-Vagrant) setup. A basic working knowledge of Vagrant is needed for setup as this README is quite sparse.

### Additional Packages
The following packages are also installed:
- curl
- git
- phpunit
- composer

### Requirements
1. [VirtualBox](https://www.virtualbox.org/)
2. [Vagrant](http://www.vagrantup.com/)
3. [Git](http://git-scm.com/)

### Installation
1. Clone this repo `git clone https://github.com/crankeye/vagrant-symfony.git`
2. Run `vagrant up` in the newly created directory.
3. Add `192.168.56.101 local.dev` to your HOSTS file.
4. SSH into the box and run `composer create-project symfony/framework-standard-edition /var/www/project/ 2.4.1`
5. Modify `/var/www/project/web/app_dev.php` and add `192.168.56.1` to the local ip security array or comment out the section entirely.
6. You should now be able to see http://local.dev/app_dev.php/ in your browser.

### Default MySQL Password
- Username: root
- Passwrod: root
- Database: development

### Default Apache Virtual Host
- ServerName: local.dev
- ServerAlias: www.local.dev
- DocumentRoot: /var/www/project/web

### Private Network
The vagrant box is configured on a private network at 192.168.56.101 which is accessible from the guest OS. You can connect a GUI MySQL client by using the default port (3306) and a host ip of 192.168.56.101. See the [Vagrant documentation](http://docs.vagrantup.com/v2/networking/private_network.html) for additional information.