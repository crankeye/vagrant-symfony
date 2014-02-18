Vagrant.configure("2") do |config|
    config.vm.define :development do |dev_config|
        dev_config.vm.box = "ubuntu-precise12042-x64-vbox43"
        dev_config.vm.box_url = "http://box.puphpet.com/ubuntu-precise12042-x64-vbox43.box"
        dev_config.ssh.forward_agent = true

        dev_config.vm.network :private_network, ip: "192.168.56.101"
        
        dev_config.vm.hostname = "development"
        dev_config.vm.synced_folder "./", "/var/www", {:mount_options => ['dmode=777','fmode=777'], :owner => "www-data", :group => "www-data"}
        dev_config.vm.provision :shell, :inline => "echo \"America/Phoenix\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

        dev_config.vm.provider :virtualbox do |v|
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            v.customize ["modifyvm", :id, "--memory", "2048"]
            v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]
            v.customize ["modifyvm", :id, "--ioapic", "on"]
        end

        puppet_manifest = ENV['MANIFEST'] == nil ? "phpbase.pp" : ENV['MANIFEST']

        dev_config.vm.provision :puppet do |puppet|
            puppet.manifests_path = "puppet/manifests"
            puppet.manifest_file  = puppet_manifest
            puppet.module_path = "puppet/modules"
            #puppet.options = "--verbose --debug"
        end
    end
end
