##
# Sets up puppet to run masterlessly via a systemd timer
class masterless(
    $repodir = '/opt/halyard'
    $bindir = '/usr/local/bin'
) {
    file { "${bindir}/puppet-run":
        ensure  => link,
        target  => "${repodir}/meta/puppet-run"
    }

    file { '/etc/systemd/system/puppet-run.service':
        ensure  => 'file',
        content => template('masterless/puppet-run.service.erb')
    }

    file { '/etc/systemd/system/puppet-run.timer':
        ensure  => 'file',
        content => template('masterless/puppet-run.timer.erb')
    }

    file { '/etc/systemd/system/multi-user.target.wants/puppet-run.timer':
        ensure  => 'link',
        target  => '/etc/systemd/system/puppet-run.timer',
        require => File['/etc/systemd/system/puppet-run.timer']
    }
}
