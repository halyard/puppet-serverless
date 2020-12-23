##
# Set up serverless runs on Macs
class serverless::darwin {
  $repodir = $serverless::repodir
  $bindir = $serverless::bindir
  $frequency = $serverless::frequency

  file { $bindir:
    ensure => directory
  }
  -> file { "${bindir}/puppet-run":
    ensure => link,
    target => "${repodir}/meta/puppet-run"
  }

  file { '/Library/LaunchDaemons/com.halyard.puppet-run.plist':
    ensure  => 'file',
    content => template('serverless/puppet-run.launchd.erb'),
    notify  => Exec['Puppet-run refresh launchd']
  }

  exec { 'Puppet-run refresh launchd':
    command     => 'launchctl load -wF /Library/LaunchDaemons/com.halyard.puppet-run.plist',
    refreshonly => true,
    path        => ['/usr/bin', '/bin'],
    user        => 'root'
  }
}
