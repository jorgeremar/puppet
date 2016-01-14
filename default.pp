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

