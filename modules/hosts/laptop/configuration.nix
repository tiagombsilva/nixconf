{ self, inputs, ... }: {

    flake.nixosModules.laptopConfiguration = { pkgs, lib, ... }: {
      imports = [
        self.nixosModules.laptopHardware
        self.nixosModules.niri
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_latest;

      networking.hostName = "eagle-laptop";
      networking.networkmanager.enable = true;
 
      time.timeZone = "Atlantic/Azores";

      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "pt_PT.UTF-8";
        LC_IDENTIFICATION = "pt_PT.UTF-8";
        LC_MEASUREMENT = "pt_PT.UTF-8";
        LC_MONETARY = "pt_PT.UTF-8";
        LC_NAME = "pt_PT.UTF-8";
        LC_NUMERIC = "pt_PT.UTF-8";
        LC_PAPER = "pt_PT.UTF-8";
        LC_TELEPHONE = "pt_PT.UTF-8";
        LC_TIME = "pt_PT.UTF-8";
      };

      services.xserver.xkb = {
        layout = "pt";
        variant = "";
      };

      services.displayManager.noctalia-greeter = {
        enable = true;
        settings = {
          cursor.size = 24;
          keyboard = {
            layout = "pt";
            numlock = true;
          };
        };
        cursorTheme = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
        };
      };

      console.keyMap = "pt-latin1";

      users.users."eagle" = {
        isNormalUser = true;
        description = "eagle";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
      };

      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      nixpkgs.config.allowUnfree = true;      
      
      environment.systemPackages = with pkgs; [
        firefox
        git
	nemo
      ];

      system.stateVersion = "26.05";
    };
}
