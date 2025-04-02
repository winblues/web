

# From ISO

/// important
    open: True
There is currently a bug with the Blue95 installer ISO.
///

Due to the issues with Blue95's installer ISO, we recommend installing another Xfce-based image with a working ISO such as [winblues/vauxite](https://github.com/winblues/vauxite).

After installing vauxite, you can rebase directly to this image with:

```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/winblues/blue95:latest
```

# From Other Atomic Desktops
If you are currently using an atomic desktop, you can rebase to the latest blue95 image.

- First rebase to the unsigned image, to get the proper signing keys and policies installed:

```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/winblues/blue95:latest
```

- Reboot and then rebase to the signed image, like so:

```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/winblues/blue95:latest
```

It is recommended to create a new user after rebasing.

