# Pale Moon

<a href="../images/palemoon.png">
![installer](./images/palemoon.png)
</a>

The [Pale Moon](https://linux.palemoon.org) browser is included in Blue95 by default. The [Moonscape](https://addons.palemoon.org/addon/moonscape/) theme must be manually installed.

# Epyrus

<a href="../images/email.png">
![installer](./images/email.png)
</a>

The default mail application is [Epyrus](http://www.epyrus.org). The [Moonscape](https://addons.epyrus.org/addon/moonscape/) theme must be manually installed.

# LibreOffice Writer

<a href="https://blues.win/95/screenshot-libreoffice.png">
![LibreOffice Chicago95 Icon Set](https://blues.win/95/screenshot-libreoffice.png)
</a>
The Chicago95 icon set for LibreOffice Writer is available in Blue95, but it must be installed manually.

First copy the `.oxt` file to a location accessible from within the Flatpak environment such as your home directory:

```bash
cp /usr/share/libreoffice/extensions/Chicago95-theme-0.0.oxt ~
```

Launch LibreOffice Writer and open the Extensions menu by going to Tools > Extensions. Click "Add" and select the file `Chicago95-theme-0.0.oxt` in your home directory. Then, restart LibreOffice when prompted.

Once installed, open the Tools > Options menu, navigate to LibreOffice > View, and under Icon Theme, select Chicago95.
