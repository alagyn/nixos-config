{config, pkgs, ...}:
{
    # Shell Prompt  

    programs.bash.promptInit = builtins.readFile ./bash_prompt.sh;
    
    # Fix for missing libstdc++
    environment.variables = {
        LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    };

    # Nano settings
    programs.nano.nanorc = ''
    set tabstospaces
    set autoindent
    set tabsize 4
    set smarthome
    set indicator
    set linenumbers
    '';

} 
