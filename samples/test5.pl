#perl -w
#
#  Test with Win32::GUI
#
# Functions Test :
#    - newFromBitmap
#    - ConvertToBitmap
#    - ConvertTo24Bits
#    - SaveToFile  with fif and flag


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


$hbitmap = new Win32::GUI::Bitmap('bmp/zapotec.bmp') or die ("new Bitmap");

$dib = newFromBitmap Win32::GUI::DIBitmap ($hbitmap) or die "newFromBitmap";
undef $hbitmap;
$hbitmap = $dib->ConvertToBitmap() or die "ConvertToBitmap";

$dib->SaveToFile ("test5_1.jpg", FIF_JPEG, JPEG_QUALITYSUPERB ) or die "SaveToFile";
$dib->SaveToFile ("test5_2.jpg", FIF_JPEG, JPEG_QUALITYGOOD ) or die "SaveToFile";
$dib->SaveToFile ("test5_3.jpg", FIF_JPEG, JPEG_QUALITYNORMAL ) or die "SaveToFile";
$dib->SaveToFile ("test5_4.jpg", FIF_JPEG, JPEG_QUALITYAVERAGE) or die "SaveToFile";
$dib->SaveToFile ("test5_5.jpg", FIF_JPEG, JPEG_QUALITYBAD ) or die "SaveToFile";
undef $dib;

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


