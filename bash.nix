{config, pkgs, ...}:
{
    # Shell Prompt  

    programs.bash.promptInit = builtins.readFile ./bash_prompt.sh;
    
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
