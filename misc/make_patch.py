import os
from pathlib import Path

base_path = "C:\\source\\qbittorrent_work_environment\\qt_6.9.3_patch"
original_name = "qt-everywhere-src-6.9.3"
patched_name = "ANightly_qt6windows7"
folder_original = os.path.join(base_path, original_name)
folder_patched = os.path.join(base_path, patched_name)

patchfile_name = "qt_6.9.3_win8.1.patch"
patchfile = os.path.join(base_path, patchfile_name)

excluded_files = ["designer.png", "README.md", ".editorconfig", ".gitattributes"]

if Path(patchfile).exists():
    os.remove(patchfile)
open(patchfile, 'a').close()

for file in Path(folder_patched).glob('**/*.*'):
    if file.is_dir() or file.name in excluded_files or ".git" in str(file):
        continue

    original_file = str(file).replace(patched_name, original_name)
    original_exists = Path(original_file).exists()

    print("{} | original exists: {}".format(file, original_exists))

    if not original_exists:
        os.system("git diff --no-index /dev/null {} >> {}".format(str(file), patchfile))
    else:
        os.system("git diff --no-index {} {} >> {}".format(original_file, str(file), patchfile))
