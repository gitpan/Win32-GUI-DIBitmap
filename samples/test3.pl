#perl -w
#
# Test standalone : 
#
# Functions Test :
#    - newFromFile
#    - GetFIFCount
#    - FIFSupportsWriting
#    - FIFSupportsReading
#    - SaveToData
#    - newFromData
#    - SaveToFile


use Win32::GUI::DIBitmap;

$dib = Win32::GUI::DIBitmap->newFromFile ("bmp/zapotec.jpg") or die "Load zapotec.jpg";
$dib = $dib->ConvertTo24Bits();

for ($i = 0; $i < Win32::GUI::DIBitmap::GetFIFCount(); $i++) {

  if (Win32::GUI::DIBitmap::FIFSupportsWriting($i) && 
      Win32::GUI::DIBitmap::FIFSupportsReading($i) &&    
      Win32::GUI::DIBitmap::FIFSupportsExportBPP($i, 24) &&
      $i != 7 && $i != 8 && $i != 11 && $i != 12 && $i != 14 && $i != 15 && $i != 17) {

     $format = Win32::GUI::DIBitmap::GetFormatFromFIF($i);
     print "Test format = $format\n";

     $data = $dib->SaveToData($i) or die " SaveToData $i $format";
     $dib2 = Win32::GUI::DIBitmap->newFromData($data) or die " newFromData $i $format";

     $dib2->SaveToFile($i.'.bmp') or die "SaveToFile dib2 $i $format";
     undef $dib2;
     undef $data;
  }
}
