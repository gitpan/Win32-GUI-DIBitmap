#perl -w
#
# Test standalone :  
#
# Functions Test :
#    - GetVersion
#    - GetCopyright
#    - GetFIFCount
#    - GetFormatFromFIF
#    - GetFIFFromFormat
#    - FIFExtensionList
#    - FIFDescription
#    - FIFRegExpr
#    - FIFSupportsWriting
#    - FIFSupportsReading
#    - new
#    - SaveToFile

use Win32::GUI::DIBitmap;

print Win32::GUI::DIBitmap::GetVersion(), "\n";

print Win32::GUI::DIBitmap::GetCopyright(), "\n";

$count = Win32::GUI::DIBitmap::GetFIFCount();

print "count = $count\n";

for ($i = 0; $i < $count; $i++) {

  $format = Win32::GUI::DIBitmap::GetFormatFromFIF($i);

  $fif   = Win32::GUI::DIBitmap::GetFIFFromFormat($format);

  $ext   = Win32::GUI::DIBitmap::FIFExtensionList($fif);
  $desc  = Win32::GUI::DIBitmap::FIFDescription($fif);
  $reg   = Win32::GUI::DIBitmap::FIFRegExpr($fif);
  $read  = Win32::GUI::DIBitmap::FIFSupportsReading($fif);
  $write = Win32::GUI::DIBitmap::FIFSupportsWriting($fif);

  print "$i : Format = $format FIF = $fif Extention = $ext Description = $desc RegExp = $reg Reading = $read Writing = $write\n";
}



$dib = new Win32::GUI::DIBitmap (100,100,24,255,255,255);

for ($i = 0; $i < $count; $i++) {

  ($ext, $misc) = split /,/, Win32::GUI::DIBitmap::FIFExtensionList($i), 2;
  $f = "res$i.$ext";

  $res = $dib->SaveToFile($f, $i);
  print "save $f = $res\n";
  unlink $f;
}



