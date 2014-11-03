VENV=.venv
PYTHON=$(shell which python3.4)

virtual-env:
	$(PYTHON) -m venv $(VENV)

deps:
	. $(VENV)/bin/activate && \
	pip3.4 install -r requirements.txt

setup: virtual-env deps

run:
	. $(VENV)/bin/activate && \
	ipython notebook notebooks/mmpl-preview.ipynb

clean:
	rm -rf $(VENV)
