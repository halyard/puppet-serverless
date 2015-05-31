class masterless(
    $codedir = params_lookup('codedir'),
    $bindir  = params_lookup('bindir')
    ) inherits masterless::params {

    $configpath = "${codedir}/conf/puppet.conf"
    $envdir = "${codedir}/environments/production"
    $manifestpath = "${envdir}/manifests/site.pp"

    file { "${bindir}/puppet-run":
        ensure => 'file',
        content => template('masterless/puppet-run.erb'),
        mode => '0755'
    }

    file { '/etc/systemd/system/puppet-run.service':
        ensure => 'file',
        content => template('masterless/puppet-run.service.erb')
    }

    file { '/etc/systemd/system/puppet-run.timer':
        ensure => 'file',
        content => template('masterless/puppet-run.timer.erb')
    }

    file { '/etc/systemd/system/multi-user.target.wants/puppet-run.timer':
        ensure => 'link',
        target => '/etc/systemd/system/puppet-run.timer',
        require => File['/etc/systemd/system/puppet-run.timer']
    }
}
