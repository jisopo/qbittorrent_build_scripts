@echo off
set current_path=%~dp0
set qbt_path="C:\build\qBittorrent-release-5.1.4\build\Release"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
cd "C:\build\qBittorrent-release-5.1.4"
echo "Applying patch qbittorrent_5.1.4_windows7_random"
git apply --whitespace=nowarn --unsafe-paths %current_path%..\patches\qbittorrent_5.1.4_windows7_random.patch
echo "Configuring.."
cmake -G "Visual Studio 16 2019" -B build -DCMAKE_BUILD_TYPE=Debug -DLibtorrentRasterbar_DIR="C:\build\libtorrent-RC_1_2\build\LibtorrentRasterbar" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DBOOST_ROOT="C:\build\boost_1_86_0" -DZLIB_INCLUDE_DIR="C:\build\zlib-1.3.1" -DZLIB_LIBRARY="C:\build\zlib-1.3.1\zlib.lib" -DOPENSSL_ROOT_DIR="C:\build\openssl-3.5.4" -DOPENSSL_INCLUDE_DIR="C:\build\openssl-3.5.4\include" -DCMAKE_CXX_STANDARD=20 -DCMAKE_CXX_FLAGS="/MP" -DQt6_DIR="C:\build\qt6\lib\cmake\Qt6" -Wno-dev
echo "Building Debug.."
cmake --build build --config Debug
echo "Building Release.."
cmake --build build --config Release
echo "Building RelWithDebInfo.."
cmake --build build --config RelWithDebInfo

echo "Copying qt6 libs.."
xcopy C:\build\qt6\bin\Qt6Concurrent.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Core.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Designer.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6DesignerComponents.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Gui.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Help.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Network.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6PrintSupport.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Sql.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Svg.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6SvgWidgets.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Test.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6UiTools.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Widgets.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Xml.dll %qbt_path%

echo "Copying qt6 plugins.."
mkdir %qbt_path%\plugins
xcopy /E C:\build\qt6\plugins %qbt_path%\plugins

echo "Copying libtorrent.."
xcopy C:\build\libtorrent-RC_1_2\build\Release\torrent-rasterbar.dll %qbt_path%

echo "Copying openssl libs.."
xcopy C:\build\openssl-3.5.4\libcrypto-3-x64.dll %qbt_path%
xcopy C:\build\openssl-3.5.4\libssl-3-x64.dll %qbt_path%

echo "Copying zlib.."
xcopy C:\build\zlib-1.3.1\zlib1.dll %qbt_path%
move %qbt_path%\zlib1.dll %qbt_path%\zlib1__.dll
xcopy C:\build\zlib-1.3.1\zlib1.dll %qbt_path%

xcopy C:\Strawberry\c\bin\libpng16-16__.dll %qbt_path%

set qbt_path="C:\build\qBittorrent-release-5.1.4\build\RelWithDebInfo"

echo "Copying qt6 libs.."
xcopy C:\build\qt6\bin\Qt6Concurrent.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Core.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Designer.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6DesignerComponents.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Gui.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Help.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Network.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6PrintSupport.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Sql.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Svg.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6SvgWidgets.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Test.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6UiTools.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Widgets.dll %qbt_path%
xcopy C:\build\qt6\bin\Qt6Xml.dll %qbt_path%

echo "Copying qt6 plugins.."
mkdir %qbt_path%\plugins
xcopy /E C:\build\qt6\plugins %qbt_path%\plugins

echo "Copying libtorrent.."
xcopy C:\build\libtorrent-RC_1_2\build\RelWithDebInfo\torrent-rasterbar.dll %qbt_path%

echo "Copying openssl libs.."
xcopy C:\build\openssl-3.5.4\libcrypto-3-x64.dll %qbt_path%
xcopy C:\build\openssl-3.5.4\libssl-3-x64.dll %qbt_path%

echo "Copying zlib.."
xcopy C:\build\zlib-1.3.1\zlib1.dll %qbt_path%
move %qbt_path%\zlib1.dll %qbt_path%\zlib1__.dll
xcopy C:\build\zlib-1.3.1\zlib1.dll %qbt_path%

xcopy C:\Strawberry\c\bin\libpng16-16__.dll %qbt_path%

echo "Press any key to exit"
pause