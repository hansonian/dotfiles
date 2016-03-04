# force tmux to assume the terminal supports 256 colours
alias tmux='tmux -2'

# some makepasswd shortcuts
alias mpwd='makepasswd --string "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890?<>\!@#$%^&*(){}[]\`;:_+|~=- \"" --chars 14 --count 10'
alias bigpwd='makepasswd --string "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890?<>\!@#$%^&*;:_+|~=-" --chars 14 --count 10'
alias mtpwd='makepasswd --string "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#^&*()+_,.{}?-" --chars 14 --count 10'
alias nicepwd='makepasswd --string "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_-@." --chars 8 --count 10'
alias meanpwd='makepasswd --string "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_-@." --chars 12 --count 10'

# password management
alias pwds='vim -x ~/pwds.txt'

#alias bm='bashmount'

# grep with color
alias grep='grep --color=always'

# diceware shortcut options
alias dice6='diceware -w beale -n 6 -d " "'
alias dice8='diceware -w beale -n 8 -d " "'

# wordpress keys for wp-config.php
alias wpkey='wget -q -O - https://api.wordpress.org/secret-key/1.1/salt/'
