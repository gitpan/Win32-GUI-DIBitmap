use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile(
    'NAME'         => 'Win32::GUI::DIBitmap',
    'VERSION_FROM' => 'DIBitmap.pm',
    'XS'           => { 'DIBitmap.xs' => 'DIBitmap.cpp' },
    'LIBS'      => ['Msvcprt.lib'],   # e.g., '-lm'
    'DEFINE'    => '',     # e.g., '-DHAVE_SOMETHING'
    'INC'       => '',     # e.g., '-I/usr/include/other'
    'MYEXTLIB' => 'extlib/FreeImage.lib',
     ($] ge '5.005')
     ? (
      'AUTHOR'   => 'ROCHER Laurent (rocherl@club-internet.fr)',
      'ABSTRACT' => 'Add new load/save image format and some image manipulation',
     )
     : (),
);


sub MY::xs_c {
'

.xs.c:
    $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) $(XSUBPP) $(XSPROTOARG) $(XSUBPPARGS) $*.xs > $*.c

.xs.cpp:
    $(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) $(XSUBPP) $(XSPROTOARG) $(XSUBPPARGS) $*.xs > $*.cpp

';
}
