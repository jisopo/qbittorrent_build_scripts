@echo off
set current_path=%~dp0
cd "C:\build\qt-everywhere-src-6.8.3"
echo "Applying patch.."
echo "Applying patch qt_6.8.3_win8.1"
git apply --whitespace=nowarn --unsafe-paths %current_path%..\patches\qt_6.8.3_win8.1.patch
echo "Applying patch qt_6.8.3_cplusplus20_vs2019"
git apply --whitespace=nowarn --unsafe-paths %current_path%..\patches\qt_6.8.3_cplusplus20_vs2019.patch
echo "Done"
pause