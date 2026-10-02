{ self, inputs, ... }: {

    flake.nixosModules.laptopConfiguration = { pkgs, lib, ... }: {
      imports = [
        self.nixosModules.laptopHardware
        self.nixosModules.base

        self.nixosModules.noctalia-greeter
        self.nixosModules.niri
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_latest;

      networking.hostName = "eagle-laptop";
      networking.networkmanager.enable = true;

      services.xserver.xkb = {
        layout = "pt";
        variant = "";
      };

      console.keyMap = "pt-latin1";      
      
      environment.systemPackages = with pkgs; [
        firefox
        git
	nemo
        vscodium
      ];

      system.stateVersion = "26.05";
    };
}
