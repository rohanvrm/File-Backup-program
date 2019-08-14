# File-Backup-program
## USAGE: list-directory \<directory\>

This program is a basic implementation of rsync. It makes a list of all the files in a directory and stores the list of regular
files in */var/temp/temp_project_find/regular_files.txt* and symbolink links in */var/temp/symbolink_links.txt*.

Once the list has been created can be used to further check for missing files.

The *list_directory()* function prints the location of file with the maximum size, in a given directory.
