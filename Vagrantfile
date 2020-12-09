# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "kalilinux/rolling"

  config.vm.hostname = "sss-kali"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    vb.name = "SSS Kali" + Time.now.strftime(" %Y-%m-%d")

    # Display the VirtualBox GUI when booting the machine
    vb.gui = true

    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.provision :shell, path: "bootstrap.sh"
end
