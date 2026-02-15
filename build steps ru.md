Сборка на Windows (MSVC 2019, 64 разрядность, динамическая линковка, поддержка windows 7/8.1)

## Введение

В этой секции описано, почему сборка была сделана именно так и некоторые её конструктивные особенности. Если вы собираетесь переходить непосредственно к самой сборке, ссылка [тут](https://github.com/jisopo/qbittorrent_build_scripts/blob/qbittorrent_5.1.4_qt_6.9.3_x64/build%20steps%20ru.md#%D1%81%D0%B1%D0%BE%D1%80%D0%BA%D0%B0)

### Версии компонентов используемые в программе:

![](https://jisopo.github.io/qbittorrent/software_used/software_used.png)

Для упрощения сборки были созданы специальные сборочные скрипты. С целью избежать конфликты между пакетами в списке зависимостей указаны конкретные версии пакетов со ссылками на их загрузку. Чтобы не применять изменения вручную (cflags/ldflags) в сборочным скриптах есть файлы патчей, они применяются автоматически через git. Если пакеты необходимые для сборки заранее скопировать и настроить систему, то собрать qbittorrent можно **без** подключения к интернету. 

### Статическая и динамическая линковка

В других руководствах описана сборка с использованием статической линковки, наглядный пример разницы между ними на скриншоте ниже.

![](https://jisopo.github.io/qbittorrent/diff/static_and_dynamic_linkage_ru.png)

Основной причиной выбора динамической линковки стала возможность замены нужных компонентов (libtorrent, qt и прочего). В случае со статической линковкой для замены компонентов нужна полная пересборка (модули находятся внутри исполняемого файла qbittorrent.exe).

### Поддержка windows 7/8.1

Qbittorrent сам по себе работает на windows 7/8.1, не работает его модуль/компонент qt, это графическая библиотека (интерфейс пользователя).
В данном руководстве используется qt 6.9.3 с изменениями (патчами) под работу с windows 7/8.1. Список изменений можно посмотреть в патчах по пути `qbittorrent_build_scripts\patches`. Библиотека qt с поддержкой windows 7/8.1 уже была до написания этого руководства: [тут](https://github.com/crystalidea/qt6windows7) (qt 6.6.0 - 6.8.3) и [тут](https://github.com/ANightly/qt6windows7) (qt 6.9.3 - 6.10.0). В данном руководстве qt с патчами объеденён с qbittorrent для работы на windows 7/8.1.

### Выбор версий


Версии актуальны по состоянию на начало Января 2026 года.

- qbittorrent: 5.1.4 - последняя фиксированная версия, на других версиях работоспособность не гарантирована.
- Microsoft visual studio 2019. Это последняя версия которая работает на windows 8.1. Visual studio 2022 работает с windows 8.1 на версии 17.6 LTSC, версия Visual Studio 2022 17.7 и выше не поддерживается на windows 8.1, подробнее [тут](https://learn.microsoft.com/en-us/troubleshoot/developer/visualstudio/installation/visual-studio-2022-unsupported-operating-systems).
- Qt: 6.9.3 с патчами для поддержки windows 7 взято тут. Последняя доступная версия 6.10.0, собрать qt 6.10.0 в visual studio 2019 не удалось, поэтому используется qt 6.9.3.
- openssl: 3.5.4 это LTS версия. LTS - Long Time Support с поддержкой до 8 апреля 2030 года, в то время когда версия 3.6.0 с поддержкой до 1 ноября 2026 года. 
- boost: 1.86 используется в официальной сборке qbittorrent 5.1.4. Версия 1.87 выдаёт предупреждение про использование устаревших функций при сборке libtorrent RC_1_2, 1.89 несовместима с libtorrent RC_1_2, используемые функции удалены/переименованы.
- zlib: версия 1.3.1 используется в официальной сборке qbittorrent 5.1.4, версия 1.3.1 последняя из доступных
- версии остальных пакетов: 7z, nasm, strawberry perl, git, jom последние из доступных


## Особенности сборки:

- C++20 (boost, libtorrent, qt6, qbittorrent)
- Динамическая линковка
- Многопоточная сборка openssl
- Фиксированные версии компонентов
- Сборка без подключения к интернету
- Qtcreator не требуется
- Поддержка windows 7/8.1


## Cборка qbittorrent 5.1.4 x64: от установки системы и до первого запуска.

сборка qbittorrent на windows 8.1: [Видео (youtube)](https://www.youtube.com/watch?v=IJG-X4S47Aw)


## Зависимости для сборки:

- Microsoft visual studio 2019
- git
- jom (многопоточная сборка openssl)
- openssl
- 7z (как архиватор)
- nasm
- qt
- perl
- boost
- zlib
- cmake (только для Windows 7)

Для сборки использовалась microsoft visual studio 2019 enterprise обновление 16.11.00. Использование версии 16.11 или выше $${\color{red}очень\spaceважно}$$. При сборке qt может возникнуть ошибка если версия visual studio 16.7 или ниже.


Используемые компоненты microsoft visual studio 2019 указаны в списке ниже. Их так же можно выбрать через импорт файла конфигурации ([visual_studio_configuration/.vsconfig](https://github.com/jisopo/qbittorrent_build_scripts/blob/qbittorrent_5.1.4_qt_6.9.3_x64/visual_studio_configuration/.vsconfig)) в установщике visual studio

<details>
  <summary>импорт конфигурации в visual studio (gif) (кликабельно)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/install/vs2019_import_configuration.gif)
  
</details>

### Компоненты microsoft visual studio 2019:

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


## Ссылки на загрузку зависимостей (кроме visual studio) и qbittorrent с версиями используемыми при сборке:

Для некоторых пакетов несколько ссылок на загрузку (зеркала), это сделано на случай если:
- пакет удалён
- пакет перемещён по другой ссылке
- адрес для загрузки пакета недоступен в вашем регионе


### Зависимости:


Git 2.52.0 (windows 8.1 и выше): [Скачать](https://github.com/git-for-windows/git/releases/download/v2.52.0.windows.1/Git-2.52.0-64-bit.exe) [Скачать](https://sourceforge.net/projects/git-for-windows.mirror/files/v2.52.0.windows.1/Git-2.52.0-64-bit.exe/download) [Скачать](https://jisopo.github.io/qbittorrent/dependencies/Git-2.52.0-64-bit.exe)

Git 2.23.0 (windows 7): [Скачать](https://github.com/git-for-windows/git/releases/download/v2.23.0.windows.1/Git-2.23.0-64-bit.exe) [Скачать](https://mirrors.huaweicloud.com/git-for-windows/v2.23.0.windows.1/Git-2.23.0-64-bit.exe) [Скачать](https://jisopo.github.io/qbittorrent/dependencies/Git-2.23.0-64-bit.exe)

jom 1.1.5: [Скачать](https://ftp.fau.de/qtproject/official_releases/jom/jom_1_1_5.zip) [Скачать](https://www.mirrorservice.org/sites/download.qt-project.org/official_releases/jom/jom_1_1_5.zip) [Скачать](https://jisopo.github.io/qbittorrent/dependencies/jom_1_1_5.zip)

openssl 3.5.4: [Скачать](https://github.com/openssl/openssl/releases/download/openssl-3.5.4/openssl-3.5.4.tar.gz) [Скачать](https://sourceforge.net/projects/openssl-project.mirror/files/openssl-3.5.4/openssl-3.5.4.tar.gz/download) [Скачать](https://jisopo.github.io/qbittorrent/dependencies/openssl-3.5.4.tar.gz)

7z 2501: [Скачать](https://www.7-zip.org/a/7z2501-x64.exe) [Скачать](https://sourceforge.net/projects/sevenzip/files/7-Zip/25.01/7z2501-x64.exe/download) [Скачать](https://jisopo.github.io/qbittorrent/dependencies/7z2501-x64.exe)

nasm 3.01: [Скачать](https://www.nasm.us/pub/nasm/releasebuilds/3.01/win64/nasm-3.01-installer-x64.exe) [Скачать](https://jisopo.github.io/qbittorrent/dependencies/nasm-3.01-installer-x64.exe)

qt 6.9.3: [Скачать](https://laotzu.ftp.acc.umu.se/mirror/qt.io/qtproject/archive/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Скачать](https://mirror.aarnet.edu.au/pub/qtproject/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Скачать](https://mirrors.ocf.berkeley.edu/qt/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Скачать](https://ftp.nluug.nl/languages/qt/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Скачать](https://www.nic.funet.fi/pub/mirrors/Скачать.qt-project.org/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Скачать](https://mirror.netcologne.de/qtproject/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Скачать](https://qt-mirror.dannhauer.de/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip) [Скачать](https://qtproject.mirror.liquidtelecom.com/official_releases/qt/6.9/6.9.3/single/qt-everywhere-src-6.9.3.zip)

libtorrent 1_2_R: [Скачать](https://github.com/arvidn/libtorrent/archive/refs/heads/RC_1_2.zip)

qbittorrent 5.1.4: [Скачать](https://github.com/qbittorrent/qBittorrent/archive/refs/tags/release-5.1.4.zip)

strawberry perl 5.42.0.1: [Скачать](https://github.com/StrawberryPerl/Perl-Dist-Strawberry/releases/download/SP_54201_64bit/strawberry-perl-5.42.0.1-64bit.msi)

boost 1.86: [Скачать](https://archives.boost.io/release/1.86.0/source/boost_1_86_0.zip) [Скачать](https://sourceforge.net/projects/boost/files/boost/1.86.0/boost_1_86_0.zip/download)

zlib 1.3.1: [Скачать](https://www.zlib.net/zlib131.zip) [Скачать](https://github.com/madler/zlib/releases/download/v1.3.1/zlib131.zip) [Скачать](https://jisopo.github.io/qbittorrent/dependencies/zlib131.zip)

**Только для Windows 7**:

cmake 3.22.3 x86_64: [Скачать](https://github.com/Kitware/CMake/releases/download/v3.22.3/cmake-3.22.3-windows-x86_64.msi) [Скачать](https://jisopo.github.io/qbittorrent/dependencies/cmake-3.22.3-windows-x86_64.msi)


## Установка зависимостей:

  <details>
  <summary>Установка cmake (gif) (кликабельно)</summary>
  
  </details>

<details>
  <summary>7z (gif) (кликабельно)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/install/7z.gif)
  
</details>

<details>
  <summary>nasm (gif) (кликабельно)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/install/nasm.gif)
  
</details>

<details>
  <summary>git (gif) (кликабельно)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/install/git.gif)
  
</details>

<details>
  <summary>perl (gif) (кликабельно)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/install/perl.gif)
  
</details>

### Дополнительный пункт только для Windows 7 (не нужно делать на Windows 8.1 и выше):

Cmake 3.29.2 который идёт в комплекте с strawberry perl 5.42.0.1 слишком новый (функция GetSystemTimePreciseAsFileTime появилась только в windows 8.1).

1) Удалить файл `C:\Strawberry\c\bin\cmake.exe`
<details>
<summary>папка с cmake (кликабельно)</summary>

![](https://jisopo.github.io/qbittorrent/errors/strawberry_cmake.png)

</details>

2) Установить `cmake-3.22.3-windows-x86_64.msi` с добавлением в path

<details>
<summary>установка cmake (gif) (кликабельно)</summary>

![](https://jisopo.github.io/qbittorrent/install/cmake.gif)

</details>

Если **не установить** cmake 3.22.3 происходит следующая ошибка (при сборке libtorrent, qbittorrent, qt6):

<details>
<summary>описание ошибки (кликабельно)</summary>

![](https://jisopo.github.io/qbittorrent/errors/cmake.png)

</details>

### Продолжение установки зависимостей
### jom:

Распаковать `jom_1_1_5.zip` в `C:\soft\path`.


Папка `C:\soft\path` после распаковки:

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/jom_1_1_5.png)


Путь `C:\soft\path` используется для многопоточной сборки openssl, первоначально использовался однопоточный nmake и сборка занимала гораздо больше времени.


При сборке используются пути из сборочных скриптов. Распаковать зависимости для сборки нужно в `C:\build`, правильная иерархия папок для каждого компонента на скриншотах ниже.

## Распаковать следующие пакеты в папку `C:\build`

- zlib
- openssl
- boost
- libtorrent
- qt
- qbittorrent

### Структуры папок после распаковки:

### zlib 1.3.1:

<details>
<summary>открыть спойлер</summary>

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/zlib_1.3.1.png)

</details>

### openssl 3.5.4:

<details>
<summary>открыть спойлер</summary>

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/openssl_3.5.4.png)

</details>

### boost 1.86:

<details>
<summary>открыть спойлер</summary>

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/boost_1.86.png)

</details>

### libtorrent RC_1_2:

<details>
<summary>открыть спойлер</summary>

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/libtorrent-RC_1_2.png)

</details>

### qt 6.9.3:

<details>
<summary>открыть спойлер</summary>

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/qt_6.9.3.png)

</details>

### qbittorrent 5.1.4:

<details>
<summary>открыть спойлер</summary>

![](https://jisopo.github.io/qbittorrent/folder_hierarchy/qbittorrent_5.1.4.png)

</details>

В сборке используется libtorrent RC_1_2, но в сборочных скриптах так же предусмотрена сборка версии RC_2_0.

## Сборка:
Скрипты находятся и запускаются из папки `qbittorrent_build_scripts\scripts`

1) Установить зависимости из [этой](https://github.com/jisopo/qbittorrent_build_scripts/blob/qbittorrent_5.1.4_qt_6.9.3_x64/build%20steps%20ru.md#%D0%B7%D0%B0%D0%B2%D0%B8%D1%81%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D0%B8-%D0%B4%D0%BB%D1%8F-%D1%81%D0%B1%D0%BE%D1%80%D0%BA%D0%B8) секции, ссылки на скачивание [тут](https://github.com/jisopo/qbittorrent_build_scripts/blob/qbittorrent_5.1.4_qt_6.9.3_x64/build%20steps%20ru.md#%D1%81%D1%81%D1%8B%D0%BB%D0%BA%D0%B8-%D0%BD%D0%B0-%D0%B7%D0%B0%D0%B3%D1%80%D1%83%D0%B7%D0%BA%D1%83-%D0%B7%D0%B0%D0%B2%D0%B8%D1%81%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D0%B5%D0%B9-%D0%BA%D1%80%D0%BE%D0%BC%D0%B5-microsoft-visual-studio-%D1%81-%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D1%8F%D0%BC%D0%B8-%D0%B8%D1%81%D0%BF%D0%BE%D0%BB%D1%8C%D0%B7%D1%83%D0%B5%D0%BC%D1%8B%D0%BC%D0%B8-%D0%BF%D1%80%D0%B8-%D1%81%D0%B1%D0%BE%D1%80%D0%BA%D0%B5)
2) Распаковать пакеты для сборки как указано [тут](https://github.com/jisopo/qbittorrent_build_scripts/blob/qbittorrent_5.1.4_qt_6.9.3_x64/build%20steps%20ru.md#%D1%80%D0%B0%D1%81%D0%BF%D0%B0%D0%BA%D0%BE%D0%B2%D0%B0%D1%82%D1%8C-%D1%81%D0%BB%D0%B5%D0%B4%D1%83%D1%8E%D1%89%D0%B8%D0%B5-%D0%BF%D0%B0%D0%BA%D0%B5%D1%82%D1%8B-%D0%B2-%D0%BF%D0%B0%D0%BF%D0%BA%D1%83-cbuild)
3) Запустить `build_zlib_1.3.1.bat`

В некоторых случая происходит ошибка при накладывании патча:

  <details>
  <summary>описание ошибки (кликабельно)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/errors/zlib.png)
  
  </details>

Решение написано [тут](https://github.com/jisopo/qbittorrent_build_scripts/blob/qbittorrent_5.1.4_qt_6.9.3_x64/build%20steps%20ru.md#%D0%BD%D0%B5-%D0%BF%D1%80%D0%B8%D0%BC%D0%B5%D0%BD%D1%8F%D1%8E%D1%82%D1%81%D1%8F-%D0%BF%D0%B0%D1%82%D1%87%D0%B8-%D0%B4%D0%BB%D1%8F-zlib-131)

4) Запустить `build_openssl_3.5.4.bat`
5) Запустить `build_boost_1.86.bat`
6) Запустить `build_libtorrent_RC_1_2.bat`
7) Запустить `patch_qt_6.9.3.bat`
8) Распаковать $${\color{red}содержимое}$$ `qt_6.9.3_scripts` в `qt-everywhere-src-6.9.3/qtbase`

  <details>
  <summary>gif (кликабельно)</summary>
  
  ![](https://jisopo.github.io/qbittorrent/install/qt_scripts.gif)
  
  </details>


9) Запустить `compile_win_x64.bat` из `qt-everywhere-src-6.9.3/qtbase`
9) Запустить `build_qbittorrent_5.1.4.bat`

После успешной сборки файлы qbittorrent 5.1.4 будут лежать в `C:\build\qBittorrent-release-5.1.4\build\Release`


## Возможные ошибки:


### Не применяются патчи для zlib 1.3.1
Применить патч можно через tortoise git 2.12.0.0 64bit: [Скачать](https://download.tortoisegit.org/tgit/2.12.0.0/TortoiseGit-2.12.0.0-64bit.msi) [Скачать](https://repo.huaweicloud.com/tortoisegit/2.12.0.0/TortoiseGit-2.12.0.0-64bit.msi) [Скачать](https://jisopo.github.io/qbittorrent/dependencies/TortoiseGit-2.12.0.0-64bit.msi)

  <details>
  <summary>Установка TortoiseGit (gif) (кликабельно)</summary>

  ![](https://jisopo.github.io/qbittorrent/install/tortoise_git.gif)

  </details>

**Применение патча**:

Открыть .patch файл (лежат в `qbittorrent_build_scripts\patches`) -> Файл -> Применить патч -> Выбрать папку `C:\build\zlib_1.3.1` -> Patch All items

  <details>
  <summary>Применение патча (видео) (кликабельно)</summary>

https://github.com/user-attachments/assets/09a8fc8a-e6ff-4426-b9a1-e7b80c05574c

  </details>
