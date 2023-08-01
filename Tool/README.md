
# Code Example 

``` bash
install() {
   wget https://gh05t-hunter5.github.io/mypass/mypass
   sudo mv mypass /usr/bin/
   sudo chmod +x /usr/bin/mypass
}


if [[ $(command -v mypass) ]]; then
  echo ""
else
  install
  clear
fi

figlet banner
echo "01) auto pass"
echo "02) manual pass"
# Example Usage 
read -p "Select : " option
# add more options 
if [ $option = "01" ]; then
  mypass -m 8 100 password.txt
elif [ $option = "02" ]; then
  mypass manual 100 password.txt
fi

```

## Command 

Usage: mypass [options]

Options:
Auto
-l, --letter           password type (letter)
-n, --number           password type (number)
-m, --mix              password type (mixed password)
Use : mypass option 8 1000 filename
option  : -l, --letter, -n, --number , -m, --mix
8       : password length
1000    : password lines
filename: filename(password file name)
example
$ mypass -n 8 1000 password.txt
Manual
-manual, --manual, manual: create yourself (useful)
Use : mypass option 1000 filename
option  : -manual , --manual , manual
1000    : password length
filename: filename(password file name)
example
$ mypass manual 1000 password.txt
Or
Just Type : mypass


## Create your own password generator

<small>collaborate</small>

Contact  :  <a href="mailto: gh05thunter5@proton.me">Send Email</a>

Telegram Channel  :  <a href="https://t.me/GH05T_HUNTER5">GH05T HUNTER5</a>
