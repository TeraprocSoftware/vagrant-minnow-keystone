Vagrant.require_version ">= 1.4.3"
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	numNodes = 1
	r = numNodes..1
	(r.first).downto(r.last).each do |i|
		config.vm.define "minnow-#{i}" do |node|
			node.vm.box = "ubuntu14"
			node.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"
			node.vm.provider "virtualbox" do |v|
			    v.name = "minnow#{i}"
			    v.customize ["modifyvm", :id, "--memory", "2048"]
			end
			if i < 10
				node.vm.network :private_network, ip: "10.211.66.10#{i}"
			else
				node.vm.network :private_network, ip: "10.211.66.1#{i}"
			end
			node.vm.hostname = "minnow#{i}"
			node.vm.provision "shell", path: "scripts/setup-ubuntu.sh"
			node.vm.provision "shell", path: "scripts/setup-ubuntu-ntp.sh"
			node.vm.provision "shell", path: "scripts/setup-java.sh"
			node.vm.provision "shell", path: "scripts/setup-postgres.sh"
			node.vm.provision "shell", path: "scripts/setup-keystone.sh"
		end
	end
end