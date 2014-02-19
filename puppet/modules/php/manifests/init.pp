class php
{

    $packages = [
        "php5",
        "php5-cli",
        "php5-mysql",
        "php5-dev",
        "php5-mcrypt",
        "php5-gd",
        "php5-intl",
        "php5-curl",
        "php5-xdebug",
        "libapache2-mod-php5"
    ]

    package
    {
        $packages:
            ensure  => latest,
            require => [Exec['apt-get update'], Package['python-software-properties']]
    }

    file
    {
        "/etc/php5/apache2/php.ini":
            ensure  => present,
            owner   => root, group => root,
            notify  => Service['apache2'],
            #source => "/vagrant/puppet/templates/php.ini",
            content => template('php/php.ini.erb'),
            require => [Package['php5'], Package['apache2']],
    }

    file
    {
        "/etc/php5/cli/php.ini":
            ensure  => present,
            owner   => root, group => root,
            notify  => Service['apache2'],
            content => template('php/cli.php.ini.erb'),
            require => [Package['php5']],
    }

    file
    {
        "/etc/php5/mods-available/xdebug.ini":
            ensure  => present,
            owner   => root, group => root,
            notify  => Service['apache2'],
            content => template('php/20-xdebug.ini.erb'),
            require => [Package['php5'], Package['php5-xdebug']],
    }

}
