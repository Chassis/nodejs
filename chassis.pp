$nodejs_config = sz_load_config()
class { 'nodejs':
  path => '/vagrant/extensions/nodejs'
}
