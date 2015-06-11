#
# Cookbook Name:: marketplace_image
# Recipe:: _security
#
# Copyright (C) 2015 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'openssh::default'
include_recipe 'marketplace_image::_security_controls'

MarketplaceHelpers.user_directories.each do |_user, dir|
  %w(id_rsa id_rsa.pub authorized_keys).each do |ssh_file|
    file ::File.join(dir, '.ssh', ssh_file) do
      action :delete
    end
  end

  file ::File.join(dir, '.bash_history') do
    action :delete
  end
end

MarketplaceHelpers.system_ssh_keys.each do |key|
  file key do
    action :delete
  end
end

MarketplaceHelpers.sudoers.each do |sudo_user|
  file sudo_user do
    action :delete
  end
end

user 'root' do
  action :lock
end

# delete /tmp last
%w(/tmp /var/log /var/chef /etc/chef).each do |dir|
  directory dir do
    action :delete
    recursive true
  end
end
