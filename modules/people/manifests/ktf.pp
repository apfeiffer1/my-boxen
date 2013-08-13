class people::ktf {
  $home     = "/Users/${::luser}"

  repository { "${home}/dotfiles":
    source => 'ktf/dotfiles',
  }

  repository { "${home}/dotfiles-private":
    source => 'ktf/dotfiles-private'
  }

  file { "${home}/.zshrc":
    ensure  => link,
    mode    => '0644',
    target  => "${home}/dotfiles/zshrc",
    require => Repository["${home}/dotfiles"],
  }
  file { "${home}/.tmux.conf":
    ensure  => link,
    mode    => '0644',
    target  => "${home}/dotfiles/tmux.conf",
    require => Repository["${home}/dotfiles"],
  }
  file { "${home}/.taskrc":
    ensure  => link,
    mode    => '0644',
    target  => "${home}/dotfiles/taskrc",
    require => Repository["${home}/dotfiles"],
  }
  file { "${home}/.vimrc":
    ensure  => link,
    mode    => '0644',
    target  => "${home}/dotfiles/vimrc",
    require => Repository["${home}/dotfiles"],
  }

  file { "${home}/.muttrc":
    ensure  => link,
    mode    => '0644',
    target  => "${home}/dotfiles/muttrc",
    require => Repository["${home}/dotfiles"],
  }

  file { "${home}/.mutt":
    ensure  => directory,
    mode    => '0755',
  }

  file { "${home}/.mutt/aliases.txt":
    ensure  => present,
    mode    => '0644',
    require => File["${home}/.mutt"],
  }

  file { "${home}/.mailcap":
    ensure  => link,
    mode    => '0644',
    target  => "${home}/dotfiles/mailcap",
    require => Repository["${home}/dotfiles"],
  }

  include transmission

  git::config::global { 'user.email': value  => 'giulio.eulisse@cern.ch'}
  git::config::global { 'user.name': value  => 'Giulio Eulisse'}
  git::config::global { 'user.github': value  => 'ktf'}
  git::config::global { 'github.user': value  => 'ktf'}
  git::config::global { 'user.signingkey': value  => '03612AC1'}
  git::config::global { 'alias.graph': value  => "log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(red)%s%C(reset) %C(bold green)— %an%C(reset)%C(bold blue)%d%C(reset)' --abbrev-commit"}
}
