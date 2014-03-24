class phpunit () {
   exec { 'Download PHPUnit':
      path    => '/usr/bin:/usr/sbin:/bin:/sbin',
      require => [ Package['curl'] ],
      cwd     => '/home',
      command => 'wget https://phar.phpunit.de/phpunit.phar',
	  unless  => "test -f /usr/local/bin/phpunit"
   }

   exec { 'Permit PHPUnit':
      require => Exec['Download PHPUnit'],
      cwd     => '/home',
      command => 'chmod +x phpunit.phar',
	  unless  => "test -f /usr/local/bin/phpunit"
   }

   exec { 'Move PHPUnit':
      require => Exec['Permit PHPUnit'],
      cwd     => '/home',
      command => 'mv phpunit.phar /usr/local/bin/phpunit',
      creates => '/usr/local/bin/phpunit',
	  unless  => "test -f /usr/local/bin/phpunit"
   }
}