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
        require => Exec['add php55 apt-repo']
}

include bootstrap
include curl
include php55 #specific setup steps for 5.5
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