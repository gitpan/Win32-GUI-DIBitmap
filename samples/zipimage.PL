#perl -v
#
# Load image from a zip file.
# 
use Win32::GUI;
use Win32::GUI::DIBitmap;
use Archive::Zip;

$W = new Win32::GUI::Window (
    -title    => "Win32::GUI::DIBitmap load from a zipfile",
    -left     => 100,
    -top      => 100,
    -width    => 400,
    -height   => 400,
    -name     => "Window",
) or die "new Window";

($width, $height) = ($W->GetClientRect)[2..3];

# Open Zipfile
$zip = Archive::Zip->new( 'zapotec.zip' ) or die "ZipFile";
# Open image file in zipfile
$member = $zip->memberNamed( 'Zapotec.JPG' ) or die "member ZipFile";
# Load data image in memory
$data = $member->contents();
# Load  data immage in a dibbitmap
$dib = newFromData Win32::GUI::DIBitmap ($data) or die "Load zapotec.jpg";
$hbitmap = $dib->ConvertToBitmap();

undef $member;
undef $zip;
undef $data;
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


