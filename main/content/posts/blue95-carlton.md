---
title: "Blue95 Carlton Now Generally Available"
date: 2025-11-12T12:00:00Z
draft: false
---

<a href="/images/post-images/blue95-carlton/desktop.webp"><img src="/images/post-images/blue95-carlton/desktop.webp" /></a>

We're excited to announce that **Blue95 Carlton**, based on [Fedora 43](https://fedoramagazine.org/announcing-fedora-linux-43), is now generally available!

This post will go over some of the changes and improvements that Blue95 has made since the previous version [Blue95 Topanga](https://blues.win/posts/blue95-topanga) was introduced.

## What's New

**Blue95 Carlton** is now based on Fedora 43, which brings some minor changes to an already stable base.
It includes a new kernel version 6.17 and a bunch of other important but non-user-facing changes from [Fedora 43](https://fedoramagazine.org/announcing-fedora-linux-43).

Special thanks to [Timothée Ravier](https://github.com/travier) for maintaining the upstream Fedora Xfce Atomic images and helping navigate a deprecation scare!

### Clippy

<a href="/images/post-images/blue95-carlton/clippy.webp"><img src="/images/post-images/blue95-carlton/clippy.webp" /></a>

Clippy returns as a local LLM agent! Included by default in Blue95 is the wonderful [Clippy](https://github.com/felixrieseberg/clippy) project from Felix Rieseberg that allows you to run models like Gemma directly on your own hardware. Privacy is baked in by default: nothing leaves your machine and everything is executed locally.

### PowerPoint Templates

<a href="/images/post-images/blue95-carlton/ppt.webp"><img src="/images/post-images/blue95-carlton/ppt.webp" /></a>

A new `ujust` recipe has been introduced to install PowerPoint templates from old products such as Office 97 that have been collected and hosted in the Internet Archive's [Microsoft Powerpoint Templates Pack](https://archive.org/details/powerpoint-templates).

```bash
ujust install-ppt-templates
```

The templates will be placed in `~/Documents/Presentations/Templates`.

#### Install Now

If you are currently using **Blue95 Topanga**, then you should automatically be upgraded on your next reboot. If you are using another Fedora Atomic image and want to try it out, you can rebase with

```bash
sudo bootc switch ghcr.io/winblues/blue95:latest
```

For other installation instructions, please visit the <a href="https://blues.win/95/docs/install/">Install Guide</a>.

