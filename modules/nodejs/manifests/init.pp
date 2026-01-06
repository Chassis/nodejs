# Install NodeJS
#
# @param config Configuration hash containing extension settings
# @param path Path to the nodejs extension directory
# @param codename Operating system codename
class nodejs (
  Hash $config,
  String $path = '/vagrant/extensions/nodejs',
  String $codename = $facts['os']['distro']['codename'],
) {
  if ( ! empty($config[disabled_extensions]) and 'chassis/nodejs' in $config[disabled_extensions] ) {
    $package = absent
    $file = absent
  } else {
    $package = latest
    $file = 'present'
  }
  package { 'clang-20':
    ensure => $package,
  }
  if ( $config[nodejs] and $config[nodejs][version] != undef ) {
    $node_version = $config[nodejs][version]
  } else {
    $node_version = 24
  }
  if ( 'latest' == $package ) {
    exec { 'node update':
      path    => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/'],
      command => "/usr/bin/curl -sL https://deb.nodesource.com/setup_${node_version}.x | sudo -E bash -",
      require => Package['curl'],
      unless  => 'which node',
    }
    package { 'nodejs':
      ensure  => $package,
      require => Exec['node update'],
    }
  } else {
    exec { 'node uninstall':
      path    => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/'],
      command => 'rm -rf /usr/local/bin/npm /usr/local/share/man/man1/node* /usr/local/lib/dtrace/node.d ~/.npm ~/.node-gyp'
    }
    package { 'nodejs':
      ensure  => $package,
      require => Exec['node uninstall'],
    }
  }
}
