require boxen::environment
require homebrew
require gcc

Exec {
  group       => 'staff',
  logoutput   => on_failure,
  user        => $boxen_user,

  path => [
    "${boxen::config::home}/rbenv/shims",
    "${boxen::config::home}/rbenv/bin",
    "${boxen::config::home}/rbenv/plugins/ruby-build/bin",
    "${boxen::config::home}/homebrew/bin",
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin'
  ],

  environment => [
    "HOMEBREW_CACHE=${homebrew::config::cachedir}",
    "HOME=/Users/${::boxen_user}"
  ]
}

File {
  group => 'staff',
  owner => $boxen_user
}

Package {
  provider => homebrew,
  require  => Class['homebrew']
}

Repository {
  provider => git,
  extra    => [
    '--recurse-submodules'
  ],
  require  => File["${boxen::config::bindir}/boxen-git-credential"],
  config   => {
    'credential.helper' => "${boxen::config::bindir}/boxen-git-credential"
  }
}

Service {
  provider => ghlaunchd
}

Homebrew::Formula <| |> -> Package <| |>

node default {
  # core modules, needed for most things
  include dnsmasq
  include git
  include hub
  include nginx

  # fail if FDE is not enabled
  if $::root_encrypted == 'no' {
    fail('Please enable full disk encryption and try again')
  }

  # node versions
  include nodejs::v0_4
  include nodejs::v0_6
  include nodejs::v0_8
  include nodejs::v0_10

  # default ruby versions
  include ruby::1_8_7
  include ruby::1_9_2
  include ruby::1_9_3
  include ruby::2_0_0

  class { 'ruby::global':
    version => '1.9.3'
  }

  ruby::gem { "jekyll for 1.9.3":
    gem     => 'jekyll',
    ruby    => '1.9.3',
    version => '=1.0.3'
  }

  ruby::gem { "liquid for 1.9.3":
    gem     => 'liquid',
    ruby    => '1.9.3',
    version => '=2.5.1'
  }

  ruby::gem { "redcarpet for 1.9.3":
    gem     => 'redcarpet',
    ruby    => '1.9.3',
    version => '=2.2.2'
  }

  ruby::gem { "maruku for 1.9.3":
    gem     => 'maruku',
    ruby    => '1.9.3',
    version => '=0.6.1'
  }

  ruby::gem { "rdiscount for 1.9.3":
    gem     => 'rdiscount',
    ruby    => '1.9.3',
    version => '=1.6.8'
  }

  ruby::gem { "RedCloth for 1.9.3":
    gem     => 'RedCloth',
    ruby    => '1.9.3',
    version => '=4.2.9'
  }

  ruby::gem { "kramdown for 1.9.3":
    gem     => 'kramdown',
    ruby    => '1.9.3',
    version => '=1.0.2'
  }

  # common, useful packages
  package {
    [
      'ack',
      'findutils',
      'gnu-tar',
      'tmux',
      'task',
      'mutt',
      'urlview',
      'links',
      'notmuch',
      'swig',
      'tup',
      'boost',
      'mpssh',
    ]:
  }
  
  package {
      [
       "Fabric",
       'PyGithub',
       'leveldb',
      ]:
    provider => pip
  }

  # A few extra tools.
  include vagrant
  include osxfuse
  include iterm2::stable
  include vlc
  include chrome
  include sublime_text_2
  include heroku
  include python
  include python::virtualenvwrapper
  include irssi
  include sourcetree
  include groovy
  include encfs
  include erlang
  include induction

  file { "${boxen::config::srcdir}/our-boxen":
    ensure => link,
    target => $boxen::config::repodir
  }
  git::config::global { 'color.interactive': value  => 'true'}
  git::config::global { 'color.diff': value  => 'true'}
  git::config::global { 'push.default': value  => 'current'}
  
  class { 'nodejs::global': version => 'v0.10.5' }
  nodejs::module { ['hubot', 'coffee-script']: node_version => 'v0.10' }
#  python::mkvirtualenv {"/User/ktf/virtualenvs/fabric":}
#  python::pip { 'Fabric': virtualenv => "/User/ktf/virtualenvs/fabric"}
}
