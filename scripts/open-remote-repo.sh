#!/bin/bash
cd $(tmux run "echo #{pane_start_path}")
url=$(git remote get-url origin)

if [[ $url == *github.com* ]]; then
  if [[ $url == git@* ]]; then
    url="${url#git@}"
    url="${url/://}"
    url="https://$url"
  fi
  
  open "$url"
else
  echo "Repo isn't hosted with github...extend your script!"
fi
