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


class { 'apt':
    repos => ['ppa:chris-lea/node.js']
}

include bootstrap
include curl
include nodejs