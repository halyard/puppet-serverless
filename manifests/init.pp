# @summary serverless sets up puppet to run from a local repository on a timer
#
# @param repodir path for storing local checkout of repository
# @param logdir path for puppet log storage
# @param reportdir sets where to tidy reports
# @param bindir path for storing symlink to run script
# @param bootdelay how long to wait after boot before first run
# @param frequency how often to run in seconds
#
class serverless (
  String $repodir = '/opt/halyard/repo',
  String $logdir = '/opt/halyard/logs',
  String $reportdir = '/opt/halyard/puppet/cache/reports/',
  String $bindir = '/usr/local/bin',
  String $bootdelay = '1min',
  String $frequency = '3600'
) {
  case $facts['os']['name'] {
    'Darwin': { include serverless::darwin }
    'Archlinux': { include serverless::systemd }
    'Arch': { include serverless::systemd }
    'Ubuntu': { include serverless::systemd }
    default: { fail("Module does not support ${facts['os']['family']}") }
  }

  tidy { $logdir:
    age     => '90d',
    recurse => true,
    matches => 'puppet-run.*',
  }

  tidy { $reportdir:
    age     => '90d',
    recurse => true,
    matches => '*.yaml',
  }
}
