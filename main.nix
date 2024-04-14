{config, pkgs, ...}:
{
    imports =
    [ 
        # Include the results of the hardware scan.
        /etc/nixos/hardware-configuration.nix

        ./packages.nix
        ./graphics.nix
        ./bash.nix
    ];

    networking.hostName = "themisto-station";
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.alagyn = 
    {
        isNormalUser = true;
        description = "Ben Kimbrough";
        extraGroups = [ "networkmanager" "wheel" "docker" ];
    };

    # Load windows drive
    fileSystems."/windows" = 
    {
        device = "/dev/nvme1n1p3";
        fsType = "ntfs-3g";
        options = ["rw" "uid=1000" "nofail"];
    };

    # Use the latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # Bootloader
    boot.loader = 
    {
        efi = 
        {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
        };
        # Use grub so we can load Windows
        grub = 
        {
            devices = [ "nodev" ];
            efiSupport = true;
            enable = true;
            # Add windows stuff
            extraEntries = ''
            menuentry 'Windows 11' {
                insmod part_gpt
                insmod fat
                search --no-floppy --fs-uuid --set=root 8C03-E0DB
                chainloader /EFI/Microsoft/Boot/bootmgfw.efi
            }
            '';
            timeoutStyle = "menu";
            backgroundColor = "#242424";
        };
        # Set no timeout
        timeout=null;
    };

    # enable ntfs to mount windows drive    
    boot.supportedFilesystems = [ "ntfs" ];

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "America/New_York";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = 
    {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
    };

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    security.sudo.wheelNeedsPassword = false;
    services.pipewire = 
    {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.11"; # Did you read the comment?
}