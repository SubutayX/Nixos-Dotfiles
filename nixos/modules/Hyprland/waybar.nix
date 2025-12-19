{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 4;
        margin-left = 10;
        margin-right = 10;
        spacing = 4;

        modules-left = [ "custom/logo" "hyprland/workspaces" "cpu" "memory" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "pulseaudio" "network" "battery" "custom/power" ];

        "custom/logo" = {
            format = "  ";
            tooltip = false;
            on-click = "rofi -show drun";
        };

        "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            format = "{icon}";
            format-icons = {
                "1" = "";
                "2" = "";
                "3" = "";
                "4" = "";
                "5" = "";
                urgent = "";
                focused = "";
                default = "";
            };
        };

        "clock" = {
            format = "{:%H:%M:%S}";
            interval = 1;
            tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        "cpu" = { format = " {usage}%"; };
        "memory" = { format = " {used}GB"; };

        "pulseaudio" = {
            format = "{icon} {volume}%";
            format-muted = "";
            format-icons = { default = [ "" "" "" ]; };
            on-click = "pavucontrol";
        };

        "network" = {
            format-wifi = " {essid}";
            format-ethernet = " Connected";
            format-disconnected = "⚠ Disconnected";
        };

        "battery" = {
            states = { critical = 15; };
            format = "{icon} {capacity}%";
            format-icons = [ "" "" "" "" "" ];
        };

        "custom/power" = {
            format = "  ";
            on-click = "wlogout";
            tooltip = false;
        };
      };
    };

    # MyLinuxForWork stiline uygun modern CSS
    style = ''
      * {
          font-family: "JetBrainsMono Nerd Font";
          font-weight: bold;
          font-size: 14px;
          min-height: 0;
      }
      window#waybar {
          background: rgba(26, 27, 38, 0.85);
          color: #c0caf5;
          border-radius: 12px;
          border: 2px solid rgba(107, 114, 128, 0.3);
      }
      #workspaces button {
          color: #7aa2f7;
          padding: 0 8px;
      }
      #workspaces button.active {
          color: #bb9af7;
      }
      #clock, #cpu, #memory, #pulseaudio, #network, #battery {
          padding: 0 10px;
          margin: 4px 2px;
          background: rgba(0, 0, 0, 0.2);
          border-radius: 8px;
      }
      #custom-logo {
          font-size: 18px;
          color: #7db9e8;
          padding-left: 10px;
      }
    '';
  };
}
