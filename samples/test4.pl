#perl -w
#
#  Test with Win32::GUI 
# 
# Functions Test :
#    - newFromFile
#    - ConvertToBitmap


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


($width, $height) = ($W->GetClientRect)[2..3];

$dib = newFromFile Win32::GUI::DIBitmap ("bmp/zapotec.jpg") or die "Load zapotec.jpg";
$hbitmap = $dib->ConvertToBitmap();
undef $dib;

# $hbitmap = new Win32::GUI::Bitmap('bmp/zapotec.bmp') or die ("new Bitmap");

$BITMAP = $W->AddLabel (
    -pos     => [0 , 0],
    -size    => [$width, $height],
    -bitmap  => $hbitmap,
    -name    => "Bitmap",
    -visible => 1,
);

$BITMAP->SetImage ($hbitmap);

$W->Show();
Win32::GUI::Dialog();

sub Window_Resize {
    $W->Bitmap->Resize($W->ScaleWidth, $W->ScaleHeight);
}

sub Window_Terminate {
    $W->PostQuitMessage(0);
}


