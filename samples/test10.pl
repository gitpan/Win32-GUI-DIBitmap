#perl -w
#
#  Test with Win32::GUI
#
# Functions Test :
#    - newFromWindow
#    - SaveToFile

use Win32::GUI;
use Win32::GUI::DIBitmap;

$W = new Win32::GUI::Window (
    -title    => "Win32::GUI::DIBitmap test : newFromWindow",
    -pos      => [100, 100],
    -size     => [200, 200],
    -name     => "Window",
) or die "new Window";

$button = $W->AddButton (
    -name => "Capture1",
    -text => "Click here for capture this button",
    -pos  => [20, 40],
);

$W->AddButton (
    -name => "Capture2",
    -text => "Click here for capture this window",
    -pos  => [20, 80],
);

$W->AddButton (
    -name => "Capture3",
    -text => "Click here for capture the screen",
    -pos  => [20, 120],
);

$W->Show();
Win32::GUI::Dialog();


sub Window_Terminate {
    -1
}

sub Capture1_Click {

  my $dib = newFromWindow Win32::GUI::DIBitmap ($button) or die "newFromWindow";
  $dib->SaveToFile ('button0.bmp');
}

sub Capture2_Click {

  my $dib = newFromWindow Win32::GUI::DIBitmap ($W) or die "newFromWindow";
  $dib->SaveToFile ('window0.bmp');

  $dib = newFromWindow Win32::GUI::DIBitmap ($W, 1) or die "newFromWindow";
  $dib->SaveToFile ('window1.bmp');
}

sub Capture3_Click {

  my $hwnd = Win32::GUI::GetDesktopWindow();
  my $dib = newFromWindow Win32::GUI::DIBitmap ($hwnd) or die "newFromWindow";
  $dib->SaveToFile ('screen.bmp');
  $dib->SaveToFile ('screen.png');
  $dib->SaveToFile ('screen.jpg');
  $dib->SaveToFile ('screen.tif');
}
