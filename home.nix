{
  config,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lorev";
  home.homeDirectory = "/home/lorev";

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    image = ./gruvbox-nix.png;
    opacity = {
      applications = 0.1;
      desktop = 0.75;
      popups = 0.85;
      terminal = 0.85;
    };

    cursor = {
      package = pkgs.capitaine-cursors-themed;
      name = "Capitaine Cursors (Gruvbox)";
    };
    fonts = {
      serif = {
        package = pkgs.fira-sans;
        name = "FiraSans";
      };
      sansSerif = {
        package = pkgs.fira-sans;
        name = "FiraSans";
      };
      monospace = {
        package = pkgs.fira-mono;
        name = "Fira Code nerd font mono";
      };
    };
  };
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    godot_4 # open source game engine
    htop-vim # system monitor with vim keybindings
    zathura # pdf viewer with vim keybindings
    nnn #terminal file manager
    eza #modern replacement for ls
    fzf #cli fuzzy finder
    yq
    zoxide
    texliveFull
    (python312.withPackages (p: [
      p.pyyaml
    ]))
    dropbox
    tlrc
    vlc
    graphicsmagick
    grim
    slurp
    zenity
    wl-clipboard
    blender
    android-tools
    sdkmanager
    unzip
    telegram-desktop
    headsetcontrol
    gh
    libsecret
    nchat
    aseprite
    obsidian
    ripgrep
    blueman
    stremio
    rofi-wayland
    kitty
    alejandra
    wireguard-tools
    wireguard-ui
    wgnord
    btop
    base16-schemes
    onedrive
    viu
    gammastep
  ]; #END OF PACKAGES

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
  };
  programs.git = {
    enable = true;
    userName = "Utisse";
    userEmail = "lorenzopasqui@gmail.com";
    extraConfig = {
      credential.helper = "${
        pkgs.git.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
      push = {autoSetupRemote = true;};
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
           export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
           function zathura() {
           		nohup zathura "$@" > /dev/null 2>&1 &
      	disown
      	exit
      	}
      eval "$(zoxide init --cmd cd bash)"
    '';
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -la";
      shtdwn = "shutdown now";
      ell = "eza -ls --icons";
    };
  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    #".config/hypr/hyprland.conf".source = ./config/hypr/hyprland.conf;
    #".config/hypr/start.sh".source = ./config/hypr/start.sh;
    #".config/waybar/config".source = ./config/waybar/config;
    #".config/waybar/style.css".source = ./config/waybar/style.css;
    ".config/waybar/watch_course.sh".source = ./config/waybar/watch_course.sh;
    #".config/waybar/modules/Modules".source = ./config/waybar/modules/Modules;
    #".config/waybar/modules/ModulesCustom".source = ./config/waybar/modules/ModulesCustom;
    #".config/waybar/modules/ModulesGroups".source = ./config/waybar/modules/ModulesGroups;
    #".config/waybar/modules/ModulesWorkspaces".source = ./config/waybar/modules/ModulesWorkspaces;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  imports = [
    ./programs/nixvim.nix
    ./programs/kitty.nix
    ./programs/hyprland.nix
    ./programs/waybar.nix
    ./programs/zathura.nix
    ./programs/firefox.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
