.PHONY: migrate
migrate: ## down
	docker-compose exec api bundle exec ridgepole --apply --file ./db/schemas/Schemafile --config config/database.yml
