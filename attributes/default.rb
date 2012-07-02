if kernel['machine'] =~ /x86_64/
else
end

# VS 2010
default['vs-2010']['base-extraction-path']     = File.join("C:\\software", "VS2010").gsub("/", "\\")
default['vs-2010']['base-network-location']    = "\\\\10.0.1.199\\Software"
default['vs-2010']['base-network-username']    = "chefclient"
default['vs-2010']['base-network-password']    = "pass@word1"
default['vs-2010']['base-iso-name']            = "en_visual_studio_2010_ultimate_x86_dvd_509116.iso"
default['vs-2010']['base-iso-location']        = File.join(default['vs-2010']['base-network-location'], default['vs-2010']['base-iso-name']).gsub("/", "\\")
default['vs-2010']['base-display-name']        = "Microsoft Visual Studio 2010 Ultimate - ENU"

default['vs-2010']['helpviewer-content-path']  = File.join("#{ENV['PROGRAMDATA']}", "Microsoft", "HelpLibrary").gsub("/", "\\")
default['vs-2010']['helpviewer-path']          = File.join("C:/Program Files", "Microsoft Help Viewer", "v1.0").gsub("/", "\\")
default['vs-2010']['helpviewer-name']          = "HelpLibManager.exe"
default['vs-2010']['helpviewer-location']      = File.join(default['vs-2010']['helpviewer-path'], default['vs-2010']['helpviewer-name']).gsub("/", "\\")
default['vs-2010']['helpviewer-content']       = File.join(default['vs-2010']['base-extraction-path'], "ProductDocumentation", "HelpContentSetup.msha").gsub("/", "\\")

# VS 2010 SP1
default['vs-2010']['sp1-extraction-path']      = File.join(default['vs-2010']['base-extraction-path'], "SP1").gsub("/", "\\")
default['vs-2010']['sp1-network-location']     = default['vs-2010']['base-network-location']
default['vs-2010']['sp1-network-username']     = default['vs-2010']['base-network-username'] 
default['vs-2010']['sp1-network-password']     = default['vs-2010']['base-network-password']
default['vs-2010']['sp1-iso-name']             = "VS2010SP1dvd1.iso"
default['vs-2010']['sp1-iso-location']         = File.join(default['vs-2010']['sp1-network-location'], default['vs-2010']['sp1-iso-name']).gsub("/", "\\")
default['vs-2010']['sp1-display-name']        = "Microsoft Visual Studio 2010 Service Pack 1"