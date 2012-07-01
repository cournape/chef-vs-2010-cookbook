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
windows_batch "mount_vs2010_share" do
  code <<-EOH
  net use #{node['vs-2010']['base-network-location']} /user:#{node['vs-2010']['base-network-username']} #{node['vs-2010']['base-network-password']} 
  EOH
end

vs2010_extraction_path = node['vs-2010']['base-extraction-path'].gsub("/", "\\")
vs2010_iso_location = node['vs-2010']['base-iso-location'].gsub("/", "\\")
windows_batch "unzip_vs2010" do
  code <<-EOH
  7z.exe x #{vs2010_iso_location} -o#{vs2010_extraction_path} -r -y
  EOH
end

windows_batch "unmount_vs2010_share" do
  code <<-EOH
  net use #{node['vs-2010']['base-network-location']} /delete
  EOH
end

# Copy unattend.ini to VS2010 Folder
unattendini = File.join(node['vs-2010']['base-extraction-path'], "unattend.ini").gsub("/", "\\")
cookbook_file "#{unattendini}" do
  source "unattend.ini"
end

# Copy unattend.bat to VS2010 Folder
#unattendbat = File.join(node['vs-2010']['base-extraction-path'], "unattend.bat")
#cookbook_file "#{unattendbat}" do
#  source "unattend.bat"
#end

# psexec /accepteula -u #{node['vs-2010']['base-network-username']} -p #{node['vs-2010']['base-network-password']} 7z.exe x #{node['vs-2010']['base-iso-location']} -o#{node['vs-2010']['base-iso-location']} -r -y
#  net use #{node['vs-2010']['base-network-location']} /user:#{node['vs-2010']['base-network-username']} #{node['vs-2010']['base-network-password']} 
#  net use #{node['vs-2010']['base-network-location']} /delete
# Unzip VS 2010 SP1 To Staging Folder

windows_batch "mount_vs2010_sp1_share" do
  code <<-EOH
  net use #{node['vs-2010']['sp1-network-location']} /user:#{node['vs-2010']['sp1-network-username']} #{node['vs-2010']['sp1-network-password']} 
  EOH
end

vs2010_sp1_extraction_path = node['vs-2010']['sp1-extraction-path'].gsub("/", "\\")
vs2010_sp1_iso_location = node['vs-2010']['sp1-iso-location'].gsub("/", "\\")
windows_batch "unzip_vs2010_sp1" do
  code <<-EOH
  7z.exe x #{vs2010_sp1_iso_location} -o#{vs2010_sp1_extraction_path} -r -y
  EOH
end

windows_batch "unmount_vs2010_sp1_share" do
  code <<-EOH
  net use #{node['vs-2010']['sp1-network-location']} /delete
  EOH
end

# Install VS 2010
vs2010setup = File.join(node['vs-2010']['base-extraction-path'], "setup", "setup.exe").gsub("/", "\\")
Chef::Log.info("Installing Visual Studio 2010: #{vs2010setup}")

windows_package "Microsoft Visual Studio 2010 Ultimate (x86)" do
  source "#{vs2010setup}"
  options "/q /norestart /unattendfile \"#{unattendini}\""
  installer_type :custom
  action :install
end

# Install Help Content
Chef::Log.info("Installing Visual Studio 2010 Documentation:")
Chef::Log.info("Help Viewer Location: #{node['vs-2010']['helpviewer-location']}")
Chef::Log.info("Source Media: #{node['vs-2010']['helpviewer-content']}")
Chef::Log.info("Content Path: #{node['vs-2010']['helpviewer-content-path']}")

windows_package "Microsoft Visual Studio 2010 Documentation" do
  source "#{node['vs-2010']['helpviewer-location']}"
  options "/silent /product VS /version 100 /locale en-US /content \"#{node['vs-2010']['helpviewer-content-path']}\" /sourceMedia \"#{node['vs-2010']['helpviewer-content']}\""
  installer_type :custom
  action :install
end

# Install VS 2010 SP1
vs2010sp1setup = File.join(node['vs-2010']['sp1-extraction-path'], "setup.exe").gsub("/", "\\")
Chef::Log.info("Installing Visual Studio 2010 SP1: #{vs2010sp1setup}")

windows_reboot 60 do
  reason 'Chef - Visual Studio 2010 + SP1 Setup'
  action :nothing
end

windows_package "Microsoft Visual Studio 2010 SP1" do
  source "#{vs2010sp1setup}"
  options "/q /norestart"
  installer_type :custom
  action :install
  notifies :request, 'windows_reboot[60]'
end

