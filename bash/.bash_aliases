alias cp="cp -i"                          # confirm before overwriting something
#alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'
alias more=less

alias cm='git commit -m'
alias ca='git commit --amend --no-edit'
alias gs='git status'
alias gp='git push'
alias ga='git add'
alias gpl='git pull'
alias gc='git checkout'
alias gfo='git fetch origin'

alias makefile-targets='grep "^[^#[:space:]].*:" Makefile'

# alias for file launcher
alias xo='xdg-open'

# alias for eth vpn
alias ethvpn='sudo openconnect -u cschucan@student-net.ethz.ch --useragent=AnyConnect -g student-net --no-external-auth sslvpn.ethz.ch'
