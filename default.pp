class { '::mysql::server':
  root_password           => 'apassword',
  remove_default_accounts => true
}

mysql::db { 'adb':
  user     => 'auser',
  password => 'apass',
  host     => 'localhost',
  grant    => ['SELECT', 'UPDATE']
}

class {'apache':}

class config {
  if ($::osfamily == 'Debian') {
    file{'/etc/apache2/sites-enabled/myvhost.conf':
      source => '///home/jorge/p5-puppet/files/myvhost.conf'
    }
  }
  if ($::osfamily == 'RedHat') {
    file{'/etc/httpd/conf.d/myvhost.conf':
      source => '///home/jorge/p5-puppet/files/myvhost.conf'
    }
  }
}

file {'/var/www/html/index.html':
  source => '///home/jorge/p5-puppet/files/index.html'
}


class{'config':}

Class['apache'] -> File['/var/www/html/index.html']
Class['apache'] -> Class['config']
