class php::mongo()
{
    exec { "install-mongo-extension":
		command => "pecl install mongo",
		unless  => "pecl list mongo",
		require => [Package['php5'], Package['php5-dev']]
	}

	file { "/etc/php5/mods-available/mongo.ini":
            ensure  => present,
            owner   => root, group => root,
            notify  => Service['apache2'],
            content => template('php/mongo.ini.erb'),
            require => [Exec["install-mongo-extension"]]
    }
	
	file { '/etc/php5/apache2/conf.d/20-mongo.ini':
      ensure => link,
      target => '../../mods-available/mongo.ini',
	  require => [Exec["install-mongo-extension"]]
    }
}
