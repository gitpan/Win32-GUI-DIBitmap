#perl -w
#
#  Test with Win32::GUI
#
# Functions Test :
#    - newFromBitmap
#    - CopyToDC


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

    $dib->CopyToDC($dc);
    $dib->CopyToDC($dc, ($width / 2) - 30, ($height / 2) - 30 , 60, 60);
    $dib->CopyToDC($dc, $width - 50, $height - 50, 50, 50, 20, 10);
}

