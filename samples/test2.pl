#perl -w
#
# Test standalone :  Load and save in different format
#
# Functions Test :
#    - GetVersion
#    - GetCopyright
#    - newFromFile
#    - SaveToFile
#
use Cwd;
use Win32::GUI::DIBitmap;

  print Win32::GUI::DIBitmap::GetVersion(), "\n";
  print Win32::GUI::DIBitmap::GetCopyright(), "\n";


  $dir_in = cwd();
  $dir_in  .= "/bmp/";
  $dir_in =~ tr/\//\\/;

  $dir_out = cwd();
  $dir_out .= "/";
  $dir_out =~ tr/\//\\/;

  chdir $dir_in;
  opendir (REP, $dir_in) or die "error opendir";

  @Fichier = grep { -f $_ } readdir (REP);

  closedir (REP);

  $i = 0;

  foreach $fichier (@Fichier) {

    $i ++;
    print $dir_in.$fichier, "\n";

    $dib = Win32::GUI::DIBitmap->newFromFile ($dir_in.$fichier);
    if (defined $dib) {

      $f = $dir_out.$i.".bmp";
      $dib->SaveToFile($f);
      undef $dib;
    }
  }


