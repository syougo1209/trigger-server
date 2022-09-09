#!/bin/bash

cd /app
bin/setup
echo "finished setup"
bundle exec pumactl start
