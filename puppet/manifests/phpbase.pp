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

#use 'ppa:ondrej/php5-oldstable' for php 5.4
#use 'ppa:ondrej/php5' for php 5.5
class { 'apt':
    repos => ['ppa:ondrej/php5']
}

include bootstrap
include curl
include php

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
