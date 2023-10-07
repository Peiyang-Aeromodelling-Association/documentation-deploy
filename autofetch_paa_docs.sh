#!/usr/bin/bash

# read key_dir from 1st argument
key_dir=$1

# function load_key: load ssh key from key_dir via repo name, return content of the key
function load_key {
  key_name=$1
  key_path=$key_dir/$key_name
  if [ -f "$key_path" ]; then
    cat $key_path
  else
    echo "Key $key_name not found in $key_dir"
    exit 1
  fi
}

# Set the repository URL
repo_url=git@github.com:Peiyang-Aeromodelling-Association/documentation-deploy.git

# Set the local destination for the repository
local_destination=~/documentation-deploy

# Clone the repository if it doesn't already exist
if [ ! -d "$local_destination" ]; then
  GIT_SSH_COMMAND="ssh -i $(load_key documentation-deploy)" git clone $repo_url $local_destination
fi

# Navigate to the local repository directory
cd $local_destination

# git pull documentation-deploy
GIT_SSH_COMMAND="ssh -i $(load_key documentation-deploy)" git pull origin main:main

function pull_submodule {
  submodule_name=$1
  submodule_path=$local_destination/$submodule_name
  if [ -d "$submodule_path" ]; then
    echo "Pulling $submodule_name"
    GIT_SSH_COMMAND="ssh -i $(load_key $submodule_name)" git pull origin gh-pages:gh-pages
  else
    echo "Submodule $submodule_name not found in $local_destination"
    exit 1
  fi
}

# list all submodules, for each submodule, set ssh key and pull, ssh key is the repo name
submodule_names=$(git submodule | awk '{print $2}')
for submodule_name in $submodule_names; do
  pull_submodule $submodule_name
done