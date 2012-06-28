#
# Author:: Joe Fitzgerald (<joe.fitzgerald@emc.com>)
# Cookbook Name:: vs-2010
# Recipe:: default
#
# Copyright 2012, EMC Corporation
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
#

# Validate That ISOs Are Available In Specified Locations

# Unzip VS 2010 ISO To Staging Folder

## Resorting to net use because powershell has a bug preventing correct user switching
windows_batch "unzip_vs2010" do
  code <<-EOH
  net use #{node['vs-2010']['base-network-location']} /user:#{node['vs-2010']['base-network-username']} #{node['vs-2010']['base-network-password']} 
  7z.exe x #{node['vs-2010']['base-iso-location']} -o#{node['vs-2010']['base-iso-location']} -r -y
  net use #{node['vs-2010']['base-network-location']} /delete
  EOH
end

# Unzip VS 2010 SP1 To Staging Folder

# Install VS 2010
#windows_package node['vs-2010']['package_name'] do
#  source node['vs-2010']['url']
#  checksum node['vs-2010']['checksum']
#  options "INSTALLDIR=\"#{node['7-zip']['home']}\""
#  action :install
end

# Install VS 2010 SP1

