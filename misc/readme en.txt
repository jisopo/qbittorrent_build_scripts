Its advanced script, not needed for mainly work, but can by helpful.

What it does:
Script compares 2 folders and makes single .patch file on exit.
Its very useful to compare patched qt files with original ones to get patch file, lately .patch file can applied by single command.

Variables:
base_path - folder with subfolders, with original and modified sources
folder_original - folder name in base_path folder with original qt sources
folder_patched - folder name in base_path folder with patched qt sources

How ho apply patch:
git apply file.patch

Usually its enought to apply patch, but in some cases next parameters is used:
git apply --whitespace=nowarn --unsafe-paths file.patch

For patch apply ui of tortoise git program can be used:
Open .patch file -> File -> Apply Patch -> Select folder -> Patch all items

Some examples in scripts/patch_qt_6.9.3.bat

Tested on:
windows 8.1
python 3.10.7
git 2.31.1
