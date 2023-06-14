{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "pandasaur";
  home.homeDirectory = "/home/pandasaur";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.
  
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    
    spotify
    discord
    whatsapp-for-linux
    vscode
    jetbrains-toolbox
    gnome.dconf-editor
    fzf
    
    # GNOME Extensions Install
    gnomeExtensions.aylurs-widgets
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.resource-monitor
    gnomeExtensions.useless-gaps
    gnomeExtensions.rounded-window-corners
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes
    
    # Themes, Icons and Cursors
    gtk-engine-murrine
    tokyo-night-gtk
    tela-icon-theme
    bibata-cursors
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pandasaur/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
      EDITOR = "nano";
  };
  
  # GNOME Configuration
  
  # Set the other gtk Themes
  gtk = {
    enable = true;
    
    iconTheme = {
      name = "Tela-purple-dark";
      package = pkgs.tela-icon-theme;
    };
    
    theme = {
      name = "Tokyonight-Dark-BL";
      package = pkgs.tokyo-night-gtk;
    };
    
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
    
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };
  
  home.sessionVariables.GTK_THEME = "Tokyonight-Dark-BL";
  
  # dconf settings (Extensions and shell themes)
  dconf.settings = {
    # Always prefer dark theme
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = true;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      
      # Enable the installed extensions
      enabled-extensions = [
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "dash-to-dock@micxgx.gmail.com"
        "rounded-window-corners@yilozt"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "Resource_Monitor@Ory0n"
      ];
    };
    # Set the shell theme
    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-B";
    };
  };
  
  # zsh Config
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    autocd = true;
    
    # only add if a .p10k.zsh file already exists, if not create/get one then add this
    initExtra = "POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true\nsource ~/.p10k.zsh";
    
    history = {
      expireDuplicatesFirst = true;
      save = 15000;
      share = true;
    };
    
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = builtins.fetchTarball "https://github.com/zsh-users/zsh-autosuggestions/archive/master.tar.gz";
      }
      {
        name = "zsh-syntax-highlighting";
        src = builtins.fetchTarball "https://github.com/zsh-users/zsh-syntax-highlighting/archive/master.tar.gz";
      }
      {
        name = "zsh-completions";
        src = builtins.fetchTarball "https://github.com/zsh-users/zsh-completions/archive/master.tar.gz";
      }
      {
        name = "nix-zsh-completions";
        src = builtins.fetchTarball "https://github.com/spwhitt/nix-zsh-completions/archive/master.tar.gz";
      }
      {
        name = "zsh-interactive-cd";
        src = builtins.fetchTarball "https://github.com/changyuheng/zsh-interactive-cd/archive/master.tar.gz";
        file = "zsh-interactive-cd.plugin.zsh";
      }
      {
        name = "powerlevel10k";
        src = builtins.fetchTarball "https://github.com/romkatv/powerlevel10k/archive/master.tar.gz";
        file = "powerlevel10k.zsh-theme";
      }
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
