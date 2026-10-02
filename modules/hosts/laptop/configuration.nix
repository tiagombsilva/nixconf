{ self, inputs, ... }: {

    flake.nixosModules.laptopConfiguration = { pkgs, lib, ... }: {
      imports = [
        self.nixosModules.laptopHardware
        self.nixosModules.base

        self.nixosModules.niri
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_latest;

      networking.hostName = "eagle-laptop";
      networking.networkmanager.enable = true;

      services.displayManager.noctalia-greeter = {
        enable = true;

        settings.outputs = [
          {
            name = "eDP-2";
            mode = "1920x1200@165.004";
            scale = 1.0;
            position = "0,0";
          }
        ];
      };

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
