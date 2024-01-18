# Compiler2023
a course about compiler in the second half of 2023

## lex
```
sudo apt-get install flex
```
type "y" and press Enter, if ask for confirmation

### Compile lex file (xxx.l)
```
$ flex -o lex.yy.c <lex_file_name>
$ gcc -o <exec_name> lex.yy.c -lfl
```

### Run the lex program
./<exec_name> < input.txt
