class projects::ai_cern {
  repository {"punch-modules-repo":
    source => "ssh://gitgw.cern.ch:10022/punch-modules",
    path => "/Users/$::luser/work/punch-modules",
    ensure => present,
  }
}
