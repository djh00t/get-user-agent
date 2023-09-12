# Makefile for user_agent Python package

# Variables
TWINE_USERNAME ?= __token__
ifeq ($(GITHUB_ACTIONS),true)
TEST_TWINE_PASSWORD ?= ${{ secrets.TEST_PYPI_USER_AGENT }}
PYPI_TWINE_PASSWORD ?= ${{ secrets.PYPI_USER_AGENT }}
else
TEST_TWINE_PASSWORD ?= $(shell echo $$TEST_PYPI_USER_AGENT)
PYPI_TWINE_PASSWORD ?= $(shell echo $$PYPI_USER_AGENT)
endif

# Targets

## clean: Remove build artifacts
clean:
	rm -rf build/ dist/ *.egg-info/

## check-packages: Check for required pip packages and requirements.txt
check-packages:
	@echo "Checking for required pip packages and requirements.txt..."
	@if [ ! -f requirements.txt ]; then \
		echo "requirements.txt not found. Please add it to the project root."; \
		exit 1; \
	fi
	@python -c "\
	try:\
		import twine, wheel;\
	except ImportError:\
		print('Required packages are not installed. Please run pip install twine wheel.');\
		exit(1);\
	"

## sdist: Create a source distribution package
sdist: clean
	python setup.py sdist

## wheel: Create a wheel distribution package
wheel: clean
	python setup.py sdist bdist_wheel

## upload-test: Upload the distribution package to TestPyPI
upload-test: wheel
	twine upload --repository testpypi --username $(TWINE_USERNAME) --password $(TEST_TWINE_PASSWORD) dist/*

## upload: Upload the distribution package to PyPI
upload: wheel
	twine upload --username $(TWINE_USERNAME) --password $(PYPI_TWINE_PASSWORD) dist/*

## install: Install the package locally
install:
	pip install -e .

## uninstall: Uninstall the local package
uninstall:
	pip uninstall user_agent

## test: Run the unit tests
test: check-packages
	python -m unittest discover

## update-version: Update the version number in setup.py
update-version:
	sed -i 's/^    version=".*",/    version="$(NEW_VERSION)",/' setup.py

.PHONY: clean check-packages sdist wheel upload-test upload install uninstall test update-version
