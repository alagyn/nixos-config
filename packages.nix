{configs, pkgs, ...}:
let unstable = import <nixos-unstable>
    {
        config.allowUnfree = true;
    };
in
{
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        wget
        curl
        nano
        discord
        git
        firefox
        google-chrome
        python3
        cmakeCurses
        yakuake
        pciutils
        krdc
        teamviewer
        nodejs
        aseprite

        unstable.vscode
        unstable.vivaldi
        unstable.vivaldi-ffmpeg-codecs
        unstable.obsidian
    ];

    # Enable for Obsidian, insecure because EOL
    #nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

    services.teamviewer.enable = true;

 }
