#perl -w
#
#  Test with Win32::GUI and GD
#
# Functions Test :
#    - newFromGD
#    - CopyFromGD
#    - StretchToDC

use GD;
use Win32::GUI;
use Win32::GUI::DIBitmap;

# create a new image
$im = new GD::Image(100,100);

# allocate some colors
$white = $im->colorAllocate(255,255,255);
$black = $im->colorAllocate(0,0,0);
$red   = $im->colorAllocate(255,0,0);
$blue  = $im->colorAllocate(0,0,255);
$green = $im->colorAllocate(0,255,0);

# make the background transparent and interlaced
$im->transparent($white);
$im->interlaced('true');

# Put a black frame around the picture
$im->rectangle(0,0,99,99,$black);

# Draw a blue oval
$im->arc(50,50,95,75,0,360,$blue);

$im->string(gdSmallFont,2,10,"Top",$black);

# And fill it with red
$im->fill(50,50,$red);
$color = 0;

# Allocate a DIBitmap and copy GD image (no inflate/deflate)
$dib = newFromGD Win32::GUI::DIBitmap ($im) or die "newFromData";

$W = new Win32::GUI::Window (
    -title    => "Win32::GUI::DIBitmap test",
    -pos      => [100, 100],
    -size     => [200, 230],
    -name     => "Window",
) or die "new Window";

$W->AddButton (
    -name     => "BtnColor",
    -pos      => [0, 0],
    -size     => [200, 20],
    -text     => "Change Color !!!"
) or die "new AddButton";


$W->Show();
Win32::GUI::Dialog();

sub Window_Resize {
    ($width, $height) = ($W->GetClientRect)[2..3];
    $W->BtnColor->Resize($width, 20);
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

    $dib->StretchToDC($dc, 0, 30, $width, $height - 30);
}


sub BtnColor_Click {

  # Change color
  if ($color) {
    $im->fill(50,50,$red);
    print "Color change to red \n";
  }
  else {
    $im->fill(50,50,$green);
    print "Color change to green\n";
  }

  # Copy GD data only (no allocation, no inflate/deflate)
  $dib->CopyFromGD($im);

  $color = 1 - $color;
  Paint();

}
