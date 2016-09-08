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

}
