{ config, pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
      google-fonts
    ];

    fontconfig = {
      enable = true;
      defaultFonts.emoji = [ "Noto Color Emoji" ];
      # CRITICAL: Allows LibreOffice to read the embedded color graphics
      useEmbeddedBitmaps = true;
    };
  };

}
