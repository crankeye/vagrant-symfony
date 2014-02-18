class apt (
	$repos = []
) {

	Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

	package
	{
		"python-software-properties":
			ensure => present,
			require => Exec['apt apt update']
	}

	exec { "apt apt update":
		command => 'apt-get update'
	}

	define add-apt-repository {
	  	exec 
		{ 
			"add-to-apt $name":
				command => "/usr/bin/add-apt-repository $name -y",
				require => [Package['python-software-properties']],
		}
		exec { "apt apt reupdate $name":
			command => 'apt-get update',
			subscribe  => Exec["add-to-apt $name"]
		}
	}

	add-apt-repository { $repos: } 

}