##
# Set up serverless runs on systemd-based systems
class serverless::systemd {
  $repodir = $serverless::repodir
  $bindir = $serverless::bindir
  $bootdelay = $serverless::bootdelay
  $frequency = $serverless::frequency

  file { '/etc/systemd/system/multi-user.target.wants/puppet.service':
    ensure => absent,
  }

  file { ["${bindir}/puppet-run", "${bindir}/pr"]:
    ensure => link,
    target => "${repodir}/meta/puppet-run",
  }

  file { '/etc/systemd/system/puppet-run.service':
    ensure  => 'file',
    content => template('serverless/puppet-run.service.erb'),
    notify  => Exec['Puppet-run refresh systemd'],
  }

  file { '/etc/systemd/system/puppet-run.timer':
    ensure  => 'file',
    content => template('serverless/puppet-run.timer.erb'),
    notify  => Exec['Puppet-run refresh systemd'],
  }

  file { '/etc/systemd/system/multi-user.target.wants/puppet-run.timer':
    ensure  => 'link',
    target  => '/etc/systemd/system/puppet-run.timer',
    require => File['/etc/systemd/system/puppet-run.timer'],
    notify  => Exec['Puppet-run refresh systemd'],
  }

  exec { 'Puppet-run refresh systemd':
    command     => 'systemctl daemon-reload',
    refreshonly => true,
    path        => ['/usr/bin', '/bin'],
  }
  ~> exec { 'Start puppet-run':
    command     => 'systemctl start puppet-run.timer',
    refreshonly => true,
    path        => ['/usr/bin', '/bin'],
  }
}
