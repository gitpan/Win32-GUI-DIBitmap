#perl -w
#
#  Test with Win32::GUI
#
# Functions Test :
#    - newFromDC
#    - SaveToFile

use Win32::GUI;
use Win32::GUI::DIBitmap;

$W = new Win32::GUI::Window (
    -title    => "Win32::GUI::DIBitmap test: NewFromDC",
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

  my $dc = new Win32::GUI::DC ($W);
  my $dib = newFromDC Win32::GUI::DIBitmap ($dc, 20, 40, $button->Width(), $button->Height()) or die "newFromDC";
  $dib->SaveToFile ('button.bmp');
}

sub Capture2_Click {

  my $dc = new Win32::GUI::DC ($W);
  my $dib = newFromDC Win32::GUI::DIBitmap ($dc) or die "newFromDC";
  $dib->SaveToFile ('window.bmp');
}

sub Capture3_Click {

  my $dc = new Win32::GUI::DC ('DISPLAY');
  my $dib = newFromDC Win32::GUI::DIBitmap ($dc) or die "newFromDC";
  $dib->SaveToFile ('screen.jpg');
}
