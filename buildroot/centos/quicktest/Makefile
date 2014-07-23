.PHONY: all clean install build
all: build doc

NAME=quicktest
J=4

export OCAMLRUNPARAM=b

setup.bin: setup.ml
	@ocamlopt.opt -o $@ $< || ocamlopt -o $@ $< || ocamlc -o $@ $<
	@rm -f setup.cmx setup.cmi setup.o setup.cmo

setup.data: setup.bin
	@./setup.bin -configure

build: setup.data setup.bin
	@./setup.bin -build -j $(J)

doc: setup.data setup.bin
	@./setup.bin -doc -j $(J)

install: setup.bin
	echo "install is manual"

reinstall: setup.bin
	echo "reinstall is manual"

clean:
	@ocamlbuild -clean
	@rm -f setup.data setup.log setup.bin
