---
title: "KDE Development on Bazzite"
date: 2025-09-19T12:00:00Z
author: "Adam Fidel (ledif)"
draft: false
---

<a href="/images/bazzite-kde-dev.webp"><img src="/images/bazzite-kde-dev.webp" /></a>

[Bazzite](https://bazzite.gg), a gaming-focused Linux operating system, has garnered a reputation for being a good choice for playing video games but too restrictive for actual development work due to its read-only `/usr` partition and its weird package management quirks.

Often, people get tripped up by attempting to install certain toolchains for development work, realizing that installing packages on top of the bootable container image requires a reboot, and eventually conclude that this friction is an indication that the operating system is not suitable for serious software development.

Here, I will argue that the restrictions imposed by its so-called "immutable" nature are in actuality useful safeguards that help isolate your day-to-day desktop activities from your development work. By providing a strong emphasis on containerization, you are free to install, explore, develop and destroy to your heart's content within the confines of a sandboxed environment without care. You can hack away without the sneaking worry that by somehow upgrading the system's `clang++` to a version required for your development work, you will inadvertently break the ABI of some shared-library that your web browser depended on, and now you cannot navigate to double-u double-u double-u dot reddit dot com to doomscroll for hours on end.

But aren't containers heavily sandboxed? What if I want to develop a core component of the system, such as the desktop environment itself?

This post is written in praise of a tool that makes such an endeavor possible: Distrobox.

# Setting Up KDE Builder

The magic that makes containerization a viable strategy for KDE development is [Distrobox](https://github.com/89luca89/distrobox). In their own words:

> Distrobox uses `podman`, `docker` or `lilipod` to create containers using the Linux distribution of your choice. The created container will be tightly integrated with the host, allowing sharing of the `$HOME` directory of the user, external storage, external USB devices and graphical apps (X11/Wayland), and audio.

Bazzite is based on Fedora, so we plan to create a Fedora distrobox. In the container, we will install all of our development tools and then build KDE from source. The resulting artifacts will be available outside of the container back on the host system.

To reduce some friction, I've created a Fedora-based [Docker image](https://github.com/ledif/ublue-kde-dev/blob/main/Containerfile) that contains all of the necessary KDE development packages. It is available via the [GitHub Container Registry](https://github.com/ledif/ublue-kde-dev/pkgs/container/ublue-kde-dev).

```bash
sudo mkdir -p /var/local/kde-dev/{home,kde}
sudo chown $(id -u):$(id -u) /var/local/kde-dev/{home,kde}

mkdir -p /var/local/kde-dev/home/.config
cp ./kde-builder.yaml /var/local/kde-dev/home/.config

distrobox create \
	--name kde-dev \
	--home /var/local/kde-dev/home \
	--volume /var/local/kde-dev/kde:/var/local/kde-dev/kde:Z \
	--init \
	--additional-packages "systemd" \
	--pull \
	--image ghcr.io/ledif/ublue-kde-dev:latest
```

In the above configuration, we have a directory tree in `/var/local/kde-dev` for the source files, the intermediate build files and the final `/usr` directory tree representing the entire desktop environment. We also create a separate home directory for the container, just so that our Bash history and profiles are not intermixed with those on the host.

```
/var/local/kde-dev
├── home
│   ├── .config
│   │   ├── kde-builder.yaml
│   ├── .local
│   │   ├── share
│   │   └── state
└── kde
    ├── build
    ├── log
    ├── src
    └── usr
        ├── bin
        ├── etc
        ├── include
        ├── lib
        ├── lib64
        ├── libexec
        ├── mkspecs
        └── share
```

The provided [kde-builder.yml](https://github.com/ledif/ublue-kde-dev/blob/main/kde-builder.yaml) file tells the KDE build system to utilize the shared `/var/local/kde-dev/kde` directory.

After this is set up, you can then enter into the container and build KDE Plasma.

```bash
distrobox enter kde-dev
kde-builder workspace
```

It will definitely take a long time to compile, so consider taking a nice stroll around the neighborhood in the meantime.

## Running Your Own Plasma

After the entire project finishes building, the build artifacts will be available on the host in `/var/local/kde-dev/kde/usr`. But, how can we run it?

We first need to tell SDDM about it, which means adding a session to `/usr/share/wayland-sessions`. But how can we add our KDE development session to `/usr` if it is read-only? Fortunately, there is one exception to the whole `/usr` being immutable thing:

```
❯ ls -l /usr/local
lrwxrwxrwx. 6 root root 15 Mar  5  2024 /usr/local -> ../var/usrlocal
```

`/usr/local` is actually a symbolic link to the writeable `/var/usrlocal` directory! Since SDDM can pick up sessions in `/usr/local/share/wayland-sessions`, we can actually add our session there with little fuss.

```bash
cat << EOF > /tmp/plasmawayland-dev6.desktop
[Desktop Entry]
Exec=/var/local/kde-dev/kde/usr/lib64/libexec/plasma-dbus-run-session-if-needed /var/local/kde-dev/kde/usr/lib64/libexec/startplasma-dev.sh -wayland
DesktopNames=KDE
Name=Plasma (Dev)
Comment=Plasma Development by KDE
X-KDE-PluginInfo-Version=6.4.4
EOF

sudo mkdir -p /usr/local/share/wayland-sessions
sudo mv /tmp/plasmawayland-dev6.desktop /usr/local/share/wayland-sessions
```

Now, you can log out of your session and pick the new "Plasma (Dev)" choice to run your fresh-from-source farm-to-table newly built KDE Plasma. 

---

#### Thanks

This post was inspired by similar projects that ease KDE development on Fedora Atomic, including [silverhadch/bazzite-kde-dx](https://github.com/silverhadch/bazzite-kde-dx), [whelanh/aurora-kdegit-dx](https://github.com/whelanh/aurora-kdegit-dx) and the [Filotimo Project](https://github.com/filotimo-project). 
