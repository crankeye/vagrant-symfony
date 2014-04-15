Vagrant.configure("2") do |config|
    config.vm.define :development do |dev_config|
        dev_config.vm.box = "ubuntu-precise12042-x64-vbox43"
        dev_config.vm.box_url = "http://box.puphpet.com/ubuntu-precise12042-x64-vbox43.box"
        dev_config.ssh.forward_agent = true

        # Default private IP is 192.168.56.101. When running multiple boxes simultaneously give each a unique IP.
        dev_config.vm.network :private_network, ip: "192.168.56.101"
        
        # Default value is development. Set to whatever you like.
        dev_config.vm.hostname = "development"
        
        # Disable the default /vagrant synced folder
        dev_config.vm.synced_folder ".", "/vagrant", disabled: true
        
        # Mount /project directory to /var/www/project using default synced folders
        dev_config.vm.synced_folder "./", "/var/www", {:mount_options => ['dmode=777','fmode=777']}
        
        # Rsync project directory to /var/www/project Requires Vagrant 1.5.x >=
        # These settings are experimental and may require additional refinement
        #dev_config.vm.synced_folder "project/", "/var/www/project", type: "rsync", 
        #    :rsync__args => ["--chmod=ugo=rwX", "-rltgoD", "--delete", "-z"], 
        #    :rsync__exclude => [".git/"] 
        
        dev_config.vm.provider :virtualbox do |v|
            
            # Set the memory limit, adjust based on your system
            v.customize ["modifyvm", :id, "--memory", "2048"]
            
            # Tune SSH connection speed
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
            
            # Enable shared folder symlinks
            v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]

        end

        # You can override the default manifest by setting the envoirnment variable MANIFEST
        puppet_manifest = ENV['MANIFEST'] == nil ? "phpbase.pp" : ENV['MANIFEST']

        dev_config.vm.provision :puppet do |puppet|
            puppet.manifests_path = "puppet/manifests"
            puppet.manifest_file  = puppet_manifest
            puppet.module_path = "puppet/modules"
            #puppet.options = "--verbose --debug"
        end
    end
end
