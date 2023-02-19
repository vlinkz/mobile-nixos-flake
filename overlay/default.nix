self: super:
{
    gnome = super.gnome.overrideScope' (gself: gsuper: {
      gnome-shell = gsuper.gnome-shell.overrideAttrs (old: {
         version = "43.2-mobile";
         src = super.fetchgit {
           url = "https://gitlab.gnome.org/verdre/gnome-shell.git";
           rev = "a60349e1cccd761540090f537b426259e8184933";
           sha256 = "0rr26580cb24d6r5fspq03w4zil5b4x5df4y6bz512f6x74hcz2q";
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
            rev = "fc0eda8db254a64e79f8b382e3433568f81940da";
            sha256 = "0gl5icqacs4h1hjh4kwjni609yimwhfz3gaj3z5a914kjbwvc2jx";
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
