## Begin Symfony manifest

if $symfony_values == undef {
  $symfony_values = $yaml_values['symfony']
}

group { 'symfonians':
  ensure => present,
  members  => ['apache', 'nginx', 'httpd', 'www-data', $::ssh_username],
  require => [
    User['apache'],
    User['nginx'],
    User['httpd'],
    User['www-data'],
    User[$::ssh_username]
  ]
}

$symfony_cache_location = $symfony_values['cache_and_logs_dir']

file { "/.puphpet-stuff/symfony.cache_and_logs_dir.conf":
  content => "${symfony_cache_location}",
}

exec { "exec mkdir -p ${symfony_cache_location}":
  command => "mkdir -p ${symfony_cache_location}",
  creates => $symfony_cache_location,
}

if ! defined(File[$symfony_cache_location]) {
  file { $symfony_cache_location:
    ensure  => directory,
    group   => 'symfonians',
    mode    => 0777,
    require => [
      Exec["exec mkdir -p ${symfony_cache_location}"],
      Group['symfonians']
    ]
  }
}
