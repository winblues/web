# Normal Linux Distro

I am enthralled by discussions around so-called immutable Linux distributions and the community's reactions to whether distributions like Bazzite are appropriate for different kinds of users. Bazzite is arguably the most popular operating system from the Fedora Atomic family--even surpassing Fedora's own offerings of Silverblue and Kinoite (see https://github.com/ublue-os/countme/blob/main/growth_global.svg)--and people have strong opinions about it. Consider a recent post in [/r/linux_gaming](https://www.reddit.com/r/linux_gaming/comments/1ku7phr/does_really_bazzite_really_make_a_difference_or/) that asks:

> Does really Bazzite really make a difference or it just normal Linux distro 

- Linux novices and people transitioning from Windows: I like Bazzite because I can install it on my gaming PC and it just works
- Linux enthusiasts: I don't like Bazzite because it is difficult to install my favorite tiling window manager and custom kernel tweaks
- Grizzled Linux veterans and cloud-native developers: I like Bazzite because it just works and any changes that I do need to make to the base image can be done in a reproducible and safe way using OCI containers

It's not that anything is specifically harder to do with bootc-based operating systems compared with the traditional way of doing things; rather, it is that one has to think about the operating system in a different way. Bazzite is less of an operating system and more of just a Containerfile.



In my opinion, Nix provides a great model for Linux servers and creating reproducible environments for deploying applications. Personally, I have a few NixOS machines running in my homelab. However, NixOS would absolutely not be my first choice for a set-it-and-forget-it OS that I would install on my parent's computer. Bazzite is and 

This is where fans of NixOS will point out ... Unlike appoaches like Nix, where you have to learn the ins-and-outs of a functional programming language in order to properly maintain your system--and where lessons from understanding Nix won't necessarily transfer to anything outside of Nix--bootc requires you to think about your OS as if it was a Docker container. And anything you learn about OCI containers can be transferred to understaning bootc and things you learn while understaning bootc can better help you understand containers. In my opinion, that is the true beauty of this approach as compared with other so-called immutable Linux distributions. 

I am a bit biased about my views on the future of the Linux desktop. I am a member of [Universal Blue][https://github.com/ublue-os], the organization behind Bazzite and personally maintain several bootc images (which some people refer to as "Linux distros") under the [Winblues](https://github.com/winblues) banner, including [Blue95](https://github.com/winblues/blue95).

For desktop Linux, I will glady choose the path to an atomic future over a "normal Linux distro" for my own sense of peace.
