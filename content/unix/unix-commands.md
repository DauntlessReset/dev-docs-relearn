---
title: UNIX Commands and Tips
description: UNIX Commands and Tips 
---

## Basic UNIX Commands

General syntax of a UNIX command:

![Bash Command Syntax](/images/bash-cmd-syntax.jpeg)

*Note: Options may also be called switches or flags, and an argument is also called a parameter.*

### Navigation

```pwd`` - Print working directory (pwd or cwd). Tells you were you are, in what folder. Note that while in Windows the root directory is "C:\", in UNIX the root directory is designated by "/", which elsewhere is just used as a separator inside a path. So the the directory ```/home/giles``` really means ```root/home/giles```. 

```cd <directory-name>```

Change the present working directory (pwd) to that specified. 

```cd``` or ```cd ~```          - Return to your home directory.

```cd ..```                     - Go up one directory (e.g. go into the parent folder of your **pwd**). One ```.``` simply means the current working directory. 

```cd -```                      - Go *back* one directory, even if this is not the parent of the pwd. 

```cd /<folder>```              - Dive into a folder in the root directory (specified by "/").

```cd folder/file.txt```        - Relative directory (local address based on pwd).

```cd /bin/nano```              - Absolute directory (from root).

```cd ~/data```                 - The tilde (```~```) character can be used at the start of a path to represent the current user's home directory. 

```cat <file>``` - Print the contents of a file to the console. 

```less <file>``` - Displays a screen of the file and then stops. You can go forward one screen by pressing ```Space```, and back by pressing ```b```. Press ```q``` will quit. 

```clear``` - Clears the terminal. Useful if things are getting too cluttered. You can still access previous commands with the arrow keys, or by scrolling in your terminal. 



### Listing files and folders

```ls```

List directories and files in the present working directory.

```-a``` - Shows all files and folders, including those hidden. Hidden files are prefixed with a ".". ```./``` refers to the current working directory, while ```../``` refers to the parent of the current working directory. 

```-l``` - Displays files and directories in list format.

```-t``` - Sorts items by time, with those most currently modified at the top. 

```-r``` - Displays list in reverse order. 

```-s``` - Displays size of files and directories alongside the names. Note that size will be returned in *blocks*. 

```-S``` - Sorts the files and directories by size. 

```-F``` - Classifies output by adding a marker to file and directory names to indicate whether the are a directory (trailing ```/```), a link (```@```), or an executable (```*```).  

```-R``` - Recursively lists the directory hierarchy; lists all nested subdirectories. 

```ls -F Desktop``` - List the contents of a different directory (in this case Desktop). 

```ls file.txt folder/notes2.txt``` - ```ls``` can be given multiple paths at once. 

A common combination is ```ls -ltr``` which displays all files in a list, ordered with the most recent files at the bottom. 

### Moving and renaming files and folders

```mkdir <folder>```

Make a new directory with the specified name. You can create multiple directories simultaneously also. 

```-p``` - You can specify nested sub-directories using this flag (otherwise ```mkdir``` will return an error):

```mkdir -p ../project/data```

```mv <source> <target>```

Move a specified file to a new location. Can also be used to rename a file e.g ```mv <file> <new-name>```. Be careful though: ```mv``` will silently overwrite and existing file with the same name which could lead to data loss. By default, ```mv``` will not ask for confirmation before overwriting files. However, adding the ```--interactive``` (or ```-i```) flag will cause ```mv``` to request such confirmation. ```mv``` also works on directories.  

```mv folder/file.txt .``` - Moves the file into the current working directory. 

```cp <file> <file-copy>```

Same as move but also leaves the original copy of the file as is. Useful for leaving a backup. Can also copy multiple files to a single directory, e.g. ```cp basilisk.dat minotaur.dat unicorn.dat backup/```.

```cp -r thesis thesis_backup``` - Copies a directory and all its contents (recursive option -r). 

```rm filename.txt``` - Deletes a file permanently. To prompt for confirmation, use the ```-i``` flag (```--interactive```). 

To remove directories, use the option ```-r```. 

### Grep 

Grep is a contraction of 'global/regular expression/print', a common sequence of operations in early Unix text editors. ```grep``` finds and prints lines in files that match a pattern. 

```grep <search-term> <file>```

Returns all lines in a file that contain the search string.

```-i``` - Ignore case. 

```-w``` - This restricts matches to lines containing a word on its own. E.g. ```grep The haiku.txt``` will return lines with the word 'Thesis', whereas ``grep -w The haiku.txt``` will not. 

