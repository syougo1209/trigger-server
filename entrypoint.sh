#!/bin/bash

cd /app
bin/setup
echo "finished setup"
echo "migration"
bundle exec pumactl start
