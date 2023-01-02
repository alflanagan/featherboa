REQUIREMENTS_OUT = 'requirements.txt'

PIP_COMPILE = pip-compile --generate-hashes --allow-unsafe --output-file $(REQUIREMENTS_OUT) --resolver=backtracking

# install fundamental packages
setup:
	python -m pip install --upgrade pip wheel pip-tools setuptools

# generates requirements.txt files from requirements.in files
requirements:
	$(PIP_COMPILE) requirements-host.in requirements-ide.in

# install all requirements to user's PC
pip-sync:
	pip-sync $(REQUIREMENTS_OUT)

install2board:
	circup

# list tasks in this Makefile. convenience command that should be in 'make' but inexplicably isn't
tasks:
	@grep -oe '^[a-zA-Z0-9_-]\+:' Makefile | tr -d ':' | grep -v tasks | grep -v targets

# better name for "tasks"
targets: tasks
