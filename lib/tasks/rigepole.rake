# frozen_string_literal: true

require "ridgepole"

namespace :ridgepole do
  task apply: :environment do
    sh("bundle exec ridgepole --apply --env production --file ./db/schemas/Schemafile --config config/database.yml")
  end
end
