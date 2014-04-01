define apache::module(
	$file = $name
)
{
	file 
    { 
        "/etc/apache2/mods-enabled/$file":
            ensure  => link,
            target  => "/etc/apache2/mods-available/$name",
			notify  => Service['apache2'],
            require => Package['apache2'],
    }
}
