{ pkgs }:

rec {
	colors = import ./colors/dracula.nix {inherit pkgs;};
}
