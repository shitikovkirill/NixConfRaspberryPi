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

  # Change permissions gpio devices
  services.udev.extraRules = ''
    SUBSYSTEM=="gpio", ACTION=="add", GROUP="gpio", MODE="0660"
    SUBSYSTEM=="gpio*", ACTION=="add", GROUP="gpio", MODE="0660"
    SUBSYSTEM=="gpio", KERNEL=="gpiochip*", GROUP="gpio", MODE="0660"
  '';

}
