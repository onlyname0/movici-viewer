level=patch
export level

bump-version:
	bumpversion  --config-file .bumpversion.app $(level)

ui:
	cd client && npm run build
	rm -rf server/movici_viewer/ui/*
	cp -r client/dist/* server/movici_viewer/ui

build: ui

lint:
	cd server && ruff check .

format:
	cd server && ruff format .

test:
	cd server && pytest tests/

coverage:
	cd server && pytest tests/ --cov=movici_viewer --cov-report=term-missing

pre-commit-install:
	cd server && pre-commit install

pre-commit-run:
	cd server && pre-commit run --all-files
	cd server && poetry build

pre-init:
	cd client && npm install
	mkdir -p server/movici_viewer/ui

init: pre-init ui
	cd server && poetry install -E dev

data_dir=tests/data
export data_dir

run-devel:
	cd server \
	&& MOVICI_FLOW_DATA_DIR=$(data_dir) \
	   uvicorn --factory movici_viewer.main:get_app --host localhost --port 5000 --reload

run:
	cd server && poetry run movici-viewer
