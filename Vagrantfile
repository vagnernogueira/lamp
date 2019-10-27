##
# Primeiro instale VirtualBox, VirtualBox Extension Pack, Vagrant, plugin vagrant-vbguest
##
Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian10"
  config.vm.box_check_update = false
  config.vm.define "lamp01" do |machine|
    machine.vm.network "public_network", ip: "192.168.1.99"
    machine.vm.hostname = "lamp01"
    machine.vm.synced_folder ".", "/vagrant", SharedFoldersEnableSymlinksCreate: false
    machine.vm.provision "shell", path: "provision.sh"
    machine.vm.provider "virtualbox" do |vb|
      vb.gui = false
      vb.memory = "1024"
      vb.name = "lamp01"
    end
  end
end