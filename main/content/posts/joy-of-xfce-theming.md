---
title: "The Joy of Linux Theming in an Atomic World"
date: 2025-04-19T12:00:00Z
cover: "/images/glorpception.png"
coverCaption: "What is a Linux distribution anyway?"
draft: false
---


Using Linux systems for almost two decades now, I have always had an interest in Linux desktop environment theming.
I would often come across a post on [/r/unixporn](https://reddit.com/r/unixporn) that inspires me to try to customize the look and feel of my desktop environment. So I would install Xfce, LXQt or Sway and try to recreate components that I like from other users or create my own. I would end up installing different kinds of panels, plugins, docks and launchers as well as random themes, fonts and sounds.

Some of this would be documented, first as random shell scripts in my home directory, before upgrading them to Ansible playbooks with a brief detour into Nix that I won't comment on. Some of the customizations would live in my home directory, but there were often system-wide modifications to `/usr` involved.

Eventually, the constant churn and randomly broken desktop components such as a panel that mysteriously vanished or a non-functional dock led me to stick with the stock configuration of whatever desktop environment I was using at the time.
The major desktop environments, [KDE]() and [GNOME](), are both well polished and great out of the box. The desktop experience that they have delivered over the last few years has contributed to desktop Linux being the best it has ever been, in my opinion.

But the itch to customize and tweak my desktop environment in fun and interesting ways was still there. And then I was introduced to the concept of bootable containers.

## `bootc` As A Theming Sandbox

The [`bootc`](https://github.com/bootc-dev/bootc) project, originally developed by [Red Hat](https://www.redhat.com) but now part of the [Cloud Native Computing Foundation](https://www.cncf.io/), is a core component of the [Bootable Containers Initiative](https://containers.github.io/bootable/). Conceptually, it allows you to define your operating system as a Containerfile:

```bash
FROM quay.io/fedora-ostree-desktops/xfce-atomic:42
RUN dnf install --repofrompath \
        my-theme,https://example.com/my-theme$releasever' my-theme && \
    dnf install -y my-custom-theme my-custom-fonts my-custom-panel
```


Once defined, you can build your container locally and instruct the current `bootc`-aware system
to use the new image.

```bash
sudo podman build -t my-fedora .
sudo bootc switch localhost/my-fedora:latest
```

With Fedora Atomic systems, `/usr` is mounted read-only and as of Fedora 42, it is mounted using composefs. Since podman also uses composefs to store container layers, this allows deduplication of files between the host's actual operating system (stored in `/usr`) and any containers that are present on the system. This is incredibly cool to me as a concept.

Because your operating system is defined by an OCI container, it is incredibly easy to revert to a previous tag of that container. Additionally, it enables me to easily create a throwaway container where I test out ideas for a change, reboot into the new deployment defined by that container and run the changes live. If I don't like the changes, I can roll back to the previous container or create a new container with more changes.

One downside is that this reboot-heavy workflow can obviously cause some friction. This can be mitigated somewhat by enabling "Development Mode" with `ostree admin unlock`, which simply creates a temporary writable overlayfs on top of `/usr` 

Of course, there are other ways to achieve similar results without using a bootable container model.                                                                                                                                                                                                                                                                                                 o
- [systemd-sysext(8)](https://www.freedesktop.org/software/systemd/man/latest/systemd-sysext.html) enables you to create a simple squashfs image of the root filesystem containing your theming changes for `/usr` and layer it on to the host filesystem.
- You can write shell scripts or Ansible playbooks and hope that they accurately capture changes to the system that are being made so that they can be undone in a reliable manner. Not to mention configuration drift that occurs as software gets updated.
- One can inscribe their custom theming as runes in an arcane and inscrutable functional language known only to the elders as N̸̘̏͑̕͝ỉ̶̠̏͝į̸̈́̂x̸͙̑̅̒.

In my opinion, none of the alternatives 

## What Is A Distro?

Hacker News: did we really need a whole new distro for this:
One, it's not a new distro

It's essentially a Dockerfile and a build process that says take the latest Fedora image and add all of my theming and customizations in this repeatable and reproducible way.

It didn't have to be a whole new distro, but in the age of bootc, the lines between what is a distro and what is a Dockerfile are murky at best. And writing a Dockerfile is one of 

```Dockerfile
FROM 

```

Finally, creating bootable containers with pre-loaded theming and applications brings joy to some. I can run a bootable container image on bare-metal and recognize that the operating system that is being used to draft these words is the product of my own artistic and creative expression, built on the work of countless other human beings. And that brings me joy.
