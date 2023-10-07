#!/usr/bin/bash

# Set the repository URL
repo_url=git@github.com:Peiyang-Aeromodelling-Association/documentation-deploy.git

# Set the local destination for the repository
local_destination=~/documentation-deploy

# Clone the repository if it doesn't already exist
if [ ! -d "$local_destination" ]; then
  git clone --recursive $repo_url $local_destination
fi

# Navigate to the local repository directory
cd $local_destination

git pull --recurse-submodules
git submodule foreach git pull --force origin gh-pages:gh-pages
