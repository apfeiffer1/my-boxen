class people::ktf {
notify { 'class people::ktf declared': }
  repository { "/Users/${my_username}/dotfiles":
    source => 'ktf/dotfiles',
  }

}
