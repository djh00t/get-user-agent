# Makefile for user_agent Python package

# Variables
TWINE_USERNAME ?= __token__
TEST_TWINE_PASSWORD ?= $(shell echo $$TEST_PYPI_USER_AGENT)
PYPI_TWINE_PASSWORD ?= $(shell echo $$PYPI_USER_AGENT)

# Targets

## clean: Remove build artifacts
clean:
	rm -rf build/ dist/ *.egg-info/

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

.PHONY: clean sdist wheel upload-test upload install uninstall
