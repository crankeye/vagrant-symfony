class git (
   $version = 'latest'
) {
   package { 'git':
      ensure => $version
   }
}
