@echo off
FOR /F "tokens=*" %%i in ('perl cores.pl') do SET cores_count=%%i
set current_path=%~dp0
SET PATH=%PATH%;C:\soft\path
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
cd "C:\build\openssl-3.5.4"
echo "Configuring openssl.."
perl Configure VC-WIN64A shared no-zlib no-docs no-tests no-zlib-dynamic threads --release -FS --openssldir=C:\openssl --with-zlib-lib=C:\build\zlib-1.3.1\zlib.lib
echo "Applying patch openssl_3.5.4_makefile.."
git apply %current_path%..\patches\openssl_3.5.4_makefile.patch
echo "Building.."
jom -j %cores_count%
echo "Press any key to exit.."
pause