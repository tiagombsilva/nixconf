{ self, inputs, ... }: {

  perSystem = { pkgs, ... }: {
    packages.myNoctaliaGreeter =
      inputs.wrapper-modules.wrappers.noctalia-greeter.wrap {
        inherit pkgs;
      };
  };

  flake.nixosModules.noctalia-greeter = {
    config,
    pkgs,
    ...
  }: {
    services.displayManager.noctalia-greeter = {
      enable = true;

      package =
        self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctaliaGreeter;

      settings = {
        keyboard = {
          layout = config.preferences.hardware.keyboard.layout;
          numlock = config.preferences.hardware.keyboard.numlock;
        };

        output = config.preferences.hardware.monitors;
      };

      cursorTheme = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };
    };
  };
}
