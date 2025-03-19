export PYTHONPATH=$(shell pwd)/src/

.PHONY=help

help:  ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

django-admin:  ## Like django-admin.py
	uv run python main.py $(args)

dependencies:  ## Install dependencies
	uv sync --frozen

update-dependencies:  ## Update dependencies
	uv sync -U

outdated:  ## Check outdated dependencies
	uv pip list --outdated

test:  ## Run tests
	uv run pytest

lint: ## Lint code
	uv run ruff check .
	uv run ruff format --check .

lint-fix: ## Fix linting errors
	uv ruff check --fix --unsafe-fixes .
	uv ruff format .

run-local:  ## Run django local server
	uv run python src/main.py runserver

run-async:  ## Run server async with granian
	uv run granian main:asgi_application --interface asgi

run-sync:  ## Run server sync with granian
	uv run granian main:wsgi_application --interface wsgi
