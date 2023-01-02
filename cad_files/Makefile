.PHONY: format install tasks targets

install:
	npm i -g openscad-format

format:
	openscad-format -c .openscad-format -f -i *.scad

# list tasks in this Makefile. convenience command that should be in 'make' but inexplicably isn't
tasks:
	@grep -oe '^[a-zA-Z0-9_-]\+:' Makefile | tr -d ':' | grep -v tasks | grep -v targets

# better name for "tasks"
targets: tasks
