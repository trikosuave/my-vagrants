class base {
  file {"/etc/gitconfig":
  	owner => root,
	group => root,
	mode => '0644',
	content => template('base/gitconfig.erb'),
  } ->
  file {"/etc/apt/apt.conf":
  	owner => root,
	group => root,
	mode => '0644',
	content => template('base/apt.conf.erb'),
  } ->

  group { "puppet": ensure => "present"; }  ->

  class { "aptitude": } ->
  package { "openjdk-6-jre": ensure => "present", } ->
  package { "curl": ensure => "present", } ->
  package { "git-core": ensure => "installed", } -> 
  package { "vim": ensure => "installed", } ->
  package { "wget": ensure => "installed", } 

  exec { "/sbin/reboot": refreshonly => "true" }

}
