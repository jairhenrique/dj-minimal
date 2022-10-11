export PYTHONPATH=$(shell pwd)/src/

.PHONY=help

help:  ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

django-admin:  ## Like django-admin.py
	python main.py $(args)

test:  ## Run tests
	pytest

lint: ## Lint code
	flake8 --show-source --statistics .
	isort --check-only --diff .
	black --check --diff .

lint-fix: ## Fix linting errors
	black .
	isort .

run-local:  ## Run django local server
	python src/main.py runserver

run-async:  ## Run server async with gunicorn
	gunicorn main:asgi_application -b  0.0.0.0:8000 -k uvicorn.workers.UvicornWorker -w 4

run-sync:  ## Run server sync with gunicorn
	gunicorn main:wsgi_application -b 0.0.0.0:8000 -w 4
