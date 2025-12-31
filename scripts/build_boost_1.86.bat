@echo off
FOR /F "tokens=*" %%i in ('perl cores.pl') do SET cores_count=%%i
cd "C:\build\boost_1_86_0"
echo "Configuring.."
call bootstrap.bat
echo "Building.."
b2 -q --with-system --with-date_time address-model=64 variant=release cxxstd=20 cxxflags="-O1 -Gy -Gw -GL" linkflags="/NOLOGO /DYNAMICBASE /NXCOMPAT /LTCG /OPT:REF /OPT:ICF=5 /MANIFEST:EMBED /INCREMENTAL:NO" --hash -j %cores_count%
echo "Press any key to exit.."
pause