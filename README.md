# Symfony Vagrant Box

A basic Ubuntu 12.04, PHP 5.5.x, MySQL 5.5, and Apache 2.4.x Vagrant and puppet configuration for Symfony or any other PHP based framework. The puppet modules were based on the [laravel4-vagrant](https://github.com/bryannielsen/Laravel4-Vagrant) setup. A basic working knowledge of Vagrant is needed for setup as this README is quite sparse.

### Additional Packages
The following packages are also installed:
- curl
- git
- phpunit
- composer

### Requirements
1. [VirtualBox](https://www.virtualbox.org/) 4.3.10 >=
2. [Vagrant](http://www.vagrantup.com/) 1.5.3 >=
3. [Git](http://git-scm.com/)

### Installation
1. Clone this repo `git clone https://github.com/crankeye/vagrant-symfony.git`
2. Run `vagrant up` in the newly created directory. 
  1. If your host OS is windows you must run the command from an administrator command prompt.
3. Add `192.168.56.101 local.dev` to your HOSTS file.
4. SSH into the box and run `sudo composer create-project symfony/framework-standard-edition /var/www/project/ 2.4.2`
5. Modify `/var/www/project/web/app_dev.php` and add `192.168.56.1` to the local ip security array or comment out the section entirely.
6. You should now be able to see http://local.dev/app_dev.php/ in your browser.

### Increasing Speed with Windows Hosts
Currently using rsync on Windows hosts is the best way to overcome the slow Virtual Box synced folders. You can either use `vagrant rsync-auto` to automatically push changes your changes to your box or your can utilize your IDE's deployment tools to automatically upload your changes. 

I've found PHPStorm works well once you've configured the deployment settings correctly. The only minor annoyance is the need to do a `vagrant rsync` after switching branches.
**Tip:** Clicking the "Remote Host" button will keep your SSH connection alive and greatly improve the transfer time.

To setup rsync on a Windows host you'll need to install using cygwin:

1. Download and install [cygwin](http://www.cygwin.com/). 
2. Add the rsync package and the openssl package.
3. Add the cygwin bin directory (C:\cygwin64\bin) to your local path variable.
4. Comment out the default synced folder in the Vagrant file and uncomment the rsync lines.

Your next `vagrant up` will autmatically rsync your project directory to /var/www/project.

#### Increasing Speed on Windows Hosts using Virtual Box Default Synced Folders
If you still want to use the native Virtual box synced folders you can move the cache to the /tmp/ folder within the guest machine by adding these two functions in the AppKernel.php to the AppKernel class:

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
