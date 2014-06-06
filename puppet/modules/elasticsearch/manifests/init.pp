class elasticsearch (
    $deb_url  = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.0.deb",
    $deb_name = "elasticsearch-1.2.0.deb"
)
{
    package
    {
        "openjdk-7-jre-headless":
        ensure  => present,
        require => Exec['apt-get update']
    }

    exec
    { 
        "download-elasticsearch-deb":
            command => "/usr/bin/wget $deb_url",
            require => Package["openjdk-7-jre-headless"],
            creates => "/home/vagrant/$deb_name"
    }

    exec
    { 
        "install-elasticsearch-deb":
            command => "/usr/bin/dpkg -i $deb_name",
            require => Exec["download-elasticsearch-deb"],
            unless  => "dpkg -l | grep 'ii  elasticsearch'"
    }

    service
    { 
        "elasticsearch":
            enable => true,
            ensure => running,
            require => Exec["install-elasticsearch-deb"]
    }
}
