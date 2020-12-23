##
# Sets up puppet to run serverlessly via a systemd timer
class serverless(
    $repodir = '/opt/halyard/repo',
    $logdir = '/opt/halyard/logs',
    $bindir = '/usr/local/bin',
    $bootdelay = '1min',
    $frequency = '3600'
) {
    case $::osfamily {
        'Darwin': { include serverless::darwin }
        'Archlinux': { include serverless::systemd }
        default: { fail("Module does not support ${::osfamily}") }
    }

    tidy { $logdir:
      age     => '90d',
      recurse => true,
      matches => 'puppet-run.*',
    }
}
