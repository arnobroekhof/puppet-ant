# == Class: ant
#
# Full description of class ant here.
#
# === Parameters
#
# Document parameters here.
#
# [*version*]
# this is the version of ant that needs to be installed
#
# === Requires
#
# Java package installed
#
# === Examples
#
#  class { ant:
#    version => '1.8.4',
#  }
#
# === Authors
#
# Arno Broekhof <arnobroekhof@gmail.com>
#
# === Copyright
#
# Copyright 2012 Arno Broekhof, unless otherwise noted.
#
class ant  {
  notice("Installing Ant $version")

  class { 'ant::ant' :
    version => '1.8.4',
  }	

}
