Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"

  # Configura el reenvío del puerto para acceder al servidor web desde el host
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Configura la memoria RAM de la máquina virtual
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end

  # Aprovisionamiento con Chef
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "wordpress::default"
    chef.arguments = "--chef-license accept"
  end  
end
