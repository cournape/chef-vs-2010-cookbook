if kernel['machine'] =~ /x86_64/
else
end

# VS 2010
default['vs-2010']['base-extraction-path']     = "C:/software/vs2010/"
default['vs-2010']['base-network-location']    = "\\\\10.0.1.200\\"
default['vs-2010']['base-iso-name']            = "en_visual_studio_2010_ultimate_x86_dvd_509116.iso"
default['vs-2010']['base-iso-location']        = default['vs-2010']['base-network-location'] + default['vs-2010']['base-iso-name']

# VS 2010 SP1
default['vs-2010']['base-extraction-path']     = "C:/software/vs2010/"
default['vs-2010']['sp1-network-location']     = default['vs-2010']['base-network-location']
default['vs-2010']['sp1-iso-name']             = "VS2010SP1dvd1.iso"
default['vs-2010']['sp1-iso-location']         = default['vs-2010']['sp1-network-location'] + default['vs-2010']['sp1-iso-name']