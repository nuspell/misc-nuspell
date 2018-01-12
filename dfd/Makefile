SOURCES=$(wildcard *.flow)
DFD_TARGETS=$(SOURCES:%.flow=%.svg)

DATAFLOW=~/.cabal/bin/dataflow
K := $(if $(shell which $(DATAFLOW)),,$(error "No dataflow installed. See https://github.com/sonyxperiadev/dataflow for install instructions)))"))

.PHONY: all dfd clean

all: dfd README.md

dfd: $(DFD_TARGETS)

%.svg: %.flow
	@$(DATAFLOW) dfd $< | dot -Tsvg > $@

.ONESHELL:
README.md: $(DFD_TARGETS) Makefile
	echo "# DFD" > $@
	echo "" >> $@
	for x in $(DFD_TARGETS); do
		echo "## $$x" >> $@
		echo "" >> $@
		echo "![$$x]($$x)" >> $@
	done

clean:
	@rm -f $(DFD_TARGETS)
