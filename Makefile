.PHONY: all docker pdf clean examples

all: build

build: docker

docker:
	docker build -t mingc/latex .

examples:
	mkdir -p build
	./dockerlatex.sh pdflatex -output-directory=build examples/book-template-1.tex

clean:
	rm -f *.{out,log,aux,lot,lof,toc} build/*.{out,log,aux,lot,lof,toc}
