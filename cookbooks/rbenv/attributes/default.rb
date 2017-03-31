default['rbenv']['build_packages'] = value_for_platform(
  ['rhel', 'centos', 'fedora'] => {
    'default' => %w[
    git
    make
    gcc
    zlib-devel
    openssl-devel
    readline-devel
    ncurses-devel
    gdbm-devel
    db4-devel
    libffi-devel
    tk-devel
    epel-release
    ]
  }
)
default['rbenv']['ruby_version'] = '2.4.1'
