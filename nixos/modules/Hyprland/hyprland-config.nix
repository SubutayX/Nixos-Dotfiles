{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    # Bu ayar sayesinde NixOS, ~/.config/hypr/hyprland.conf dosyasını otomatik oluşturur
    settings = {
      monitor = ",highres,auto,1";
      "$terminal" = "kitty";
      "$menu" = "rofi -show drun";

      exec-once = [
        "waybar"
        "swww init"
      ];

      bind = [
        "SUPER, Q, exec, $terminal"
        "SUPER, R, exec, $menu"
        "SUPER, C, killactive"
        "SUPER, M, exit"
        "SUPER, V, togglefloating,"
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      };
    };
  };
}
