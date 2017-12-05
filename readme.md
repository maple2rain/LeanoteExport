# LeanoteExport

This is for export markdown files from Leanote.

# Leanote4Md.py

For more infomation about this file, you can learn more from [github](https://github.com/goodbest/Leanote4MD), and other's [blog](https://czero000.github.io/2016/11/17/backup-leanote.html) which backup the leanote.

# Leanote.cfg

You need to change you email and passwd so as to login your own Leanote account. Also, you can change the target dir to store the export markdown files and pictures if any.

# export.sh

This file will export the markdown files. All you need to do is execute `./export.sh` after you clone or download this repository and modify the `Leanote.cfg`.
What this file realy does is :

- execute the Leanote4MD.py to export leanote
- modify markdown files name to satisfy the command of jekyll
- modify picture link name for local files
