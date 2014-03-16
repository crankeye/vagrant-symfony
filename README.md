# Symfony Vagrant Box

A basic Ubuntu 12.04, PHP 5.5.x, MySQL 5.5, and Apache 2.4.x Vagrant and puppet configuration for Symfony or any other PHP based framework. The puppet modules were based on the [laravel4-vagrant](https://github.com/bryannielsen/Laravel4-Vagrant) setup. A basic working knowledge of Vagrant is needed for setup as this README is quite sparse.

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
  1. If your host OS is windows you must run the command from an administrator command prompt.
3. Add `192.168.56.101 local.dev` to your HOSTS file.
4. SSH into the box and run `composer create-project symfony/framework-standard-edition /var/www/project/ 2.4.2`
5. Modify `/var/www/project/web/app_dev.php` and add `192.168.56.1` to the local ip security array or comment out the section entirely.
6. You should now be able to see http://local.dev/app_dev.php/ in your browser.

### Running Symfony2 commands via command line
The avoid permissions issues when running commands with Symfony2 execute them as www-data. For example to clear your cache use: 

`sudo -u www-data php /var/www/project/app/console cache:clear`


### Increasing Speed with Windows Hosts
To speed up the environment we've moved the cache to the /tmp/ folder within the guest machine by adding these two functions in the AppKernel.php to the AppKernel class:

```php
public function getCacheDir()
{
    return '/tmp/symfony/cache/'. $this->environment;
}

public function getLogDir()
{
    return '/tmp/symfony/log/'. $this->environment;
}
```

### Default MySQL Password
- Username: root
- Password: root
- Database: development

### Default Apache Virtual Host
- ServerName: local.dev
- ServerAlias: www.local.dev
- DocumentRoot: /var/www/project/web

### A Note About the Private Network
This vagrant box is configured on a private network at 192.168.56.101 which is accessible from the guest OS. You can connect a GUI MySQL client by using the default port (3306) and a host ip of 192.168.56.101. See the [Vagrant documentation](http://docs.vagrantup.com/v2/networking/private_network.html) for additional information.
