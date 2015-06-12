#
# Cookbook Name:: marketplace_image
# Recipe:: _aws
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

file '/etc/chef/ohai/hints/ec2.json' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create_if_missing
end

user 'ec2-user' do
  home '/home/ec2-user'
  shell '/bin/bash'
  action [:create, :lock]
end

# TODO: Add ec2 verification hook

include_recipe 'marketplace_image::_aws_security'