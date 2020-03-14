#! /usr/bin/env bash

# Install Dependencies
sudo apt update -y
sudo apt-get install -y curl gnupg build-essential
sudo apt install -y ruby-full 
ruby –v

# Install Bundler
sudo gem install bundler

# Download the source code of the application from git repo
sudo git clone https://github.com/rea-cruitment/simple-sinatra-app.git /home/ubuntu/code

# Add Passenger to Gemfile && Build the code
echo 'gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"' | sudo tee -a /home/ubuntu/code/Gemfile
sudo chown -R $(whoami):$(whoami) /home/ubuntu/code/
cd /home/ubuntu/code  && bundle install

# Start Passenger Standalone
cd /home/ubuntu/code  && bundle exec passenger start &
