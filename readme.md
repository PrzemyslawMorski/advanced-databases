# ReadMe

This repo is the workplace of the Advanced Databases course that's taught in polish. over at Wrocław's University of Technology university Information technology major and Software development specialty.

The courses revolves around database-related knowledge.

Stage 1 - defining the data model
Stage 2 - creating a test environment

# Test environment for an Oracle Standard edition 2 ver. 12.1.0.2

## Content:

- **docker-compose.yml** - docker containers configuration

## Requirements:

- Docker
- docker-compose
- You need to have an account in the oracle docker image registry and docker login container-registry.oracle.com

## Usage instructions:

- **First run:**  
  docker-compose up -d
- **Run sql commands using the oracle_client container:**  
  docker exec -ti oracle_client sqlplus usr/pwd@pdb
- **Shutting down:**  
  docker-compose stop
- **Subsequent runs:**  
  docker-compose start
- **Restarting the configuration:**  
  docker-compose restart
- **Deleting the configuration**  
  docker-compose down -v
