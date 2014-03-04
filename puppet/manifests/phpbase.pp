# Enable XDebug ("0" | "1")
# See the /puppet/modules/php/php.ini.erb for xdebug configuration.
$use_xdebug = "0"

# Default path
Exec 
{
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

exec 
{ 
    'apt-get update':
        command => '/usr/bin/apt-get update',
        require => Class['apt']
}

#use 'ppa:ondrej/php5' for php 5.5.x or 'ppa:ondrej/php5-oldstable' for php 5.4.x
#remove 'ppa:ondrej/apache2' for apache 2.2
class { 'apt':
    repos => ['ppa:ondrej/php5','ppa:ondrej/apache2']
}

include bootstrap
include curl

class { 'php':
    packages => [
            "php5-mysql",
            "php5-dev",
            "php5-mcrypt",
            "php5-gd",
            "php5-intl",
            "php5-curl",
            "php5-xdebug",
            "libapache2-mod-php5"
    ]
}

class { 'apache':
    serverName 		=> "local.dev",
    serverAlias 	=> "www.local.dev",
    documentRoot 	=> "/var/www/project/web"
}

class { 'mysql':
    database 		=> "development",
    mysqlPassword 	=> "root"
}

include composer
include phpunit
