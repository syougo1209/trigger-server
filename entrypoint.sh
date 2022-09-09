#!/bin/bash

cd /app
bin/setup
echo "finished setup"
echo "migration"
bundle exec ridgepole --apply --file ./db/schemas/Schemafile --config config/database.yml
bundle exec rails db:seed
bundle exec pumactl start
