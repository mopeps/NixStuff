let pkgs = import <nixpkgs> { overlays = [ (import ./overlays/cypress-overlay.nix) ]; };
in pkgs.mkShell {
  name = "cypress-example";

  buildInputs = with pkgs; [
    cypress
    (with dotnetCorePackages; combinePackages [ sdk_5_0 net_5_0 ])
    nodejs
  ];

  shellHook = ''
    export CYPRESS_INSTALL_BINARY=0
    export CYPRESS_RUN_BINARY=${pkgs.cypress}/bin/Cypress
  '';
}
