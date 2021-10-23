requirements:
	pip-compile --generate-hashes --allow-unsafe requirements.in
	pip-compile --generate-hashes --allow-unsafe requirements-ide.in

pip-sync:
	pip-sync requirements.txt requirements-ide.txt

tasks:
	grep -e '^[a-zA-Z0-9_-]\+:' Makefile | tr -d ':'
