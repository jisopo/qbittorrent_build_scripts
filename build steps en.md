Windows build (MSVC 2019, 64 bit, dynamic linkage, windows 7/8.1 support)

## Introduction

In this section described why build was made this was and several construction capabilities. If you want start building right now, link is [here](https://github.com/jisopo/qbittorrent_build_scripts/blob/qbittorrent_5.1.4_qt_6.9.3_x64/build%20steps%20en.md#building)

### Component versions used:

![](https://jisopo.github.io/qbittorrent/software_used/software_used.png)

To make build easy build scripts was made. In order to avoid conflicts between packages, specific package versions are listed in the dependencies list with their download links. To avoid manually changes (cflags/ldflags) build scripts contains patch files, they applies automatically via git. If required packages copied earlier, qbittorrent is able to build **without** internet connection.

### Static and dynamic linkage

Another articles describe build using static linkage, a clear example of difference between it on the screenshot below.

![](https://jisopo.github.io/qbittorrent/diff/static_and_dynamic_linkage_en.png)

Main reason to choose dynamic linkage over static linkage was ability to replace some of components (libtorrent, qt and others). In case such as static linkage for component replacement fully rebuild is required (modules located inside qbittorrent.exe executable).

### Windows 7/8.1 compability

Qbittorrent itselfs works on windows 7/8.1, does not work his module/component qt, its a graphics libraty (user interface/ui).
Qt 6.9.3 is used in this article with patches for windows 7/8.1 compability. Changes can be viewed in patch files `qbittorrent_build_scripts\patches`. Qt library with windows 7/8.1 support was done before this article: [here](https://github.com/crystalidea/qt6windows7) (qt 6.6.0 - 6.8.3) and [here](https://github.com/ANightly/qt6windows7) (qt 6.9.3 - 6.10.0). In this article patched qt merged with qbittorent for windows 7/8.1 compability.

### Component versions


Versions is up-to-date on early January 2026.

- qbittorrent: 5.1.4 - latest stable version, support of other versions in not guaranteed.
- Microsoft visual studio 2019. This is the latest version that works on windows 8.1. Visual studio 2022 works with windows 8.1 on version 17.6 LTSC, в Visual Studio 2022 version 17.7 and above does not work on windows 8.1, details [here](https://learn.microsoft.com/en-us/troubleshoot/developer/visualstudio/installation/visual-studio-2022-unsupported-operating-systems).
- Qt: 6.9.3 with patches for windows 7 from here. Latest available version 6.10.0, build of qt 6.10.0 in visual studio 2019 fails, because of it qt 6.9.3 is used.
- openssl: 3.5.4 is LTS version. LTS - Long Time Support with support up to 8 April 2030, while version 3.6.0 supports until 1 November 2026. 
- boost: version 1.86 used in official qbittorrent 5.1.4 build. Version 1.87 with libtorrent RC_1_2 appears warnings about using outdated functions, 1.89 incompatible with libtorrent RC_1_2, used functions deleted/removed.
- zlib: version 1.3.1 used in official qbittorrent 5.1.4 build, 1.3.1 is latest available version
- other components version: 7z, nasm, strawberry perl, git, jom latest available


## Build features:

- C++20 (boost, libtorrent, qt6, qbittorrent)
- Dynamic linkage
- Multithreaded openssl building
- Fixed component versions
- Network connection is not neccessary
- QtCreator is not needed
- Windows 7/8.1 compability


## qbittorrent 5.1.4 x64 building: from system installation to first start (video)

building qbittorrent on windows 8.1: [Video (youtube)](https://www.youtube.com/watch?v=IJG-X4S47Aw)

## Build dependencies:

- Microsoft visual studio 2019
- git
- jom (multithreaded openssl building)
- openssl
- 7z (as archiver)
- nasm
- qt
- perl
- boost
- zlib
- cmake (Windows 7 only)

In build uses microsoft visual studio 2019 enterprise update 16.11.00. Usage of version 16.11 or above $${\color{red}very\spaceimportant}$$. Build errors can appears building qt with visual studio 16.7 or below.


Microsoft visual studio 2019 components listed below. Components list may by applied with configuration file ([visual_studio_configuration/.vsconfig](https://github.com/jisopo/qbittorrent_build_scripts/blob/qbittorrent_5.1.4_qt_6.9.3_x64/visual_studio_configuration/.vsconfig)) via visual studio installer.

<details>
  <summary>configuration import in visual studio (gif) (clickable)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/install/vs2019_import_configuration.gif)
  
</details>

### Microsoft visual studio 2019 components:

- MSBuild
- C++ core features
- Text template transformation
- C++ 2019 Redistributable Update
- C++ ATL for latest v142 build tools with Spectre Mitigations (x86 & x64)
- C++ MFC for latest v142 build tools with Spectre Mitigations (x86 & x64)
- MSVC v142 - VS 2019 C++ x64/x86 build tools (Latest)
- MSVC v142 - VS 2019 C++ x64/x86 build Spectre-mitigated libs (Latest)
- Windows 10 SDK (10.0.20348.0)
- Desktop development with C++


## Dependencies download links (exclude visual studio) and qbittorrent with versions used upon build:

For some of packages there is several download links (mirror), for such purpose as:
- package was removed
- package was moved
- download link is unavailable is your region


### Dependencies:


Git 2.52.0 (windows 8.1 and up): [Download](https://github.com/git-for-windows/git/releases/download/v2.52.0.windows.1/Git-2.52.0-64-bit.exe) [Download](https://sourceforge.net/projects/git-for-windows.mirror/files/v2.52.0.windows.1/Git-2.52.0-64-bit.exe/download) [Download](https://jisopo.github.io/qbittorrent/dependencies/Git-2.52.0-64-bit.exe)

Git 2.23.0 (windows 7): [Download](https://github.com/git-for-windows/git/releases/download/v2.23.0.windows.1/Git-2.23.0-64-bit.exe) [Download](https://mirrors.huaweicloud.com/git-for-windows/v2.23.0.windows.1/Git-2.23.0-64-bit.exe) [Download](https://jisopo.github.io/qbittorrent/dependencies/Git-2.23.0-64-bit.exe)

jom 1.1.5: [Download](https://ftp.fau.de/qtproject/official_releases/jom/jom_1_1_5.zip) [Download](https://www.mirrorservice.org/sites/download.qt-project.org/official_releases/jom/jom_1_1_5.zip) [Download](https://jisopo.github.io/qbittorrent/dependencies/jom_1_1_5.zip)

openssl 3.5.4: [Download](https://github.com/openssl/openssl/releases/download/openssl-3.5.4/openssl-3.5.4.tar.gz) [Download](https://sourceforge.net/projects/openssl-project.mirror/files/openssl-3.5.4/openssl-3.5.4.tar.gz/download) [Download](https://jisopo.github.io/qbittorrent/dependencies/openssl-3.5.4.tar.gz)

7z 2501: [Download](https://www.7-zip.org/a/7z2501-x64.exe) [Download](https://sourceforge.net/projects/sevenzip/files/7-Zip/25.01/7z2501-x64.exe/download) [Download](https://jisopo.github.io/qbittorrent/dependencies/7z2501-x64.exe)

nasm 3.01: [Download](https://www.nasm.us/pub/nasm/releasebuilds/3.01/win64/nasm-3.01-installer-x64.exe) [Download](https://jisopo.github.io/qbittorrent/dependencies/nasm-3.01-installer-x64.exe)

qt 6.9.3: [Download](https://laotzu.ftp.acc.umu.se/mirror/qt.io/qtproject/archive/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Download](https://mirror.aarnet.edu.au/pub/qtproject/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Download](https://mirrors.ocf.berkeley.edu/qt/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Download](https://ftp.nluug.nl/languages/qt/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Download](https://www.nic.funet.fi/pub/mirrors/download.qt-project.org/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Download](https://mirror.netcologne.de/qtproject/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Download](https://qt-mirror.dannhauer.de/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Download](https://qtproject.mirror.liquidtelecom.com/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip)

libtorrent 1_2_R: [Download](https://github.com/arvidn/libtorrent/archive/refs/heads/RC_1_2.zip)

qbittorrent 5.1.4: [Download](https://github.com/qbittorrent/qBittorrent/archive/refs/tags/release-5.1.4.zip)

strawberry perl 5.42.0.1: [Download](https://github.com/StrawberryPerl/Perl-Dist-Strawberry/releases/download/SP_54201_64bit/strawberry-perl-5.42.0.1-64bit.msi)

boost 1.86: [Download](https://archives.boost.io/release/1.86.0/source/boost_1_86_0.zip) [Download](https://sourceforge.net/projects/boost/files/boost/1.86.0/boost_1_86_0.zip/download)

zlib 1.3.1: [Download](https://www.zlib.net/zlib131.zip) [Download](https://github.com/madler/zlib/releases/download/v1.3.1/zlib131.zip) [Download](https://jisopo.github.io/qbittorrent/dependencies/zlib131.zip)

**Windows 7 only**:

cmake 3.22.3 x86_64: [Download](https://github.com/Kitware/CMake/releases/download/v3.22.3/cmake-3.22.3-windows-x86_64.msi) [Download](https://jisopo.github.io/qbittorrent/dependencies/cmake-3.22.3-windows-x86_64.msi)


## Dependencies installation:

<details>
  <summary>7z (gif) (clickable)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/install/7z.gif)
  
</details>

<details>
  <summary>nasm (gif) (clickable)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/install/nasm.gif)
  
</details>

<details>
  <summary>git (gif) (clickable)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/install/git.gif)
  
</details>

<details>
  <summary>perl (gif) (clickable)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/install/perl.gif)
  
</details>


### Additional for Windows 7 only (not needed on Windows 8.1 and above):

Cmake 3.29.2 (comes with strawberry perl 5.42.0.1) too new (function GetSystemTimePreciseAsFileTime added in windows 8.1).

1) Remove file `C:\Strawberry\c\bin\cmake.exe`
<details>
<summary>folder with cmake (clickable)</summary>

![](https://jisopo.github.io/qbittorrent/errors/strawberry_cmake.png)

</details>

2) Install `cmake-3.22.3-windows-x86_64.msi` with mark 'add to PATH variable'
<details>
<summary>Cmake installation (gif) (clickable)</summary>

![](https://jisopo.github.io/qbittorrent/install/cmake.gif)

</details>

If you **skip** installing of cmake 3.22.3, the following error may occur (when building libtorrent, qbittorrent, qt6):

<details>
<summary>error description (clickable)</summary>

![](https://jisopo.github.io/qbittorrent/errors/cmake.png)

</details>

### Continue dependencies installation:
### jom:

Unpack `jom_1_1_5.zip` in `C:\soft\path`.


Folder `C:\soft\path` after unpack:

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/jom_1_1_5.png)


Path `C:\soft\path` used for openssl multithreaded building, singlethreaded nmake was used before and build took much more time.


Path from build scripts is used in build time. Unpack building dependencies is needed to `C:\build`, correct folder hierarchy for every component on the screenshot's below.

## Unpack next packages in `C:\build`

- zlib
- openssl
- boost
- libtorrent
- qt
- qbittorrent

### Folder hierarchy after unpack:

### zlib 1.3.1:

<details>
<summary>click to show image</summary>

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/zlib_1.3.1.png)

</details>

### openssl 3.5.4:

<details>
<summary>click to show image</summary>

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/openssl_3.5.4.png)

</details>

### boost 1.86:

<details>
<summary>click to show image</summary>

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/boost_1.86.png)

</details>

### libtorrent RC_1_2:

<details>
<summary>click to show image</summary>

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/libtorrent-RC_1_2.png)

</details>

### qt 6.9.3:

<details>
<summary>click to show image</summary>

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/qt_6.9.3.png)

</details>

### qbittorrent 5.1.4:

<details>
<summary>click to show image</summary>

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/qbittorrent_5.1.4.png)

</details>

Libtorrent RC_1_2 is used in this build, but build scripts is also compatible with Libtorrent RC_2_0.

## Building:
Scripts located and starts from folder `qbittorrent_build_scripts\scripts`

1) Install dependencies from [here](https://github.com/jisopo/qbittorrent_build_scripts/blob/qbittorrent_5.1.4_qt_6.9.3_x64/build%20steps%20en.md#build-dependencies) section, download links [here](https://github.com/jisopo/qbittorrent_build_scripts/blob/qbittorrent_5.1.4_qt_6.9.3_x64/build%20steps%20en.md#dependencies)
2) Unpack packages as described [here](https://github.com/jisopo/qbittorrent_build_scripts/blob/qbittorrent_5.1.4_qt_6.9.3_x64/build%20steps%20en.md#unpack-next-packages-in-cbuild)
3) Start `build_zlib_1.3.1.bat`
In some cases, an error occurs when applying the patch.

  <details>
  <summary>error description (clickable)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/errors/zlib.png)
  
  </details>

Solution is described [here](https://github.com/jisopo/qbittorrent_build_scripts/blob/qbittorrent_5.1.4_qt_6.9.3_x64/build%20steps%20en.md#unable-to-apply-patch-for-zlib-131)

4) Start `build_openssl_3.5.4.bat`
5) Start `build_boost_1.86.bat`
6) Start `build_libtorrent_RC_1_2.bat`
7) Start `patch_qt_6.9.3.bat`
8) Unpack $${\color{red}content}$$ of `qt_6.9.3_scripts` in `qt-everywhere-src-6.9.3/qtbase`

  <details>
  <summary>gif (clickable)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/install/qt_scripts.gif)
  
  </details>


9) Start `compile_win_x64.bat` from `qt-everywhere-src-6.9.3/qtbase`
9) Start `build_qbittorrent_5.1.4.bat`

After successful build qbittorrent 5.1.4 files was located in `C:\build\qBittorrent-release-5.1.4\build\Release`

## Possible errors:

### Unable to apply patch for zlib 1.3.1
Apply patch using tortoise git tortoise git 2.12.0.0 64bit: [Download](https://download.tortoisegit.org/tgit/2.12.0.0/TortoiseGit-2.12.0.0-64bit.msi) [Download](https://repo.huaweicloud.com/tortoisegit/2.12.0.0/TortoiseGit-2.12.0.0-64bit.msi) [Download](https://jisopo.github.io/qbittorrent/dependencies/TortoiseGit-2.12.0.0-64bit.msi)


  <details>
  <summary>TortoiseGit installation (gif) (clickable)</summary>

  ![](https://jisopo.github.io/qbittorrent/install/tortoise_git.gif)

  </details>

**Patch apply**:

Open .patch file (located in `qbittorrent_build_scripts\patches`) -> File -> Apply Patch -> Select folder `C:\build\zlib_1.3.1` -> Patch All items

  <details>
  <summary>Path apply (video) (clickable)</summary>

  </details>
