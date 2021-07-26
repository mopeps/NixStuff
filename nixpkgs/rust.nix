{ pkgs, ... }:

{	
	pkgs.mkShell {
		nativeBuildInputs = with pkgs; [ rustc cargo gcc];
  		buildInputs = [ pkgs.cargo pkgs.rustc ];
	}


}
