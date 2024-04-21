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
        gnumake
        gcc

        unstable.vscode
        unstable.vivaldi
        unstable.vivaldi-ffmpeg-codecs
        unstable.obsidian
    ];

    services.teamviewer.enable = true;

 }
