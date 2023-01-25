#!/bin/bash

#@-- help command to show usage of make commands --@#

SHELL := /bin/bash
SHELLFLAGS := -c
activate := env/bin/activate
help:
	@echo "----------------------------------------------------------------------------"
	@echo "-                     Available commands                                   -"
	@echo "----------------------------------------------------------------------------"
	@echo "---> make env                 - To create virtual environment"
	@echo "---> make install             - To install dependencies from poetry.lock"
	@echo "---> make start-kafka	     - To start kafka"
	@echo "---> make create-kafka-topics - To create kafka topics"
	@echo "---> make delete-kafka-topics - To delete kafka topics"
	@echo "---> make help                - To show usage commands"
	@echo "----------------------------------------------------------------------------"



env:
	@ echo '<<<<<<<<<<Creating virtual environment>>>>>>>>>'
	poetry env use python3.10 && poetry shell
	@ echo ''


install:
	@ echo '<<<<<<<<<<installing requirements>>>>>>>>>'
	poetry install
	@ echo ''

start-kafka:
	@ echo '<<<<<<<<<<starting kafka>>>>>>>>>'
	docker-compose up -d zookeeper kafka
	@ echo ''


create-kafka-topics:
	@ echo '<<<<<<<<<<creating kafka topics>>>>>>>>>'
	docker-compose exec kafka kafka-topics --if-not-exists --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 3 --topic test
	@ echo ''

delete-kafka-topics:
	@ echo '<<<<<<<<<<deleting kafka topics>>>>>>>>>'
	docker-compose exec kafka kafka-topics --if-exists --delete --bootstrap-server localhost:9092 --topic test
	@ echo ''



default: help