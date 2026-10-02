{ self, inputs, ... }: {

  flake.nixosModules.niri = { config, lib, pkgs, ... }: {
    options.programs.niri.keyboardLayout = lib.mkOption {
      type = lib.types.str;
      default = "us";
    };

    config.programs.niri = {
      enable = true;

      package =
        self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri {
          keyboardLayout = config.programs.niri.keyboardLayout;
        };
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = { keyboardLayout }:
      inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;

        settings = {
          spawn-at-startup = [
            (lib.getExe self'.packages.myNoctalia)
          ];

          input.keyboard.xkb.layout = keyboardLayout;

          xwayland-satellite.path =
            lib.getExe pkgs.xwayland-satellite;

          layout.gaps = 5;

          input.touchpad = {
            tap = {};
            tap-button-map = "left-right-middle";
            natural-scroll = {};
            dwt = {};
          };

          binds = {
            "Mod+Return".spawn-sh =
              lib.getExe pkgs.kitty;

            "Mod+Q".close-window = [];

            "Mod+S".spawn-sh =
              "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          };
        };
      };
  };
}
