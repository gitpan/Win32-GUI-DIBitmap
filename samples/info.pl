#perl -w

use Win32::GUI::DIBitmap;

print Win32::GUI::DIBitmap::GetVersion(), "\n";

print Win32::GUI::DIBitmap::GetCopyright(), "\n";

$count = Win32::GUI::DIBitmap::GetFIFCount();

print "Format\tReading\tWriting\tDescription\n";

for ($fif = 0; $fif < $count; $fif++) {

  $format = Win32::GUI::DIBitmap::GetFormatFromFIF($fif);

  $desc  = Win32::GUI::DIBitmap::FIFDescription($fif);

  $read = "N";
  $read = "Y" if (Win32::GUI::DIBitmap::FIFSupportsReading($fif));
  $write = "N";
  $write = "Y" if (Win32::GUI::DIBitmap::FIFSupportsWriting($fif));

  $export = "";
  $export .= " 1"  if (Win32::GUI::DIBitmap::FIFSupportsExportBPP($fif, 1));
  $export .= " 4" if (Win32::GUI::DIBitmap::FIFSupportsExportBPP($fif, 4));
  $export .= " 8" if (Win32::GUI::DIBitmap::FIFSupportsExportBPP($fif, 8));
  $export .= " 16" if (Win32::GUI::DIBitmap::FIFSupportsExportBPP($fif, 16));
  $export .= " 24" if (Win32::GUI::DIBitmap::FIFSupportsExportBPP($fif, 24));
  $export .= " 32" if (Win32::GUI::DIBitmap::FIFSupportsExportBPP($fif, 32));
  $export = " [Export =$export]" unless ($export eq "");

  print "$format\t$read\t$write\t$desc$export\n";  
}

