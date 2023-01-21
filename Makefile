REQUIREMENTS_OUT = 'requirements.txt'

PIP_COMPILE = pip-compile --generate-hashes --allow-unsafe --output-file $(REQUIREMENTS_OUT) --resolver=backtracking

# install fundamental packages
setup:
	python -m pip install --upgrade pip wheel pip-tools setuptools

requirements.txt: requirements-ide.in requirements-host.in
	$(PIP_COMPILE) $^

upgrade-requirements:
	$(PIP_COMPILE) --upgrade requirements-ide.in requirements-host.in

# install all requirements to user's PC
pip-sync:
	pip-sync $(REQUIREMENTS_OUT)

lint:
	flake8 .

install2board:
	circup

# list targets in this Makefile. convenience command that should be in 'make' but inexplicably isn't
targets:
	@grep -E -oe '^[a-zA-Z.0-9_-]+:' Makefile | tr -d ':'
