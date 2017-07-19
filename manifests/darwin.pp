##
# Set up masterless runs on Macs
class masterless::darwin {
  $repodir = $masterless::repodir
  $bindir = $masterless::bindir
  $frequency = $masterless::frequency

  file { "${bindir}/puppet-run":
    ensure => link,
    target => "${repodir}/meta/puppet-run"
  }

  file { '/Library/LaunchDaemons/com.halyard.puppet-run.plist':
    ensure  => 'file',
    content => template('masterless/puppet-run.launchd.erb'),
    notify  =>  Exec['Puppet-run refresh launchd']
  }

  exec { 'Puppet-run refresh launchd':
    command     => 'launchctl load -wF /Library/LaunchDaemons/com.halyard.puppet-run.plist',
    refreshonly => true,
    path        => ['/usr/bin', '/bin'],
    user        => 'root'
  }
}
