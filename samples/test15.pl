#perl -w
#
#  Test with Win32::GUI
#

use Win32::GUI;
use Win32::GUI::DIBitmap;


$W = new Win32::GUI::Window (
    -title    => "Win32::GUI::DIBitmap test",
    -left     => 100,
    -top      => 100,
    -width    => 400,
    -height   => 400,
    -name     => "Window",
) or die "new Window";

  $dib = newFromFile Win32::GUI::DIBitmap ('bmp/zapotec.bmp') or die "newFromFile";

  $bcolor = $dib->HasBackgroundColor();
print "hascolor = $bcolor\n";

  $color = $dib->GetPixel(10,10);

  $color = $dib->GetPixel(10,10);
  print "Color = $color\n";
  $dib->SetPixel(10, 10, 255);
  $color = $dib->GetPixel(10,10);
  print "Color = $color\n";
  $dib = $dib->ConvertTo24Bits();
print "hascolor = $bcolor\n";

  @color = $dib->GetPixel(11,10);
  print "Color = @color\n";

  $dib->SetPixel(11, 10, 255, 0, 0);
  @color = (0, 255, 0);
  $dib->SetPixel(12, 10, @color);
  @color = (0, 0, 255);
  $dib->SetPixel(13, 10, \@color);

$W->Show();
Win32::GUI::Dialog();

sub Window_Resize {
    Paint();
}

sub Window_Activate {
    Paint();
}

sub Window_Terminate {
    $W->PostQuitMessage(0);
}

sub Paint {

    ($width, $height) = ($W->GetClientRect)[2..3];
    $dc = new Win32::GUI::DC ($W);

    $dib->StretchToDC($dc, 0, 0, $width, $height);
}

