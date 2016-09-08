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

  include supervisord

  file { '/etc/init.d/supervisor':
    ensure => absent,
  }

  $source_dir = '/etc/supervisor/conf.d'
  $target_dir = '/etc/supervisor.d'

  file { 'new_supervisor_conf_dir' :
    path => $target_dir,
    ensure => 'directory',
    source => "file://${source_dir}",
    recurse => true,
    before => File[$source_dir],
  }->
  file { 'old_supervisor_conf_dir' :
    path => $source_dir,
    ensure => 'absent',
    purge => true,
    recurse => true,
    force => true,
  }->
  file { $source_dir:
    ensure => link,
    target => $target_dir,
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

  package { 'superlance':
    ensure   => installed,
    provider => 'pip',
    require  => Package['supervisor'],
  }

}
