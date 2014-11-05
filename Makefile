VENV=.venv
PYTHON=$(shell which python3.4)

virtual-env:
	$(PYTHON) -m venv $(VENV)

pygraphviz:
	git clone https://github.com/pygraphviz/pygraphviz
	. $(VENV)/bin/activate && \
	cd pygraphviz && \
	git checkout 6c0876c9bb158452f1193d562531d258e9193f2e && \
	git apply ../patches/graphviz-includes.diff && \
	python setup.py install


deps: pygraphviz
	. $(VENV)/bin/activate && \
	pip3.4 install -r requirements.txt

setup: virtual-env deps

run:
	. $(VENV)/bin/activate && \
	ipython notebook notebooks/mmpl-preview.ipynb

clean:
	rm -rf $(VENV)

# Use the following make target like so:
#
#   $ SCRIPT=./my-script.py LAYOUT=twopi MODE=simple make modgraph
modgraph:
	python third-party/modgraph.py $(SCRIPT) $(LAYOUT) $(MODE) && \
	open modgraph.png
