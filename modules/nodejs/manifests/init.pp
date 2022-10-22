# Install NodeJS
class nodejs (
	$config,
	$path = '/vagrant/extensions/nodejs'
) {
	if ( ! empty($config[disabled_extensions]) and 'chassis/nodejs' in $config[disabled_extensions] ) {
		$package = absent
		$file = absent
	} else {
		$package = latest
		$file = 'present'
	}
	if $::lsbdistcodename == 'xenial' or $::lsbdistcodename == 'bionic' or $::lsbdistcodename == 'focal' or $::lsbdistcodename == 'focal' or $::lsbdistcodename == 'jammy' {
		$clang_package = '12'
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
			command => '/usr/bin/curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -',
			require => Package['curl'],
			unless  => 'which node'
		}
		package { 'nodejs':
			ensure  => $package,
			require => Exec['node update']
		}
	} else {
		exec { 'node uninstall':
			path    => [ '/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/' ],
			command => 'rm -rf /usr/local/bin/npm /usr/local/share/man/man1/node* /usr/local/lib/dtrace/node.d ~/.npm ~/.node-gyp'
		}
		package { 'nodejs':
			ensure  => $package,
			require => Exec['node uninstall']
		}
	}
}
