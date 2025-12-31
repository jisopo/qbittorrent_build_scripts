@echo off
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
cd "C:\build\libtorrent-RC_2_0"
echo "Configuring.."
cmake -G "Visual Studio 16 2019" -B build -DCMAKE_BUILD_TYPE=Release -DOPENSSL_ROOT_DIR="C:\build\openssl-3.5.4" -DOPENSSL_INCLUDE_DIR="C:\build\openssl-3.5.4\include" -DBOOST_ROOT="C:\build\boost_1_86_0" -DCMAKE_CXX_STANDARD=20 -DCMAKE_CXX_FLAGS="/MP /wd4996" -DBUILD_SHARED_LIBS=ON -Ddeprecated-functions=ON -Wno-dev
echo "Building Debug.."
cmake --build build --config Debug
echo "Building Release.."
cmake --build build --config Release
echo "Press any key to exit.."
pause