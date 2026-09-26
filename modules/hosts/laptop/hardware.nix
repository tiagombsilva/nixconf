{ self, inputs, ... }: {

    flake.nixosModules.laptopHardware = { config, lib, pkgs, modulesPath, ... }: {

      imports = [ (modulesPath + "/installer/scan/not-detected.nix")];

      boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage"  "sd_mod" ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/191788e6-6359-410b-ab1d-9bbb568267cd";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/1A29-4BE3";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/00994c65-b412-4d44-8861-720de60c71c1"; }
      ];
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
