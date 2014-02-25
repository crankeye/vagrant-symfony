class apache(
    $serverName = "local.dev",
    $serverAlias = "www.local.dev",
    $documentRoot = "/var/www/project/web"
)
{      
    package 
    { 
        "apache2":
            ensure  => present,
            require => [Exec['apt-get update'], Package['php5'], Package['php5-dev'], Package['php5-cli']]
    }
    
    service 
    { 
        "apache2":
            ensure      => running,
            enable      => true,
            require     => Package['apache2'],
            subscribe   => [
                File["/etc/apache2/mods-enabled/rewrite.load"],
                File["/etc/apache2/sites-available/000-default.conf"]
            ],
    }

    file 
    { 
        "/etc/apache2/mods-enabled/rewrite.load":
            ensure  => link,
            target  => "/etc/apache2/mods-available/rewrite.load",
            require => Package['apache2'],
    }

    file 
    { 
        "/etc/apache2/sites-available/000-default.conf":
            ensure  => present,
            owner => root, group => root,
            content => template('apache/000-default.conf.erb'),
            require => Package['apache2'],
    }
    
    file 
    { 
        "/etc/apache2/sites-enabled/000-default":
            ensure  => link,
            target  => "/etc/apache2/sites-available/000-default.conf",
            owner => root, group => root,
            require => Package['apache2'],
    }
}