```-v``` - Return all files/lines that **do not** contain the term (exclude).

```-n``` - This numbers the lines that match. 

```-r``` - ```grep``` will search for a pattern recursively through a set of files or subdirectories, e.g. ```grep -r Yesterday .```.

```-o``` - Short for ```--only-matching```. Prints only the matched parts of an empty line, with each such part on a separate output line. e.g if the line ```Rex the dog was a good dog``` was searched with ```grep -o dog file.txt```, the result would be:

```
dog
dog
```

e.g. ```ls | grep -i test``` will return all files in the pwd that contain the word test in their name, regardless of case. 

You can combine ```grep``` and ```find```. This expression finds all the text files in the CWD containing the word "searching":

```
grep "searching" $(find . -name "*.txt")
```

It is important to note that the shell first resolves whatever is inside ```$()``` and then feeds that into the external command as an argument. 
#### Grep in Script

```grep``` can be used in scripts to perform searches, and can be combined with ```wc``` for frequency analysis.

This example returns how often each sister was mentioned in *Little Women*:

```
for sis in Jo Meg Beth Any
do
    echo $sis;
    grep -ow $sis LittleWomen.txt | wc -l 
done
```

### Find & Replace

Search and replace string:

```
sed -i.suffix backup 's/<find>/<replace>/g' file
```

Example:

```
sed -i.backup 's/\"/\\\"/g' pull.secret
```

{{% notice style="note" title="Note" %}}

option: ```-i.backup``` (create a backup file with the suffix of ```*.backup```)
the above example used multiple escapes:

Finds double quotes (```"```) and replaces with a backslash and double quote (```\"```).

Both double quote and backslash need to be escaped: 

   - ```"``` escaped is ```\"```

   - ```"\``` escaped is ```\\\"```

{{% /notice %}}


#### Regular Expressions

```-E``` - Short for ```--extended-regexp```. Interpret pattern as an extended regular express (force **grep** to behave as **egrep**).

```
grep -E "^.o" haiku.txt
```

This will return all lines that have an 'o' in the second position. Quotes are used to prevent the shell from trying to interpret the string. The ```^``` anchors the match to the start of the line, while the ```.``` matches a single character (like ```?``` in the shell). 

### Find

The ```find``` command finds files. 

```find .``` will return everything in the current working directory. 

```find . -type d``` will return all directories in the CWD. 

```find . -type f``` will return all files in the CWD. 

```find . -name "*.txt"``` will return all files with the ```.txt``` suffix. Make sure to include the quotes around ```*.txt``` otherwise the command will not have the desired result (due to the shell expanding the ```*``` wildcard).

You can combine ```find``` and ```wc```:

```
wc -l $(find . -name "*.txt")
```

This command will count the lines in all the files with the suffix ```.txt``` in the current working directory and print all the information. 

### Piping 

A pipe connects two commands together, using the output of one command as the input of the next command. For example:

```ls | grep test```

Takes the list of all file names gathered by ```ls``` and searches them for the term test, outputting the results.

Examples:

```sort -n lengths.txt | head -n 1``` - This sorts the lines in ```lengths.txt``` numerically, then takes the first line of that result (which will be the entry with the smallest value).

```wc -l *.pdb | sort -n | head -n 1``` - This counts the lines of each file in the working directory ending with the ```.pde``` extension, then sorts them in ascending numerical order. The first value is then output (the one at the top of the list given by ```sort -n```). You could say this as 'head of the sort of line count of ```*.pdb```'.

```wc -l * | sort -n | head -n 3```- Find the three files which have the least number of lines. 

### Filtering output

```sort <file>```

Sorts alphanumerically. This does not change the file, it simply sends the sorted result to the screen. To put in a file:

```sort -n lengths.txt > sorted-lengths.txt```

```-n``` - short for ```--numeric-sort```. Sorts by number value. 

We can use head to get the first few lines of the file:

```head -n 3 sorted-lengths.txt``` - returns the first 3 lines of the file. The opposite command is ```tail``` which retrieves the last few lines of a file. 

