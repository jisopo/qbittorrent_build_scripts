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
my $build_qbittorrent_submodules = 0;

$arch = "amd64" if ($arch eq ''); # amd64 is nothing is specified, can be x86

die "Error: Please specify architecture (x86 or amd64)" if ($arch ne "x86" && $arch ne "amd64"); # die if user specified anything except x86 or amd64
die "Error: Please specify install dir as second parameter" if (!$install_dir);
die "Error: istall dir '$install_dir' already exists" if (-d $install_dir);

my $build_dir = "_qt6-build-$arch";

die "Error: build dir '$build_dir' already exists" if (-d $build_dir);

my $batfile = 'compile_win.bat';

open BAT, '>', $batfile;

printLineToBat ("CALL \"C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Enterprise\\VC\\Auxiliary\\Build\\vcvars64.bat\"");
printLineToBat ("SET _ROOT=%cd%");
printLineToBat ("SET PATH=%_ROOT%\\qtbase\\bin;%_ROOT%\\gnuwin32\\bin;%PATH%"); # http://doc.qt.io/qt-5/windows-building.html
printLineToBat ("SET OPENSSL_LIBS=-lzlib -llibcrypto -llibssl -lgdi32 -luser32 -lws2_32 -lAdvapi32 -lCrypt32");
printLineToBat ("SET ZLIB_LIBS=-lzlib");

printLineToBat ("IF EXIST $build_dir GOTO SECOND_STEP");
printLineToBat ("mkdir $build_dir");
printLineToBat (":SECOND_STEP");
printLineToBat ("cd $build_dir");

printLineToBat ("if \"%~1\"==\"step2\" goto step2");

printLineToBat (":OPENSSL_ALREAD_COMPILED");

# my $configure_cmd = "..\\configure -prefix $install_dir -opensource -shared -release -confirm-license -opengl desktop -nomake tests -nomake examples";
my $configure_cmd = "..\\configure -prefix $install_dir -opensource -shared -release -confirm-license -ltcg -make tools -nomake examples -no-dbus -no-icu -system-zlib -openssl-linked -no-gtk -no-opengl -no-opengles3 -no-sql-sqlite -no-sql-odbc";

# append openssl related parameters
# $configure_cmd .= " -openssl-linked -- -DCMAKE_CXX_FLAGS=\"/await:strict\" -DOPENSSL_ROOT_DIR=\"$openssl_dir\\build\" -DOPENSSL_INCLUDE_DIR=\"$openssl_dir\\build\\include\" -DOPENSSL_USE_STATIC_LIBS=ON";
$configure_cmd .= " -c++std c++20 -openssl-linked -- -DQT_BUILD_TESTS=OFF -DQT_BUILD_EXAMPLES=OFF -DQT_NO_MSVC_MIN_VERSION_CHECK=ON -DOPENSSL_ROOT_DIR=\"C:\\build\\openssl-3.5.4\" -DOPENSSL_INCLUDE_DIR=\"C:\\build\\openssl-3.5.4\\include\" -DOPENSSL_USE_STATIC_LIBS=ON";
$configure_cmd .= " && cmake --build . --parallel && cmake --install . --config Release";

printLineToBat ($configure_cmd);

printLineToBat ("goto :EOF");

# step 2:
printLineToBat (":step2");

printLineToBat ("IF ERRORLEVEL 1 (");
printLineToBat ("echo Build failed with error %ERRORLEVEL%.");
printLineToBat ("EXIT /B %ERRORLEVEL%");
printLineToBat (")");

#printLineToBat ("cmake --install . --config Release");
# printLineToBat ("cmake --install . --config Debug");

# clean up
printLineToBat ("cd .."); # since we're now in 'qt6-build' for some reason
printLineToBat ("rmdir $build_dir /s /q");

# remove _tools folder from the installation directory
printLineToBat ("rmdir $install_dir\\_tools /s /q");

# todo: добавить удаление папок сборки после успешной сборки
if ($build_qbittorrent_submodules)
{
    printLineToBat ("mkdir _LinguistTools-build-$arch");
    printLineToBat ("cd _LinguistTools-build-$arch");

    printLineToBat ("$install_dir\\bin\\qt-configure-module.bat $module_dir/qttools -- && cmake --build . --parallel && cmake --install . --config Release");
}

close BAT;

system ($batfile);

sub printLineToBat
{
	print BAT "$_[0]\n";
}

