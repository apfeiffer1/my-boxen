class people::ktf {
notify { 'class people::ktf declared': }
  $home     = "/Users/${::luser}"

  repository { "${home}/dotfiles":
    source => 'ktf/dotfiles',
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
}
