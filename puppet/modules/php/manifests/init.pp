class php(
    $packages = [
        "php5-mysql",
        "php5-dev",
        "php5-mcrypt",
        "php5-gd",
        "php5-intl",
        "php5-curl",
        "php5-xdebug",
        "libapache2-mod-php5"
    ]
)
{
    package
    {
      "php5":
      ensure  => present,
      require => [Exec['apt-get update'], Class['apt']]
    }

    #When using the php 5.4 repos:
    #either php5-cli or php5-cgi must be installed first before installing
    #php5-mcrypt, php5-mysql, php5-gd, or any other packages which depends
    #on phpapi-20090626. Otherwise libapache2-mod-php5 will be installed which
    #will then install apache 2.2.
    package
    {
      "php5-cli":
      ensure  => present,
      require => [Exec['apt-get update'], Package['php5']]
    }

    package
    {
        $packages:
            ensure  => latest,
            require => [Exec['apt-get update'], Package['python-software-properties'], Package['php5-cli']]
    }

    file
    {
        "/etc/php5/apache2/php.ini":
            ensure  => present,
            owner   => root, group => root,
            notify  => Service['apache2'],
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
            content => template('php/xdebug.ini.erb'),
            require => [Package['php5'], Package['php5-xdebug']],
    }

}