```cut -d , -f 2 animals.csv``` - The ```cut``` command is used to remove or `cut out` certain sections of each line in the file. In the above example we use the ```-d``` option to specify the comma as our delimiter character, and the ```-f``` option to specify that we want to extract the second field (column).

```uniq <file>``` - The ```uniq``` command filters out **adjacent** matching lines in a file. 

```cut -d , -f 2 animals.csv | sort | uniq``` - Will return only unique animals from the list. To return a count of the number of occurrences of each unique animal, use the ```uniq -c``` command. 

### Redirecting output 

You can redirect the output of a command using '>'. 

```ls > filename``` will create a file that contains the output of the ```ls``` command. 

```>>``` is similar to the previous command but will append to the end of the file. 

```1>``` will output the exit code to a file e.g. 0 for success, anything else if the command fails. 

```2>``` will output only the error messages to the file. 

If you ever want to ignore the output of a command you can redirect it to the void (/dev/null).

*Note: It is a very bad idea to try redirecting the output of a command that operates on a file to the same file. This may give incorrect results and/or delete the contents of ```lengths.txt```*.

Note that this operation (```>```) overwrites the output file if it already exists, whereas ```>>``` simply appends to the file (if it already exists - otherwise, the result is the same).

### Wildcards

```*``` is a **wildcard**, which represents zero or more characters. For example:

```*.png``` represents ```alien.png```, ```bigfoot.png```, etc. Because it can represent no characters, ```*ethane``` would return ```ethane``` and ```methane```. 


```*saur.png``` represents ```Allosaur.png```, ```Stegosaur.png```, ```saur.png``` and so on. 
```?``` is also a wildcard, but represents one wild character specifically. For example:

```?man``` would represent ```Gman``` or ```iman```, whereas ```????saur``` would represent ```dinosaur``` and ```allosaur``` but not ```tyrannosaur```. 



### Permissions

```chmod a+rwx <filename>```

![image](/images/permissions.jpeg)

When you use a command such as ```ls -ltr``` you will see that each file has a string prefix with lots of letters. The first character relates to the nature of the file (d indicating directory) while the rest relates to permissions.

Each 3 character set represents the permissions of the user (the owner of the file), the group (the group the owner is part of) and others (anyone not either the owner or part of the group) in that order (uuugggooo).

'r' indicates read permission, 'w' indicates write permission while 'x' indicates execute permission.

To change permissions, simply use the chmod command e.g. ```chmod u+rw``` (add read and write permissions for the user) or ```chmod o-x``` (remove execution permission from other).

Shorthand can also be used by translating the binary for each string sequence. For example, a permission string of rw- would be translated into binary 110. This, when translated to decimal, would be 6. So to give yourself and your group read and write permissions, and everyone else nothing, use ```chmod 600 <filename>```. 

0: (000) No permission.

1: (001) Execute permission.

2: (010) Write permission.

3: (011) Write and execute permissions.

4: (100) Read permission.

5: (101) Read and execute permissions.

6: (110) Read and write permissions.

7: (111) Read, write, and execute permissions.

### Aliases

```alias <shortcut>="<command>"```

Create a new alias (a shortcut command for a longer expression) e.g. ```alias list="ls -ltr". 


### SSH 

```ssh <address>```

Allows a connection to a remote computer (specified by \<address\>).

### nano

Nano is a basic text editor often available from the command line. 

```nano note.txt``` - Opens an empty text file called "note.txt" in the current working directory. 

"Ctrl+O" - Save the current document (you can change the name if desired).

"Ctrl+X" - Quit the editor and return to the shell. 

### touch

```touch note.txt``` - Creates an empty text file taking up no space. This is useful if a program will not generate a file itself, instead requiring an existing file to populate with its output. 

### Word Count

```wc <file>```

Returns the number of lines, words and characters in files, returning the values in that order from left to right. You can also search multiple files:

```wc *.txt```

Returns the lines, words and characters for each file with the txt extension in the current working directory (in a list). The total number of lines, words and characters will be shown at the bottom of the list. 

```-l``` - Will only show the number of lines per file. 
```-m``` - will only show the number of characters.
```-w``` - will only show the number of words.

```wc``` with or without a flag and no filename will wait for input at the command line. Escape using Ctrl+C. 

To capture the output from these commands:

```wc -l *.txt > lengths.txt``` - Saves the number of lines from each txt file in the directory into a new file called lengths.txt. 

### Loops

Looping is a great way to programmatically cut down on repetitive tasks, such as performing the same action on many files. To loop through three files in our creatures directory and print the second line of each file (along with the filename):

```
for filename in basilisk.dat minotaur.dat unicorn.dat
do 
    echo $filename
    head -n 2 $filename | tail -n 1
