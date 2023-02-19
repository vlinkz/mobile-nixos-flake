self: super:
{
    gnome = super.gnome.overrideScope' (gself: gsuper: {
      gnome-shell = gsuper.gnome-shell.overrideAttrs (old: {
         version = "43.2-mobile";
         src = super.fetchgit {
           url = "https://gitlab.gnome.org/verdre/gnome-shell.git";
           rev = "0c42fe4cc05c54a737400973cc5dc8ff9ba51bca";
           sha256 = "NS4/y7xKIexa76Ltr/Rniflb7zTLEboKXlVe75+U/sk=";
         };
         postPatch = ''
           patchShebangs src/data-to-c.pl
       
           # We can generate it ourselves.
           rm -f man/gnome-shell.1
         '';
         postFixup = ''
            # The services need typelibs.
            for svc in org.gnome.ScreenSaver org.gnome.Shell.Extensions org.gnome.Shell.Notifications org.gnome.Shell.Screencast; do
              wrapGApp $out/share/gnome-shell/$svc
            done
         '';
      });

      mutter = gsuper.mutter.overrideAttrs (old: {
          version = "43.2-mobile";
          src = super.fetchgit {
            url = "https://gitlab.gnome.org/verdre/mutter.git";
            rev = "585802e5afeb268251dbb202f7d108fdf4f51da4";
            sha256 = "DaYTvPbRb3ri59jzv2OU20Y4fpZ22fxXq2G5qRKALZw=";
          };
          buildInputs = old.buildInputs ++ [
            super.gtk4
          ];
          outputs = [ "out" "dev" "man" ];
          postFixup = '' '';
          patches = [];
      });
    });
}
