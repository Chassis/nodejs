class nodejs (
  $path = "/vagrant/extensions/nodejs"
) {
  package { 'clang-3.4':
    ensure => latest
  }
  package { 'nodejs':
    ensure => latest
  }
}
