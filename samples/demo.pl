#perl -w

  use Win32::GUI;
  use Win32::GUI::DIBitmap;

  $W = new Win32::GUI::Window (
              -title    => "Win32::GUI::DIBitmap test",
              -pos      => [100, 100],
              -size     => [400, 400],
              -name     => "Window",
              );

  $dib = newFromFile Win32::GUI::DIBitmap ('bmp\Zapotec.jpg');
  $hbitmap = $dib->ConvertToBitmap();
  undef $dib;

  $W->AddButton (
    -pos     => [100, 100],
    -size    => [200, 200],
    -bitmap  => $hbitmap,
    -name    => "Button",
    -visible => 1,
    );

  $W->Show();
  Win32::GUI::Dialog();
  sub Window_Terminate { -1 }
