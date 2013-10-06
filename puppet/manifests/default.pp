# Make sure apt-get -y update runs before anything else.
stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { '/usr/bin/apt-get -y update':
    user => 'root'
  }
}
class { 'apt_get_update':
  stage => preinstall
}

package { [ 'build-essential',
'zlib1g-dev',
'libssl-dev',
'libreadline-dev',
'git-core',
'libxml2',
'libxml2-dev',
'libxslt1-dev',
'sqlite3',
'libsqlite3-dev',
'nodejs']:
ensure => installed,
}

# RMagick system dependencies
package { ['libmagickwand4', 'libmagickwand-dev']:
ensure => installed,
}

# commandlinetools
package { "screen":  ensure => "installed" }


class install_mysql {
  class { 'mysql': }

  class { 'mysql::server':
    config_hash => { 'root_password' => '' }
  }

  package { 'libmysqlclient15-dev':
    ensure => installed
  }
}
class { 'install_mysql': }

class install_postgres {
  class { 'postgresql': }

  class { 'postgresql::server': }

  pg_user { 'vagrant':
    ensure    => present,
    superuser => true,
    require   => Class['postgresql::server']
  }

  package { 'libpq-dev':
    ensure => installed
  }
}
class { 'install_postgres': }



class install-rvm {
  include rvm
  rvm::system_user { vagrant: ; }

  rvm_system_ruby {
    'ruby-2.0.0-p247':
      ensure => 'present',
      default_use => true;
    'ruby-1.9.3-p194':
      ensure => 'present',
      default_use => false;
  }

  rvm_gem {
    'ruby-2.0.0-p247/bundler':
      ensure => latest,
      require => Rvm_system_ruby['ruby-2.0.0-p247'];
    'ruby-2.0.0-p247/rails':
      ensure => latest,
      require => Rvm_system_ruby['ruby-2.0.0-p247'];
    'ruby-2.0.0-p247/rake':
      ensure => latest,
      require => Rvm_system_ruby['ruby-2.0.0-p247'];
    'ruby-1.9.3-p194/bundler':
      ensure => latest,
      require => Rvm_system_ruby['ruby-1.9.3-p194'];
    'ruby-1.9.3-p194/rails':
      ensure => latest,
      require => Rvm_system_ruby['ruby-1.9.3-p194'];
    'ruby-1.9.3-p194/rake':
      ensure => latest,
      require => Rvm_system_ruby['ruby-1.9.3-p194'];
  }

}

class { 'install-rvm': }
