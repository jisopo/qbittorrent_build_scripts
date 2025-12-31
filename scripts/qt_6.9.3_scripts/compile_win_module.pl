# from https://wiki.qt.io/Building_Qt_Multimedia_with_FFmpeg
# vcpkg install ffmpeg[core,swresample,swscale,avdevice]:x64-windows

use strict;
use Cwd;
use Path::Tiny;
use IPC::Cmd qw[can_run run];
use Getopt::Long;

my $current_dir = getcwd;
my $prefix_dir = path($current_dir)->parent(1); # one level up
$current_dir =~ s#/#\\#g; # convert separators to Windows-style
$prefix_dir =~ s#/#\\#g; # convert separators to Windows-style

my $arch = $ARGV[0];
my $install_dir = $ARGV[1];
my $module_dir = $ARGV[2];
my $module_name = $ARGV[3];

$arch = "amd64" if ($arch eq ''); # amd64 is nothing is specified, can be x86

die "Error: Please specify architecture (x86 or amd64)" if ($arch ne "x86" && $arch ne "amd64"); # die if user specified anything except x86 or amd64
die "Error: Please specify install dir as second parameter" if (!$install_dir);

my $batfile = 'compile_win.bat';

open BAT, '>', $batfile;

printLineToBat ("CALL \"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Enterprise\\VC\\Auxiliary\\Build\\vcvars64.bat\"");
printLineToBat ("SET _ROOT=%cd%");
printLineToBat ("SET PATH=%_ROOT%\\qtbase\\bin;%_ROOT%\\gnuwin32\\bin;%PATH%"); # http://doc.qt.io/qt-5/windows-building.html
printLineToBat ("SET OPENSSL_LIBS=-lzlib -llibcrypto -llibssl -lgdi32 -luser32 -lws2_32 -lAdvapi32 -lCrypt32");
printLineToBat ("SET ZLIB_LIBS=-lzlib");

printLineToBat ("cd $module_dir\\qtbase");
printLineToBat ("rmdir _$module_name-build-$arch /s /q");

printLineToBat ("mkdir _$module_name-build-$arch");
printLineToBat ("cd _$module_name-build-$arch");

printLineToBat ("$install_dir\\bin\\qt-configure-module.bat $module_dir\\$module_name -- -DZLIB_LIBRARY=\"C:/build/zlib-1.3.1/zlib.lib\" -DQT_NO_MSVC_MIN_VERSION_CHECK=ON -DCMAKE_CXX_FLAGS=\"/wd4305 /wd4530\" && cmake --build . --parallel && cmake --install . --config Release");

close BAT;

system ($batfile);

sub printLineToBat
{
	print BAT "$_[0]\n";
}

