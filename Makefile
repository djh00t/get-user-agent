# Makefile for get_user_agent_pls Python package

# Variables
TWINE_USERNAME ?= __token__
TEST_TWINE_PASSWORD ?= $(TEST_PYPI_USER_AGENT)
PYPI_TWINE_PASSWORD ?= $(PYPI_USER_AGENT)

# Targets

## clean: Remove build artifacts
clean:
	rm -rf build/ dist/ *.egg-info/

## check-packages: Check for required pip packages and requirements.txt, install if missing
check-packages:
	@echo "Checking for required pip packages and requirements.txt..."
	@if [ ! -f requirements.txt ]; then \
		echo "requirements.txt not found. Please add it to the project root."; \
		exit 1; \
	fi
	@echo "Installing missing packages from requirements.txt..."
	@pip install -r requirements.txt
	@echo "Installing twine and wheel..."
	@pip install twine wheel

## sdist: Create a source distribution package
sdist: clean
	python setup.py sdist

## wheel: Create a wheel distribution package
wheel: clean
	python setup.py sdist bdist_wheel

## upload-test: Update version number, echo it to console and upload the distribution package to TestPyPI
upload-test: update-version wheel
	@echo "Uploading Version $NEW_VERSION to TestPyPI..."
	twine upload --repository-url https://test.pypi.org/legacy/ --username $(TWINE_USERNAME) --password $(TEST_TWINE_PASSWORD) dist/*

## upload: Update version number and upload the distribution package to PyPI
upload: update-version wheel
	@echo "Uploading Version $NEW_VERSION to PyPI..."
	twine upload --username $(TWINE_USERNAME) --password $(PYPI_TWINE_PASSWORD) dist/*

## install: Install the package locally
install:
	pip install -e .

## uninstall: Uninstall the local package
uninstall:
	pip uninstall get-user-agent

## test: Run the unit tests
test: check-packages
	python -m unittest discover

## update-version: Read the version number from VERSION file, increment the last digit, update the VERSION file, and echo it
update-version:
	$(eval NEW_VERSION=$(shell echo $$(($(cat VERSION | rev | cut -d. -f1 | rev)+1))))
	echo "$(NEW_VERSION)" > VERSION
	@echo "Version updated to $(NEW_VERSION)"

.PHONY: clean check-packages sdist wheel upload-test upload install uninstall test update-version

# Check if conda or miniconda is installed, if not install miniconda
check-conda:
	@command -v conda >/dev/null 2>&1 || { \
		echo "Conda is not installed. Installing Miniconda..."; \
		wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh; \
		bash ~/miniconda.sh -b -p $$HOME/miniconda; \
		eval "$$($$HOME/miniconda/bin/conda shell.bash hook)"; \
		conda init; \
	}

# Create a new conda environment
create-env: check-conda
	conda create --name $(CONDA_ENV_NAME) python=3.8 --yes
	@echo "To activate environment, use: conda activate $(CONDA_ENV_NAME)"
