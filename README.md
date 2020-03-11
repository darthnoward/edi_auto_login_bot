# Edimension auto login bot
A script that can save a lot of time by automatically logging users into the school resource page https://Edimension.sutd.edu.sg

## Prerequisite
- chromedriver installed in /usr/local/bin (Download from https://chromedriver.chromium.org)
- Python and selenium library installed 
- create a file named myinfo.py in the same directory as main.py and put in your username and password, like
```
username = "SUTDSTU\\1000000"
password = "woah_haolan_is_so_cute_lol"
# Change the values to your own
```
- change the environment path in the first line to you own, you can look it up by 
```
$ which python3
```
- make the script executable, by 
```
$ chmod +x main.py 
```

### Nice to have:
create an alias in your favourite shell config, in my case, in ~/.zshrc:
```
alias edi=~/edi/main.py
```
so that you can run it more conveniently. 

Note: create a symbolic link to /usr/local/bin isn't effective as it takes value from myinfo.py 

## Usage 
In your terminal:
```
main.py                             login to the main page
main.py math
main.py maths
main.py ma                          login, go to content section of math module
``` 
**Note: The raw script only applys to the four modules of class 2022 Term 3 in SUTD**  

## DEMO 
![gif1](./assets/gif1.gif)
![gif2](./assets/gif2.gif)

*Sweet*


