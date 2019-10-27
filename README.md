# backupry
A simple bash script to perform and organize daily backups neatly on Unix system
Uses rsync for efficient file transfer.

# Usage
1. Download the script & open your terminal.
2. Make the script executable `chmod 655 backupry.sh`.
3. Create/Choose a backup folder (preferably on another drive), ex: `mkdir /media/zanna/Backups/`
4. Choose the source folder you wish to backup, ex: `/home/zanna/downloads/`
5. Run backupry: `./backupry [source dir] [backup dir]`

You may define default backup folder by changind the following variables in the script:
`default_backup_dir` & `default_src_dir`

## Backup folder structure
Backups' folder name is the current date in YYYY-MM-DD format. It's parent directory always have the same name as the source folder.
For example, if the backup folder is `/archive` and the source is `/downloads`the structure would be:
```
  archive/
     downloads/
        2019-10-23/
           mariadb.zip
           shrimp.png
           notes.txt
           ...
        2019-10-26/
           mariadb.jpeg
           shrimp.jpeg
           burden.zip
           ...
        2019-10-28/
           sales.excel
           cat.png
           novel.docx
           ... 
```

# Usage requirements
- Bash version 4.1 or greater
- rsync version 3 or greater (installed by default on most unix systems)
# Licence
MIT. See LICENSE.md
