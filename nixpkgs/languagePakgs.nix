{  pkgs,  inputs, lib, ...}:
{
		home.packages = with pkgs; [
			go
			rustc
			cargo
			kotlin
			ruby
			zathura
			mupdf
			python3
			python.pkgs.requests
			yarn2nix
			nodejs
			yarn
			rbenv
			openjdk
			docker-compose
			cypress
			xorg.libXft
			gradle
			];
		
}
