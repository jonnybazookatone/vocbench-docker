# Some const. variables
$path_var = "/usr/bin:/usr/sbin:/bin:/usr/local/sbin:/usr/sbin:/sbin"
$build_packages = ['mysql-server']
$pip_requirements = "/vagrant/requirements.txt"

# Update package list
exec {'apt_update_1':
	command => 'apt-get update && touch /etc/.apt-updated-by-puppet1',
	creates => '/etc/.apt-updated-by-puppet1',
	path => $path_var,
}

# Install packages
package {$build_packages:
	ensure => installed,
	require => Exec['apt_update_1'],
}

# Make a data folder
file { "/data/":
    ensure => "directory",
    owner => "mysql",
    group => "mysql",
    mode => 777,
    require => Package[$build_packages],
}

Exec['apt_update_1'] -> Package[$build_packages]
