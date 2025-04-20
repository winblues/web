---
title: "The Joy of Linux Theming in an Atomic World"
author: "@ledif"
date: 2025-04-19T12:00:00Z
cover: "/images/glorpception.png"
coverCaption: "What is a Linux distribution anyway?"
draft: false
---

Using Linux systems for a couple of decades now, I have always had an interest in Linux desktop environments and how they are themed.
I would often come across a post on [/r/unixporn](https://reddit.com/r/unixporn) that inspires me to try to customize the look and feel of my desktop environment. So I would install Xfce, LXQt or Sway and try to recreate components that I like from other users or create my own. I would end up installing different kinds of panels, plugins, docks and launchers as well as random themes, fonts and sounds.

A portion of this process would be documented, initially as random shell scripts in my home directory, before graduating to Ansible playbooks with a brief detour into Nix that I won't comment on. Some of the customizations would live in my home directory, but there were often system-wide modifications to `/usr` required.

Eventually, the constant churn and randomly broken desktop components such as a panel that mysteriously vanished or a non-functional dock led me to stick with the stock configuration of whatever desktop environment I am using at the time.
The major desktop environments, [KDE Plasma](https://kde.org) and [GNOME](https://www.gnome.org), are both well polished and great out of the box. The desktop experience that they have delivered over the last few years has contributed to desktop Linux being the best it has ever been, in my opinion.

But the itch to customize and tweak my desktop environment in fun and interesting ways is still there. Eventually, I was introduced to the concept of bootable containers.

## `bootc` As A Theming Sandbox

The [`bootc`](https://github.com/bootc-dev/bootc) project, originally developed by [Red Hat](https://www.redhat.com) but now part of the [Cloud Native Computing Foundation](https://www.cncf.io/), is a core component of the [Bootable Containers Initiative](https://containers.github.io/bootable/). Conceptually, it allows you to define your operating system as a Containerfile:

```bash
FROM quay.io/fedora/fedora-bootc:42
RUN dnf install -y my-custom-theme my-custom-fonts my-custom-panel
```


Once defined, you can build your container locally and instruct the current `bootc`-aware system
to use the new image.

```bash
sudo podman build -f Containerfile -t my-fedora .
sudo bootc switch localhost/my-fedora:latest
```

With Fedora Atomic systems, `/usr` is mounted read-only and as of Fedora 42, it is mounted using composefs. Since podman also uses composefs to store container layers, this allows deduplication of files between the host's actual operating system (stored in `/usr`) and any containers that are built or executed on the system.

Because your operating system is defined by an OCI container, it is incredibly easy to revert to a previous tag of that container. For me, I can easily create a throwaway container where I test out ideas for an improvement, reboot into the new deployment defined by that container and test out the new changes on bare-metal. I can roll back to the previous container or create a new container with additional changes.

One downside is that this reboot-heavy workflow can obviously cause some friction. This can be mitigated somewhat by enabling "Development Mode" with `ostree admin unlock`, which simply creates a temporary writable overlayfs on top of `/usr`. I often find myself using this mode to temporarily install some package, theme or configuration in `/usr`. After verifying that it works as expected, I can add that functionality to the Containerfile. If it doesn't work, I can either reboot to get rid of the changes, or (more likely) just forget about the change and it will remove itself whenever I reboot normally. The lack of cruft that accumulates over time in a typical Linux installation is one of the major advantages of this approach.

Of course, there are other ways to achieve similar results without using a bootable container model.
- You can write shell scripts or Ansible playbooks and hope that they accurately capture changes to the system that are being made so that they can be undone in a reliable manner. Ignore configuration drift that occurs as software gets updated.
- With [systemd-sysext(8)](https://www.freedesktop.org/software/systemd/man/latest/systemd-sysext.html), you can create a simple squashfs image of the root filesystem containing your theming changes for `/usr` and layer it on to the host filesystem. How these images are created, maintained, deployed and updated isn't fully fleshed out.
- One can inscribe their custom theming as runes in an arcane and inscrutable functional language known only to the elders as N̸̘̏͑̕͝ỉ̶̠̏͝į̸̈́̂x̸͙̑̅̒.

In my opinion, none of the alternatives provide the same level of flexibility as writing a Containerfile nor provide
the same level of safety and reliability by making it extremely difficult to bork your `/usr` directory. If the `/usr` directory somehow gets borked anyway, rolling back to the previously deployed container is just a reboot away.

## What Is A Distro?

<div style="display: flex; justify-content: space-between; gap: 10px; text-align: center;">
  <figure style="width: 48%;">
    <a href="/images/blue95.png"><img src="/images/blue95.png" alt="Image 1" style="width: 100%; height: 260px; object-fit: cover;"></a>
    <figcaption><a href="https://github.com/winblues/blue95">Blue95</a></figcaption>
  </figure>
  <figure style="width: 48%;">
    <a href="/images/plus.png"><img src="/images/plus.png" alt="Image 2" style="width: 100%; height: 260px; object-fit: cover;"></a>
    <figcaption><a href="https://blues.win/95/docs/plus/">BlueXP</a></figcaption>
  </figure>
</div>

A few weeks ago, an OCI image based on Fedora Xfce Atomic that I made called [Blue95](https://blues.win/95) was posted to [Hacker News](https://news.ycombinator.com/item?id=43524937). For the most part, the reception was warm but there were some interesting questions that were raised, such as:

> Is it really necessary to spin up an entirely new distro for an XFCE+GTK theme?


The original poster made me question the nature of the project that I made; is it a distro? In the age of `bootc`, the distinction between what is a Linux distribution and what is a Containerfile are, in my opinion, murky at best. The barrier of entry of creating an OCI image and creating a Linux distribution differs by orders of magnitude.

[Blue95](https://blues.win/95) is a set of scripts and YAML files that are smushed together to make a Containerfile that is built using GitHub Actions and pushed to GitHub's container registry. What part of this process elevates the project to the status of a Linux distribution? What set of `RUN` commands in the Containerfile take the project from being merely an OCI image to a full blown Linux distribution?

Popular `bootc`-based projects like [Project Bluefin](https://projectbluefin.io) and [Bazzite](https://bazzite.gg) are often labeled as Linux distributions, often to the chagrin of their creators. If you've ever used Bazzite, it does indeed feel like its own Linux distribution; it is quite distinct from its base of Fedora Workstation or Fedora KDE Plasma Desktop. Maybe the imprecision of the term "Linux distribution" is on full display when arguments break out about what is and is not a distro. "I know it when I see it" may be as good as it gets when trying to label projects as worthy of the label Linux distribution or not.

Finally, to address the original question about the necessity of spinning up a new distro just for a theme: creating bootable containers with pre-loaded theming and applications brings joy to some. I can run a bootable container image on bare-metal and recognize that the operating system that is being used to draft these words is the product of my own artistic and creative expression, built on the work of countless other human beings. And that brings me joy.
