# Enable XDebug ("0" | "1")
# See the /puppet/modules/php/php.ini.erb for xdebug configuration.
$use_xdebug = "0"

# Default path
Exec 
{
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}


include apt

#use 'ppa:ondrej/php5' for php 5.5.x or 'ppa:ondrej/php5-oldstable' for php 5.4.x
apt::ppa { 'ppa:ondrej/php5': }

#remove 'ppa:ondrej/apache2' for apache 2.2
apt::ppa { 'ppa:ondrej/apache2': }

exec 
{ 
    'apt-get update':
        command => '/usr/bin/apt-get update',
		require	=> Class['apt']
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
	apacheRunUser	=> "www-data",
	apacheRunGroup	=> "www-data"
}

apache::module { 'rewrite.load': }

apache::vhost { 'local.dev':
    serverName 		=> "local.dev",
    serverAlias 	=> "www.local.dev",
    documentRoot 	=> "/var/www/project/web",
	envVars			=> [
		'ErrorLog /var/log/apache2/project_error.log',
		'CustomLog /var/log/apache2/project_access.log combined'
	],
	directoryVars 	=> [
		'AllowOverride All',
	    'Require all granted'
	]
}

class { 'mysql':
    database 		=> "development",
    mysqlPassword 	=> "root"
}

include composer
include phpunit
