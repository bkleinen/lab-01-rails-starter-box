Vagrant.configure("2") do |config|
  config.vm.box       = 'railsbox'
  config.vm.box_url   = 'http://files.vagrantup.com/precise32.box'
  config.vm.host_name = 'rails-starter-box'

  config.vm.network "forwarded_port", guest:3000, host:3000

  config.vm.synced_folder "railsapps/", "/railsapps"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'puppet/manifests'
	puppet.manifest_file = 'default.pp'
    puppet.module_path   = 'puppet/modules'
	puppet.options = "--verbose --debug"
  end


  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
end

