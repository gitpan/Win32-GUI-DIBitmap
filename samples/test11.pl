#perl -w
#
#  Test with Win32::GUI
#
# Functions Test :
#    - newFromBitmap
#    - CopyToDC
#    - AlphaCopyToDC
#    - AlphaStretchToDC

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


$dib      = newFromFile Win32::GUI::DIBitmap ('bmp/zapotec.bmp') or die "newFromFile";
$dibalpha = newFromFile Win32::GUI::DIBitmap ('bmp/small.tga')   or die "newFromFile";

print "transparent : ", $dibalpha->IsTransaparent(), "\n";
print "BPP : ", $dibalpha->GetBPP(), "\n";

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

    $dib->StretchToDC($dc, 10, 10, $width - 20, $height - 20);
    $dibalpha->CopyToDC($dc);
    $dibalpha->AlphaCopyToDC($dc, 200);
    $dibalpha->AlphaStretchToDC($dc, 0, 200, 260, 200 );
}

