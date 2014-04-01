define apache::vhost(
    $serverName 	= "local.dev",
    $serverAlias 	= "www.local.dev",
    $documentRoot 	= "/var/www/project/web"
)
{      
    file 
    { 
        "/etc/apache2/sites-available/$serverName.conf":
            ensure  => present,
            owner 	=> root, group => root,
            content => template('apache/000-default.conf.erb'),
			notify 	=> Service['apache2'],
            require => Package['apache2'],
    }
    
    file 
    { 
        "/etc/apache2/sites-enabled/$serverName":
            ensure  => link,
            target  => "/etc/apache2/sites-available/$serverName.conf",
            owner => root, group => root,
			notify 	=> Service['apache2'],
            require => Package['apache2'],
    }
}
