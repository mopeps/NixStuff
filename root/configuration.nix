# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,  ... }:
let theme = import ./theme.nix {inherit pkgs;};
 in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./postgres.nix
      ./docker.nix
      ./fonts.nix
      <home-manager/nixos>
    ];
  nixpkgs = {
	config.allowUnfree = true;
  };
  # Use the systemd-boot EFI boot loader.
  boot = {
  	blacklistedKernelModules = ["nouveau" "nvidia_drm" "nvidia_modeset"];
  	loader.systemd-boot.enable = true;
  	loader = {
		efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/boot/efi";
		};
		grub = {
			enable = true;
			useOSProber = true;
			device = "nodev";
			efiSupport = true;
			};
	};
	kernelModules = [ "kvm-intel" "nvidia" ];
	kernelParams = [ "acpi_enforce_resources=lax" ];
   };
   #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  

  # Very important for small hard drives
   nix.autoOptimiseStore = true;
   nix.gc = {
  	automatic = true;
  	dates = "weekly";
  	options = "--delete-older-than 7d";
   };
  # Set your time zone.
   time.timeZone = "America/Argentina/Buenos_Aires";
  
  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   i18n.supportedLocales = ["en_US.UTF-8/UTF-8"];
   console =
   let
      normal = with theme.colors; [ c0 c1 c2 c3 c4 c5 c6 c7 ];
      bright = with theme.colors; [ c8 c9 c10 c11 c12 c13 c14 c15 ];
    in
    {
     colors = normal ++ bright;
     font = "Lat2-Terminus16";
     keyMap = "us";
   };

    programs.nm-applet.enable = true;  
    networking.hostName = "Lukkz"; # Define your hostname.
    networking = {
    
    	nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" ];

    	networkmanager = {
      		enable = true;
      		dns = "none";
      		wifi.backend = "iwd";
    	};

  };

  # Enable the X11 windowing system.
   services.pantheon.apps.enable = false;
   services.xserver.enable = true;
  # Configure keymap in X11
   services.xserver = {
	displayManager = {
		lightdm.enable = true;
	};
	windowManager = {
		xmonad = {
			enable = true;
			enableContribAndExtras = true;
			extraPackages = hpkgs: with hpkgs; [
				xmonad
				xmonad-contrib
				xmonad-extras
			];
			ghcArgs = [
				"-O2"
            			"-fexcess-precision"
            			"-optc-O3"
	    		];
		};
	};
		
	layout = "us";
	xkbOptions = "eurosign:e";
	videoDrivers = [ 
		"modesetting"	
	#	"nvidia"
	];
   };
   services.dbus.packages = with pkgs; [
   	gnome3.dconf
   ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
   sound.enable = true;
   hardware = {
	pulseaudio.enable = true;
	opengl = {
		driSupport.enabled = true;
		extraPackages = [
			pkgs.libGL_driver
			pkgs.linuxPackages.nvidia_x11.out
		];
	};
   };

  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.mopeps = {
     isNormalUser = true;
     home = "/home/mopeps";
     extraGroups = [ "wheel"
		     "networkmanager"
	             "video"
                     "audio"
		     "docker"
		    ]; 
     shell = pkgs.zsh;	
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment =
   let
	iwdSettings.Settings.AutoConnect = true;
	iwdConfigFile = (pkgs.formats.ini { }).generate "main.conf" iwdSettings;
	nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
		export __NV_PRIME_RENDER_OFFLOAD=1
		export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-GO
		export __GLX_VENDOR_LIBRARY_NAME=nvidia
		export __VK_LAYER_NV_optimus=NVIDIA_only
		exec -a "$0" "$@"
	'';
   in
   {
    variables = {
	EDITOR = "nvim";
	TERMINAL = "kitty";

    };
    binsh = "${pkgs.zsh}/bin/zsh";
    systemPackages = with pkgs; [
     networkmanager
     alsaUtils
     alsa-firmware
     alsaLib
     libpulseaudio
     brightnessctl
     coreutils
     file
     git
     glxinfo
     libva-utils
     lm_sensors
     cpufrequtils
     man-pages
     man-pages-posix
     pavucontrol
     pciutils
     psmisc
     pulseaudio
     util-linux
     zip
     unzip
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     xcompmgr
     firefox
     curl
     nettools
     neofetch
     neovim	
     xmobar
     nitrogen
     dmenu
     lf
     nvidia-offload
     htop
     powertop
     xst
     wpgtk
     lxappearance
     brightnessctl
     xorg.xcursorthemes
     xorg.xbacklight
     xorg.xinput
     xorg.xkbutils
     xorg.xmodmap
     xorg.xrdb
     xorg.xrandr
   ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   #programs.gnupg.agent = {
   #  enable = true;
   #  enableSSHSupport = true;
   #};
  # List services that you want to enable:
    programs.dconf.enable = true;


  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = true;
  services.mysql = {
	enable = true;
	package = pkgs.mariadb;
	user = "mopeps";

	
  }; 
  programs.light.enable = true;  
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
   
  systemd.services.pci_gpu = {
  	enable = true;
	script = ''
		echo -n "1" > /sys/bus/pci/devices/0000:02:00.0/remove
	'';
	description = "turns the fucking nvidia hybrid gpu off";
	unitConfig = {
		Type = "simple";
	};
	wantedBy = ["default.target"];

  };
  system.stateVersion = "21.11"; # Did you read the comment?
}

