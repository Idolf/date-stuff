{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, self, ... }@inputs:
    {
      defaultPackage.x86_64-linux =
        with import nixpkgs { system = "x86_64-linux"; };
        callPackage ./derivation.nix { };

      checks.x86_64-linux.build = self.defaultPackage.x86_64-linux;

      overlay = final: prev: {
        date-stuff = self.defaultPackage.x86_64-linux;
      };
    };
}
