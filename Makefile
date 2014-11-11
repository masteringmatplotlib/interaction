VENV=../.venv-mmpl
PYTHON=python3.4
IPYTHON=ipython3
SYSTEM_PYTHON=$(shell which $(PYTHON))
SOURCE=./lib
MYPY=$(VENV)/bin/mypy

virtual-env:
	$(SYSTEM_PYTHON) -m venv $(VENV)

$(MYPY):
	git clone https://github.com/JukkaL/mypy.git
	. $(VENV)/bin/activate && \
	cd mypy && $(PYTHON) setup.py install
	rm -rf mypy

deps:
	. $(VENV)/bin/activate && \
	pip3.4 install -r requirements.txt

setup: virtual-env deps
	. $(VENV)/bin/activate

run:
	. $(VENV)/bin/activate && \
	$(IPYTHON) notebook notebooks/mmpl-arch.ipynb

clean:
	rm -rf $(VENV)

repl:
	. $(VENV)/bin/activate && $(IPYTHON)

flakes:
	@echo "\nChecking for flakes ...\n"
	flake8 $(SOURCE)

types: $(MYPY)
	@echo "\nChecking types ...\n"
	for FILE in ./lib/*.py; do mypy $$FILE; done

check: flakes types