done
```

Backup files (creates copies e.g. "original-unicorn.dat").
```
for filename in *.dat
do 
    cp $filename original-$filename
done
```

To check if it's working correctly before running it, use ```echo``` in front of the command to see how it will execute:
```
for filename in *.dat
do 
    echo cp $filename original-$filename
done
```

or

```for datafile in *.pdb
do
    echo "cat $datafile >> all.pdb```
done
```

#### Nested loops

```
for species in cubane methane ethane
do
    for temp in 25 30 37 40
    do
        mkdir $species-$temp
    done
done
```

### History

The ```history``` command retrieves a list of the last few hundred commands that have been executed. You can use ```!123``` (where '123' is replaced by the command number shown by ```history```) to repeat a command. 

You can also search history by using ```Ctrl+R``` and typing the search term. Press ```Ctrl+R``` repeatedly to scroll through earlier hits. Press an arrow key to select a command, and press ```Return``` to run the command).

```history | tail -n 5``` - Returns the last 5 commands run. 
```!459``` - Returns command 459 from the history. 

```!!``` - Retrieves the immediately preceding command. 

```!$``` - Retrieves the last word of the last command. 

You can even save previous commands into a new shell script:

```
history | tail -n 5 > redo-figure.sh
```

Note: Remember that the shell always adds commands to the log *before* running them. This is useful in the event that the command results in a crash, in which case the log can be investigated to determine the cause. 

## Shell Scripts

Shell scripts are just small programs written into a file. 

```sh <script>.sh``` runs the commands saved i a file. 

```$1```, ```$2``` etc refer to the first argument, second argument and so on. ```$@``` refers to all of the shell script's command-line arguments (remember to place variables in quotes if the values might have spaces in them).

To debug shell scripts use the ```-x-``` flag:
```sh -x <script>.sh <arg1> <arg2>```

## UNIX Tips 

* Pressing the up arrow will recall the previous command

* Use the tab key to complete filenames. Pressing tab with no leading character e.g. ```ls ``` will loop through all the file/folder names in the directory. 

* Move to the beginning of a line in the shell using ```Ctrl+A``` or to the end using ```Ctrl+E```. 

* A semicolon ```;``` can be used to separate two commands written on a single line.

* Don't use spaces in filenames. Separate words using ```-``` or ```_```. Don't lead with these characters and don't use any other special characters in filenames, except for ```.```.

* If you need to refer to a file or folder with spaces in the name, use quotes e.g. ```cd "My Folder"```. 

* When editing files ensure you create a backup copy in case something goes wrong e.g. ```cp filename.txt filenamebackup.txt```

* Use the forward slash to refer to the root directory when specifying an absolute directory

* If you want to see the scripts tied to commands, these are stored in the binaries directory (```cd /bin```). This can be useful if you are not sure what is available. 

- If things aren’t working correctly, one of these is likely the culprit:
1. Memory usage
2. Storage usage 
3. CPU usage 

- You will need to change passwords about once a month for many Defence systems. You will not receive a notification - your password will simply stop working. It's a good idea to set a calendar reminder so you can change all your passwords at the same time. The command ```passwd``` - begins the password change process.

- Deleting is forever. The Unix shell doesn't have a trash bin. When files are deleted, they are unlinked from the file system so that their storage space on disk can be recycled. Tools for finding and recovering deleted files do exist, but there's no guarantee they'll work in any particular situation, since the computer may recycle the file's disk space immediately. 

- Try using the ```man <command>``` or ```--help``` (e.g. ```grep --help```) if you need more information. 

### man 

```man```, short for manual, is useful when you want to find out more about a specific command. 

e.g. ```man ls```

You can use the arrow keys to move line-by-line in a man page, or **B** and **Spacebar** to skip up or down a full page. 

To search for a character or word on a ```man``` page, use ```/``` followed by the character or word you are searching for. If the search returns multiple hits, you can move forward through them with ```N``` or backwards with ```Shift+N```. 

To quit ```man```, press ```Q```. 