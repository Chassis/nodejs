# Install NodeJS
class nodejs (
	$path = '/vagrant/extensions/nodejs'
) {
	if ( ! empty($::nodejs_config[disabled_extensions]) and 'xdebug' in $::nodejs_config[disabled_extensions] ) {
		$package = absent
		$file = absent
	} else {
		$package = latest
		$file = 'present'
	}
	if $::lsbdistcodename == 'xenial' {
		$clang_package = '3.8'
	}
	else {
		$clang_package = '3.4'
	}
	package { "clang-${$clang_package}":
		ensure => $package,
	}
	if ( 'latest' == $package ) {
		exec { 'node update':
			path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
			command => '/usr/bin/curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -',
			require => Package['curl'],
			unless  => 'which node'
		}
		package { 'nodejs':
			ensure  => $package,
			require => Exec['node update']
		}
	} else {
		notice("Uninstall node and npm")
	}
}
