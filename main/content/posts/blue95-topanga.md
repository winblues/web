---
title: "Blue95 Topanga Now Generally Available"
date: 2025-04-18T12:00:00Z
draft: false
---

<a href="/images/blue95-topanga.png"><img src="/images/blue95-topanga.png" /></a>

We're excited to announce that **Blue95 Topanga**, based on [Fedora 42](https://fedoramagazine.org/announcing-fedora-linux-42/) is now generally available!

This post will go over some of the changes and improvements that Blue95 has made since the previous version **Blue95 Ross** was introduced.


## What's New

**Blue95 Topanga** is now based on Fedora 42, which brings several changes along with it, including:
- The latest version of [Xfce 4.20](https://xfce.org/about/news/?post=1734220800). Partial Wayland support is experimental but functional. See the [Xfce 4.20 Tour](https://www.xfce.org/about/tour420) for more information.
- Fedora Atomic bootc images now use [composefs](https://fedoraproject.org/wiki/Changes/ComposefsAtomicDesktops) for the default `/` filesystem. This should not have a user-visible impact, but it makes the root filesystem more resistant to accidental modifications.
- A new kernel and a bunch of other changes from [Fedora 42](https://fedoramagazine.org/announcing-fedora-linux-42).

#### Applications 
<div style="display: flex; justify-content: space-between; gap: 10px; text-align: center;">
  <figure style="width: 48%;">
    <a href="/images/paint.png"><img src="/images/paint.png" alt="Image 1" style="width: 100%; height: 260px; object-fit: cover;"></a>
    <figcaption><a href="https://github.com/winblues/paint">Winblues Paint</a></figcaption>
  </figure>
  <figure style="width: 48%;">
    <a href="/images/plus.png"><img src="/images/plus.png" alt="Image 2" style="width: 100%; height: 260px; object-fit: cover;"></a>
    <figcaption><a href="https://blues.win/95/docs/plus/">Chicago 95 Plus!</a></figcaption>
  </figure>
</div>

**Blue95 Topanga** has introduced several new applications that fit the 90s aesthetic. For a full list, see [Blue95 Applications](https://blues.win/95/docs/applications/):
- <a href="https://github.com/winblues/paint">Winblues Paint</a> is a light GUI around <a href="https://jspaint.app">jspaint.app</a>

- <a href="https://blues.win/95/docs/plus/">Chicago 95 Plus!</a> is a GUI that lets you apply any Windows 95, 98, ME or XP theme.

- <a href="https://blues.win/95/docs/applications/#audacious">Audacious</a> is skinned with the classic Winamp skin and full support is available for any old Winamp skin.

- [Flatpost](https://blues.win/95/docs/applications/#flatpost) is now the default Flathub browser and App Store in Blue95.


- [LibreOffice](https://blues.win/95/docs/applications/#libreoffice-writer) is now provided as a Flatpak, with instructions on how to install the correct icons.

#### Live CD

![installer](/images/installer.png)

We are now providing a Live ISO where you can boot into a Blue95 live environment. Test it out without needing to install anything. Find more information in the <a href="https://blues.win/95/docs/">Documentation</a>.

#### Install Now

If you are currently using **Blue95 Ross**, then you should automatically be upgraded on your next reboot. If you are using another Fedora Atomic image and want to try it out, you can rebase with

```bash
sudo bootc switch ghcr.io/winblues/blue95:latest
```

For other installation instructions, please visit the <a href="https://blues.win/95/docs/install/">Install Guide</a>.

