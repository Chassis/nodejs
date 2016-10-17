class nodejs (
  $path = "/vagrant/extensions/nodejs"
) {
  package { 'clang-3.4':
    ensure => latest
  }
  package { 'nodejs':
    ensure  => latest,
    require => Exec['node update']
  }
  exec { 'node update':
    command => "/usr/bin/curl -sL https://deb.nodesource.com/setup | sudo bash -",
    require => Package['curl']
  }
}
