{
    config,
    pkgs,
    ...
  }: {
    flake.nixosModules.base = {...}: {
    users.users.eagle = {
      isNormalUser = true;
      description = "eagle's account";
      extraGroups = ["wheel" "networkmanager"];
    };
};
}
