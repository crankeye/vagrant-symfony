class composer () {
   exec { 'Download Composer':
      path    => '/usr/bin:/usr/sbin:/bin:/sbin',
      require => [ Package['php5'],Package['curl'] ],
      cwd     => '/home',
      command => 'curl -sS https://getcomposer.org/installer | php',
      creates => '/usr/local/bin/composer'
   }

   exec { 'Install Composer':
      path    => '/usr/bin:/usr/sbin:/bin:/sbin',
      require => Exec['Download Composer'],
      cwd     => '/home',
      command => 'mv composer.phar /usr/local/bin/composer',
      creates => '/usr/local/bin/composer'
   }
}
