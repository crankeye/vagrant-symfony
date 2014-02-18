class nodejs()
{
    package 
    { 
        "nodejs":
            ensure  => present,
            require => Exec['apt-get update']
    }
}
