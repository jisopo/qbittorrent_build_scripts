call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"

set qbt_path="C:\build\qBittorrent-release-5.1.4\build\Release"

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

echo "Press any key to exit"
pause