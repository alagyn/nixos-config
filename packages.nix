 {configs, pkgs, ...}:
 {

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        nano
        discord
        vscode
        git
        vivaldi
        vivaldi-ffmpeg-codecs
        python3
        cmakeCurses
        yakuake
        obsidian
        pciutils
        docker
    ];

    # Enable for Obsidian, insecure because EOL
    nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];
 }
