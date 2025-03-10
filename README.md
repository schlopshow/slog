# Terminal-logger

I made this script to help with logging my terminal commands and output. It takes in input from the user for current or home directory then logs that terminal until the user press [CTRL] + [C]. Outputting to either the current directory or home directory of the user depending on your inital choice.

If you want to view the full terminal output even when you use commands like clear then you have to sed out those parts from the file. here is a quick command to help you cat out the file even if you cleared it previously. This also works with tmux log files.


```shell
 sed 's/\x1b\[[0-9;]*[a-zA-Z]//g' terminal.log
```
If you changed the name of the log file you will have to change "terminal.log" to whatever you named it. You can also simply use the less command on the log file and that will view it properly as well. But a simple cat will not output correctly 100% of the time.
