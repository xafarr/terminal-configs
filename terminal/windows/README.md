# Instructions to Setup Windows Terminal/Powershell

1. Install Chocolatey. Follow the instructions at [here](https://chocolatey.org/install)
2. Install following tools.

    ```powershell
    choco install fd ripgrep git fzf jq neovim nerd-fonts-FiraCode nerd-fonts-JetBrainsMono startship
    ```

3. Check out the configuration repository [terminal-configs](https://github.com/xafarr/terminal-configs)
4. Create symlink from `terminal-configs/terminal/startship/startship.toml` to `~/.config/starship.toml`

    ```powershell
    New-Item -Path $HOME/.config/starship.toml -ItemType SymbolicLink -Value <path-to-terminal-configs>/terminal/starship/startship.toml
    ```

5. Copy or create SymbolicLink of `Microsoft.PowerShell_profile.ps1` and `powershell.config.json`
from `terminal-configs/terminal/windows/powershell` to `C:\Users\<username>\Documents\PowerShell` direcotry.
