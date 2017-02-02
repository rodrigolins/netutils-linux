
help:
	@echo "  env         create a development environment using virtualenv"
	@echo "  deps        install dependencies"
	@echo "  clean       remove unwanted stuff"
	@echo "  lint        check style with flake8"
	@echo "  coverage    run tests with code coverage"
	@echo "  test        run tests"

env:
	rm -rf env
	virtualenv env && \
	. env/bin/activate && \
	pip install setuptools --upgrade && \
	python setup.py install

clean:
	rm -fr build
	rm -fr dist
	find . -name '*.pyc' -exec rm -f {} \;
	find . -name '*.pyo' -exec rm -f {} \;
	find . -name '*~' -exec rm -f {} \;

lint:
	flake8 twitter > violations.flake8.txt

coverage:
	nosetests --with-coverage --cover-package=twitter

test: env
	. env/bin/activate && \
		./tests/rss-ladder

build: clean
	python setup.py sdist
	python setup.py bdist_wheel

upload: clean
	python setup.py sdist upload
	# python setup.py bdist_wheel upload