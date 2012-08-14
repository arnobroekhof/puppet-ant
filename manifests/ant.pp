# Copyright 2012 ArnoBroekhof
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Class: ant::ant
#
# A puppet recipe to install Apache Ant
#
# Parameters:
#   - $version:
#         Ant version.
#
# Requires:
#   Java package installed.
#
# Sample Usage:
#   class {'ant::ant':
#     version => "1.8.4",
#   }
#
class ant::ant( $version = '1.8.4',
  $repo = {
    #url      => 'http://apache.proserve.nl/ant/binaries',
    #username => '',
    #password => '',
  } ) {

  $archive = "/tmp/apache-ant-${version}-bin.tar.gz"

  # we could use puppet-stdlib function !empty(repo) but avoiding adding a new
  # dependency for now
  if "x${repo['url']}x" != 'xx' {
    wget::authfetch { 'fetch-ant':
      source      => "${repo['url']}/apache-ant-${version}-bin.tar.gz",
      destination => $archive,
      user        => $repo['username'],
      password    => $repo['password'],
      before      => Exec['ant-untar'],
    }
  } else {
    wget::fetch { 'fetch-ant':
      source      => "http://apache.proserve.nl//ant/binaries/apache-ant-${version}-bin.tar.gz",
      destination => $archive,
      before      => Exec['ant-untar'],
    }
  }
  exec { 'ant-untar':
    command => "tar xf /tmp/apache-ant-${version}-bin.tar.gz",
    cwd     => '/opt',
    creates => "/opt/apache-ant-${version}",
    path    => ['/bin'],
  } ->
  file { '/usr/bin/ant':
    ensure => link,
    target => "/opt/apache-ant-${version}/bin/ant",
  }
  file { '/opt/ant':
    ensure => link,
    target => "/opt/apache-ant-${version}",
  }
  file { '/usr/local/bin/ant':
    ensure  => absent,
    require => Exec['ant-untar'],
  }
}
