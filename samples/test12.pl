#perl -w
#
#  Test with Win32::GUI and Multi-Page system
#
# Functions Test :
#    - newFromFile
#    - AppendPage
#    - GetPageCount
#    - LockPage 
#    - UnlockPage
#    - GetLockedPageNumbers 


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

# Create a MDIB bitmap

$mdib = new Win32::GUI::MDIBitmap ("mdib.tiff", FIF_TIFF,) or die "new";

for $i (1..5) {
  my $dib = newFromFile Win32::GUI::DIBitmap ("bmp/$i.bmp");
  $mdib->AppendPage ($dib);
}

undef $mdib;

# Load a MDIB bitmap

$mdib = newFromFile Win32::GUI::MDIBitmap ("mdib.tiff") or die "newFromFile";

print "Nb page :", $mdib->GetPageCount(), "\n";

my $i = 0;

$Button = $W->AddButton (
    -name    => "Button",
    -text    => "Next",
    -visible => 1,
    -pos     => [0 , 0],
);

$W->Show();
Win32::GUI::Dialog();

sub Window_Resize {
    Paint();
}

sub Window_Terminate {
    $W->PostQuitMessage(0);
}

sub Button_Click {

  $i = $i + 1;
  $i = 0 if ($i >= $mdib->GetPageCount());

  print "Current page :", $i, "\n";
  Paint();
}

sub Paint {

    ($width, $height) = ($W->GetClientRect)[2..3];
    $dc = new Win32::GUI::DC ($W);

    my $dib = $mdib->LockPage($i);

    print $mdib->GetLockedPageNumbers(), "\n";

    $dib->AlphaCopyToDC($dc, 50, 50);
    $dib->SaveToFile ("test.bmp");

    $mdib->UnlockPage($dib);
}
