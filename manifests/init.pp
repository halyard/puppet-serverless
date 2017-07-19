##
# Sets up puppet to run masterlessly via a systemd timer
class masterless(
    $repodir = '/opt/halyard/repo',
    $bindir = '/usr/local/bin',
    $bootdelay = '1min',
    $frequency = '3600'
) {
    case $::osfamily {
        'Darwin': { include masterless::darwin }
        'Archlinux': { include masterless::systemd }
        default: { fail("Module does not support ${::osfamily}") }
    }
}
