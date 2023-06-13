{ config, pkgs, ... }:

{

  # Allow Unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "pandasaur";
  home.homeDirectory = "/home/pandasaur";

  # Packages that are going to be installed to the user profile.
  home.packages = with pkgs; [
    firefox
    #  thunderbird
      spotify
      discord
      discord-rpc
      whatsapp-for-linux
      yuzu-early-access
      ryujinx
      steam
      vscode
      jetbrains-toolbox
      gnome.dconf-editor
      gnome-browser-connector

      # GNOME Extensions Install
      gnomeExtensions.aylurs-widgets
      gnomeExtensions.caffeine
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.resource-monitor
      gnomeExtensions.useless-gaps
      gnomeExtensions.rounded-window-corners
      gnomeExtensions.dash-to-dock
      gnomeExtensions.user-themes
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    plugins = [
      
    ];
  };

  # GNOME Configuration

  # Installing GNOME extensions
}