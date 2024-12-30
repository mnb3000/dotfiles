eza_params_no_git=('--icons' '--time-style=iso' '--color=always' '--group-directories-first')
eza_params=('--git' $eza_params_no_git)

alias l="eza -lahb --no-user --no-permissions $eza_params"
alias ll="eza -labhmU -s name --git-repos $eza_params"
alias la="eza -labhm -s name $eza_params"
alias lag="eza -labhm -s name $eza_params_no_git"
alias lt="eza -laThb --level 3 --no-user --no-permissions --git-ignore $eza_params"
