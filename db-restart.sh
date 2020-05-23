docker-compose -f docker-compose.migrator.yml run migrator
docker-compose -f docker-compose.migrator.yml run geographer
docker-compose -f docker-compose.migrator.yml run geography-linker
