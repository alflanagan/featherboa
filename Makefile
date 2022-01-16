REQUIREMENTS_OUT = 'requirements.txt'

# install fundamental packages
setup:
	python -m pip install --upgrade pip wheel pip-tools setuptools

# generates requirements.txt files from requirements.in files
requirements:
	pip-compile --generate-hashes --allow-unsafe --output-file $(REQUIREMENTS_OUT) requirements-host.in requirements-ide.in

# install all requirements to user's PC
pip-sync:
	pip-sync $(REQUIREMENTS_OUT)

install2board:
	circup

# list tasks in this Makefile. convenience command that should be in 'make' but inexplicably isn't
tasks:
	@grep -e '^[a-zA-Z0-9_-]\+:' Makefile | tr -d ':'
