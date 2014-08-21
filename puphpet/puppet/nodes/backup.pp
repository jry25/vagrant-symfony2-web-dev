# Begin backup

if $backup_values == undef {
  $backup_values = hiera('backup', false)
}

$backup_dirs = [ "/vagrant/backup/", "/vagrant/backup/databases/" ]

file { $backup_dirs:
  ensure => "directory",
  owner  => "vagrant",
  group  => "vagrant",
  mode   => 755,
}

if $backup_values['mysql']['hour'] != undef and $backup_values['mysql']['minute'] != undef {
  cron { backup_databases:
    command   => "(/vagrant/puphpet/files/exec-always/backup-mysql.sh) > /vagrant/backup/backup_databases.log 2> /vagrant/backup/backup_databases.err",
    user    => root,
    hour    => $backup_values['mysql']['hour'],
    minute    => $backup_values['mysql']['minute']
  }
}

service { 'cron':
  ensure => 'running'
}
