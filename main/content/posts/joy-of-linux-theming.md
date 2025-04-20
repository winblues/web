---
title: "The Joy of Linux Theming in the Age of Bootable Containers"
author: "@ledif"
date: 2025-04-20T02:00:00Z
cover: "/images/glorpception.png"
coverCaption: "What is a Linux distribution anyway?"
draft: false
---

Having spent a couple of decades in the Linux world, I have always had an interest in Linux desktop environments and how they are themed.
I would often come across a post on [/r/unixporn](https://reddit.com/r/unixporn) that inspired me to try to customize the look and feel of my desktop environment. So I would install Xfce, LXQt or Sway and try to recreate components that I like from other users or create my own. I would end up installing different kinds of panels, plugins, docks and launchers as well as random themes, fonts and sounds.

A portion of this process would be documented, initially as random shell scripts in my home directory, before graduating to Ansible playbooks -- with a brief detour into Nix that I will not elaborate on. Some of the customizations would live in my home directory, but there were often system-wide modifications to `/usr` required.

Eventually, the constant churn and randomly broken desktop components such as a panel that mysteriously vanished or a non-functional dock led me to stick with the stock configuration of whatever desktop environment I was using at the time.
The major desktop environments, [KDE Plasma](https://kde.org) and [GNOME](https://www.gnome.org), are both well polished and great out of the box. The desktop experience that they have delivered over the last few years has contributed to desktop Linux being the best it has ever been, in my opinion.

But the itch to customize and tweak my desktop environment in fun and interesting ways is still there. Eventually, I was introduced to the concept of bootable containers.

## Bootc As A Themer's Playground

The [bootc](https://github.com/bootc-dev/bootc) project, originally developed by [Red Hat](https://www.redhat.com) but now part of the [Cloud Native Computing Foundation](https://www.cncf.io/), is a core component of the [Bootable Containers Initiative](https://containers.github.io/bootable/). Conceptually, it allows you to define your operating system as a Containerfile:

```bash
FROM quay.io/fedora/fedora-bootc:42
RUN dnf install -y my-custom-theme my-custom-fonts my-custom-panel
```


Once written, you can build the container locally and instruct your bootc-aware system to use the new image.


```bash
sudo podman build -f Containerfile -t my-fedora
sudo bootc switch --transport containers-storage localhost/my-fedora:latest

```

After a reboot, the system's deployment is defined by the new container.

With Fedora Atomic systems, `/usr` is mounted read-only and because your operating system is defined by an OCI container, it is incredibly easy to revert to a previous tag of that container. I can easily create a throwaway container where I test out ideas for a theme, reboot into the new deployment and test it out on bare-metal. I can roll back to the previous container if necessary or create a new container with follow-up modifications.

One downside is that this reboot-heavy workflow can obviously cause some friction. This can be mitigated somewhat by enabling "Development Mode" with `ostree admin unlock`, which creates a temporary writable overlayfs on top of `/usr`. I often find myself using this mode to temporarily install some package, theme or configuration in `/usr`. After verifying that it works as expected, I can add that functionality to the Containerfile. If it doesn't work, I can either reboot to get rid of the changes, or (more likely) just forget about the change and it will remove itself whenever I reboot normally. The lack of cruft that accumulates over time in a typical Linux installation is one of the major advantages of this approach.

Of course, there are other ways to achieve similar results without using a bootable container model:
- You can write shell scripts or Ansible playbooks and hope that they accurately capture changes to the system so that they can be reliably undone. Typically, configuration drift that occurs as software gets updated is not addressed.
- With [systemd-sysext(8)](https://www.freedesktop.org/software/systemd/man/latest/systemd-sysext.html), you can create a squashfs image of a filesystem containing your theming changes for `/usr` and overlay it on top of the root filesystem. An ecosystem around how these images should be created, maintained, deployed and updated has yet to emerge.
- You can inscribe your custom theming as runes in an arcane and inscrutable functional language known only to the elders as N̸̘̏͑̕͝į̸̈́̂x̸͙̑̅̒.

In my opinion, none of the alternatives provide the same level of flexibility and tooling support as writing a Dockerfile, nor can they achieve bootc's level of safety and reliability by making it extremely difficult to bork your `/usr` directory. And if the `/usr` directory somehow gets borked anyway, rolling back to the previously deployed container is just a reboot away.

## What Is A Distro?

<div style="display: flex; justify-content: space-between; gap: 10px; text-align: center;">
  <figure style="width: 48%;">
    <a href="/images/bluexp.png"><img src="/images/bluexp.png" alt="Image 2" style="width: 100%; object-fit: cover;"></a>
    <figcaption><a href="https://github.com/winblues/bluexp">BlueXP</a></figcaption>
  </figure>
  <figure style="width: 48%;">
    <a href="/images/blue9.png"><img src="/images/blue9.png" alt="Image 1" style="width: 100%; height: 234px; object-fit: cover;"></a>
    <figcaption><a href="https://github.com/winblues/blue9">Blue9</a></figcaption>
  </figure>
</div>

A few weeks ago, an OCI image based on Fedora Xfce Atomic that I made called [Blue95](https://github.com/winblues/blue95) was posted to [Hacker News](https://news.ycombinator.com/item?id=43524937). For the most part, the reception was warm but there were some interesting questions that were raised, such as:

> Is it really necessary to spin up an entirely new distro for an XFCE+GTK theme?


The original poster made me question the nature of the project I created: is it a distro? In the age of bootc, the distinction between what is considered a Linux distribution and what is simply a Containerfile + CI/CD is, in my opinion, murky at best. Historically, the barrier to entry for creating what has traditionally been called a Linux distribution was orders of magnitude higher than creating and publishing an OCI container. My nights-and-weekends side project of building a bootable container is a far cry from what I imagine a Linux distribution to be.



[Blue95](https://blues.win/95) is a collection of scripts and YAML files cobbled together to produce a Containerfile, which is built via GitHub Actions and published to the GitHub Container Registry. Which part of this process elevates the project to the status of a Linux distribution? What set of `RUN` commands in the Containerfile take the project from being merely a Fedora-based OCI image to a full-blown Linux distribution?

Popular bootc-based projects like [Project Bluefin](https://projectbluefin.io) and [Bazzite](https://bazzite.gg) are often labeled as Linux distributions, much to the consternation of their creators and maintainers. But if you've ever used Bazzite and booted directly into Steam's Big Picture Mode, you might agree that it does indeed feel like its own Linux distribution; it is quite distinct from its twin bases of [Fedora Silverblue](https://fedoraproject.org/atomic-desktops/silverblue/) and [Fedora Kinoite](https://fedoraproject.org/atomic-desktops/kinoite/).


Maybe the imprecision of the term “Linux distribution” is most evident when arguments arise over what is and isn’t a distro. It has always been problematic to define a distribution as simply a curated collection of software plus a Linux kernel -— but that definition is now especially lacking, as it could just as easily describe any Containerfile for a bootable container. Ultimately, “I know it when I see it” may be the best we can do when deciding whether a project deserves the label Linux distribution or not.

Finally, to address the original question about the necessity of spinning up a new distro just for a theme: creating a bootable container with a consistent visual design and curated set of applications can bring a bit of **joy and levity**. At this moment, my laptop is booted from a container that I have created myself. The operating system being used to draft these words is the product of my own artistic and creative expression -- built on the work of countless other human beings. And that brings me joy.

---

<figure>
<a href="/images/ty4reading.png"><img src="/images/ty4reading.png" /></a>
</figure>
