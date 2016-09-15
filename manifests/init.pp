# == Class: sc_supervisor
#
# This is a wrapper for ajcrowe-supervisord module to add some specific
# funtionality for scalecommerce projects.
#
# === Parameters
#
# [*init_path*]
#   path to supervisor init scripts
#
# === Authors
#
# Andreas Ziethen <az@scale.sc>
#
# === Copyright
#
# Copyright 2016 ScaleCommerce GmbH, Berlin
#
class sc_supervisor (
  $init_path        = '/etc/supervisor.init',
) {

  Package['python-pip']-> Class['supervisord']->File['/etc/supervisor/supervisord.conf']

  include supervisord

  file { '/etc/init.d/supervisor':
    ensure => absent,
  }

  file { '/etc/supervisor/supervisord.conf' :
    ensure => link,
    target => '/etc/supervisord.conf',
  }


  file { $sc_supervisor::init_path:
    ensure => directory,
  }
  file { "${sc_supervisor::init_path}/supervisor-init-wrapper":
    content => template("${module_name}/supervisor-init-wrapper.erb"),
    mode => '700',
  }

  package { 'python-pip':
    ensure => installed,
  }->

  #package { 'superlance':
  #  ensure   => installed,
  #  provider => 'pip',
  # require  => Package['supervisor'],
  #}

}
