class curl (
   $version = 'latest'
) {
   package { 'curl':
     ensure  => $version,
     require => Exec['apt-get update']
   }
}
