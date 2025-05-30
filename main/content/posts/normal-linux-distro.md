---
title: "Is Bazzite Just A Normal Linux Distro"
date: 2025-05-30T12:00:00Z
cover: "/images/bazzite.webp"
draft: false
---

I am enthralled by discussions around so-called immutable Linux distributions and the community reactions to whether operating systems like Bazzite are suitable for different types of users. Bazzite has become the most popular member of the Fedora Atomic family, even outpacing Fedora's own offerings of Silverblue and Kinoite (see: [countme stats](https://github.com/ublue-os/countme/blob/main/growth_global.svg)). As it grows in visibility, people are starting to question what exactly sets it apart.

Consider a recent post in [/r/linux_gaming](https://www.reddit.com/r/linux_gaming/comments/1ku7phr/does_really_bazzite_really_make_a_difference_or/) that asks:

> Does [Bazzite] really make a difference or [is it just a] normal Linux distro?

This question captures a deeper tension I’ve seen across the Linux community: what counts as a “normal” distro in the first place? And if Bazzite isn't normal, in what sense is it not normal, for better or for worse?

After following many such discussions, I have noticed a pattern of opinions that generally emerges.

For Linux novices and people transitioning from Windows, I often hear the opinion "I like Bazzite because I can install it on my gaming PC and it just works." 
From Linux enthusiasts and tinkerers, I encounter the sentiment "I do not like Bazzite because it is difficult to install my favorite tiling window manager and apply my custom kernel tweaks." Finally, from 
grizzled Linux veterans and cloud-native developers, an opinion is shared not unlike that from the novice: "I like Bazzite because it just works and when I need to customize it, I can do so in a reproducible and containerized way."

It is not the case that [bootc](https://github.com/bootc-dev/bootc)-based operating systems like Bazzite cannot be customized or tweaked in the exact same ways as non-bootc systems; rather, it is more like a `Dockerfile` that happens to boot on bare metal. If you approach it like a container (i.e., immutable by default, layered, reproducible) the approach starts to make more sense.

So, is Bazzite a “normal” Linux distro? Technically, yes. It's just Linux. But in practice, it redefines what we expect from a desktop system by applying ideas that originated in the container and cloud-native world.

## bootc and Nix

In my mind, the goals of `bootc` and [NixOS](https://nixos.org/) are not too dissimilar: declarative builds and atomic deployments of Linux systems. I run a few NixOS machines in my homelab, and I love Nix for what it brings to the server world. But if I were setting up a machine for a friend or my parents I certainly I would not choose NixOS. I’d choose Bazzite or Fedora Silverblue or any of many the `bootc` images out there.

Fans of NixOS can rightly point out that Nix gives you unmatched power and control. But it also requires you to learn the intricacies of a functional programming language. Not to say that the knowledge you gain in mastering Nix is not valuable, but its value is largely self-contained within the Nix ecosystem.

In contrast, bootc-based systems build on a different foundation: OCI containers. If you understand Dockerfiles or podman, you already have a head start. And what you learn by creating and maintaining a bootc image applies directly to containerized infrastructure elsewhere.

That's the real magic of the `bootc` approach and the [Universal Blue](https://universal-blue.org) project more broadly. It bridges the gap between desktop Linux and modern infrastructure practices using familiar tooling around OCI containers and if you’re new to those ideas, learning them on the desktop has transferable value.

Universal Blue often gets flak for describing its projects such as Bazzite as *cloud-native*, a term that can sound meaningless--or even off-putting--if all you want is a Linux system that runs your games. And if you're already deep in the Kubernetes or container world, the term feels too vague to be helpful. But behind the buzzword is a simple truth: these tools and ideas scale. They bring consistency, composability, and reproducibility to the desktop, just as they have in server environments.

So, is Bazzite just a normal Linux distro? If normal means flexible, stable, familiar, and hackable, then yes, it has those same qualities as other distros. But if normal means doing things the same way we've done them for decades--running `apt-get install steam` and accidentally removing your desktop environment--then no; Bazzite offers something different.

I will gladly choose that difference.
