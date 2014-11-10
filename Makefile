VENV=.venv
PYTHON=python3.4
IPYTHON=ipython3
SYSTEM_PYTHON=$(shell which $(PYTHON))
SOURCE=./lib
MYPY=$(VENV)/bin/mypy

virtual-env:
	$(SYSTEM_PYTHON) -m venv $(VENV)

pygraphviz:
	@git clone https://github.com/pygraphviz/pygraphviz
	@. $(VENV)/bin/activate && \
	cd pygraphviz && \
	git checkout 6c0876c9bb158452f1193d562531d258e9193f2e && \
	git apply ../patches/graphviz-includes.diff && \
	python setup.py install
	@rm -rf pygraphviz


$(MYPY):
	git clone https://github.com/JukkaL/mypy.git
	. $(VENV)/bin/activate && \
	cd mypy && $(PYTHON) setup.py install
	rm -rf mypy

deps: pygraphviz
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
	flake8 $(SOURCE)

types: $(MYPY)
	for FILE in ./lib/*.py; do mypy $$FILE; done

check: flakes types
