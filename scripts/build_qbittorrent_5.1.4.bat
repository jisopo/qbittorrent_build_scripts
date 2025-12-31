@echo off
set current_path=%~dp0
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
cd "C:\build\qBittorrent-release-5.1.4"
echo "Configuring.."
cmake -G "Visual Studio 16 2019" -B build -DCMAKE_BUILD_TYPE=Debug -DLibtorrentRasterbar_DIR="C:\build\libtorrent-RC_1_2\build\LibtorrentRasterbar" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DMSVC_RUNTIME_DYNAMIC=ON -DBOOST_ROOT="C:\build\boost_1_86_0" -DZLIB_INCLUDE_DIR="C:\build\zlib-1.3.1" -DZLIB_LIBRARY="C:\build\zlib-1.3.1\zlib.lib" -DOPENSSL_ROOT_DIR="C:\build\openssl-3.5.4" -DOPENSSL_INCLUDE_DIR="C:\build\openssl-3.5.4\include" -DCMAKE_CXX_STANDARD=20 -DCMAKE_CXX_FLAGS="/MP" -DQt6_DIR="C:\build\qt6\lib\cmake\Qt6" -Wno-dev
echo "Building Debug.."
cmake --build build --config Debug
echo "Building Release.."
cmake --build build --config Release
echo "Press any key to exit.."
pause