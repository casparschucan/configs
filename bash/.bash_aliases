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

# alias for unibe vpn (FortiGate SSL VPN with Microsoft SSO). openfortivpn
# listens on :8020 for the SAML redirect but doesn't open the browser itself.
alias unibevpn='(xdg-open "https://univpn.unibe.ch/remote/saml/start?redirect=1" &>/dev/null &); sudo openfortivpn univpn.unibe.ch --saml-login'
