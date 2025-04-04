# Xfce Settings

Blue95 has an opinionated design for its desktop environment and includes automated management for user-level Xfce configuration files.
The component responsible for this configuration management is called `winblues-chezmoi`, which utilizes both [chezmoi](https://www.chezmoi.io) and [xfconf-profile](https://github.com/winblues/xfconf-profile) to manage dotfiles in the user's home directories related to Xfce.


## Toggling `winblues-chezmoi`

By default, `winblues-chezmoi` runs once at initialization and then disables itself. If you want continuous updates and tweaks based on changes upstream to either <img src="../img/emblems/chicago95.png" style="height: 1em; vertical-align: middle;"> [Chicago95](https://github.com/grassmunk/Chicago95) or <img src="../img/emblems/xfce.png" style="height: 1em; vertical-align: middle;"> [Xfce](https://www.xfce.org), you can enable the service like so:

```bash
systemctl --user unmask winblues-chezmoi.service
```

If you want to manually run the service just once without enabling it, you can run:

```bash
/usr/libexec/winblues-chezmoi
```

To disable `winblues-chezmoi` after manually enabling it, run the following:
```bash
systemctl --user mask winblues-chezmoi.service
```

## Configuration

/// important
    open: True
Some of the following configuration settings have not been fully implemented. If you do not want any amount of Xfce settings management, you should disable the service.
///

Note that although `winblues-chezmoi` is configurable to exclude updating certain dotfiles and `xfconf` properties, this is meant to be
used sparingly. If you want more control over the appearance of the desktop environment, it is suggested to either disable the `winblues-chezmoi` service and manually manage your own dotfiles or use the base <img src="../img/emblems/winblues.png" style="height: 1em; vertical-align: middle;"> [winblues/vauxite](https://github.com/winblues/vauxite) image instead of Blue95.

## Excluding Files

The Xfce desktop environment stores its configuration files in the user's home directory under `~/.config/xfce4`, which are managed by `winblues-chezmoi`. To configure `winblues-chezmoi` to not manage certain files, create a file called `~/.config/winblues/chezmoiignore`

```bash
# Exclude changes to the terminal config file
.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-terminal.xml 

# Exclude changes to GTK theme overrides
.config/gtk-3.0/gtk.css

# Exclude changes to most files
.config/xfce4/xfconf/xfce-perchannel-xml/*
```
The format of this file can be found in chezmoi's documentation for [.chezmoiignore](https://www.chezmoi.io/reference/special-files/chezmoiignore/).


## Excluding Properties

[xfconf-profile](https://github.com/winblues/xfconf-profile) is a command-line tool developed specifically for Blue95 and other Xfce-based desktop images in the [Winblues](https://github.com/winblues) organization. The JSON profile that Blue95 uses is stored at `/usr/share/xfconf-profile/default.json` and defines properties for the Blue95 environment, such as:
```json
{
  "properties": {
    "xsettings": {
      "/Net/ThemeName": "Chicago95",
      "/Net/IconThemeName": "Chicago95",
      "/Net/EnableEventSounds": true,
      "/Net/EnableInputFeedbackSounds": true,
      "/Net/SoundThemeName": "Chicago95"
    },
    "xfwm4": {
      "/general/theme": "Chicago95"
    },
    "xfce4-notifyd": {
      "/theme": "Chicago95",
      "/notify-location": "bottom-right"
    }
}
```

The final step of `winblues-chezmoi` is to call `xfconf-profile` on this JSON profile to update the user's Xfce settings (i.e., `xfconf` properties). You can configure `xfconf-profile` to ignore changes to specific properties and specify the merge strategy between the user's current properties and the defined properties in Blue95. See [Configuration of xfconf-profile](https://github.com/winblues/xfconf-profile/tree/main?tab=readme-ov-file#configuration) for more information.
