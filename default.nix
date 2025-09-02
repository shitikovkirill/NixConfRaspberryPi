{ config, lib, pkgs, ... }:

{
  imports = [ <nixos-hardware/raspberry-pi/4> ];
  hardware = {
    raspberry-pi."4".apply-overlays-dtmerge.enable = true;
    deviceTree = {
      enable = true;
      filter = "*rpi-4-*.dtb";
    };
  };

  console.enable = false;
  environment.systemPackages = with pkgs; [ libraspberrypi raspberrypi-eeprom ];

  # Create gpio group
  users.groups.gpio = { };

  services.udev.extraRules = ''
    SUBSYSTEM=="gpio", GROUP="gpio", MODE="0660"
    SUBSYSTEM=="gpio*", PROGRAM="${pkgs.bash}/bin/bash -c 'chown -R root:gpio /sys/class/gpio && chmod -R 770 /sys/class/gpio'"
  '';

}
