class nodejs (
  $path = "/vagrant/extensions/nodejs"
) {
  if $lsbdistcodename == 'xenial' {
    $clang_package = '3.8'
  }
  else {
    $clang_package = "3.4"
  }
  package { "clang-${$clang_package}":
    ensure  => latest,
  }
  package { 'nodejs':
    ensure  => latest,
    require => Exec['node update']
  }
  exec { 'node update':
    command => "/usr/bin/curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -",
    require => Package['curl']
  }
}
