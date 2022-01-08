name             "packages"
maintainer       "Chef Software, Inc."
maintainer_email "matt@chef.io"
license          "Apache-2.0"
description      "Installs list of packages from an attribute."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.1.0"
chef_version '>= 12.0' if respond_to?(:chef_version)

%w( aix amazon centos fedora freebsd debian oracle mac_os_x redhat suse opensuse opensuseleap ubuntu windows zlinux ).each do |os|
  supports os
end

source_url 'https://github.com/mattray/packages-cookbook' if
  respond_to?(:source_url)
issues_url 'https://github.com/mattray/packages-cookbook/issues' if
  respond_to?(:issues_url)
