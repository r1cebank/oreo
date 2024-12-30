if status is-interactive
    # Commands to run in interactive sessions can go here
end
eval "$(/opt/homebrew/bin/brew shellenv)"

direnv hook fish | source
atuin init fish --disable-up-arrow | source
starship init fish | source
kubectl completion fish | source
