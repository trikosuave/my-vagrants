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
  } ~>
  exec {"add proxy to global exports":
    command => 'echo "export http_proxy=http://proxy-us.intel.com:911" >> /etc/environment; echo "export https_proxy=http://proxy-us.intel.com:911" >> /etc/environment; echo "no_proxy="127.0.0.1,localhost,${ipaddress_eth1}" >> /etc/environment',
    refreshonly => true,
  } ~>
  exec {"update apt":
    command => "apt-get -y update;apt-get -y dist-upgrade",
    refreshonly => true,
  }

  group { "puppet": ensure => "present"; }  ->

  class { "aptitude": } ->
  package { "openjdk-6-jre": ensure => "present", } ->
  package { "curl": ensure => "present", } ->
  package { "git-core": ensure => "installed", } -> 
  package { "vim": ensure => "installed", } ->
  package { "wget": ensure => "installed", } 

}
