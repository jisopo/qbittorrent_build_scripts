@echo off
set current_path=%~dp0
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
cd "C:\build\zlib-1.3.1"
echo "Applying patch zlib_1.3.1_x64.."
git apply %current_path%..\patches\zlib_1.3.1_x64.patch
echo "Building.."
nmake -f win32/Makefile.msc
echo "Press any key to exit.."
pause