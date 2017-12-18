SOURCES=$(wildcard *.flow)
DFD_TARGETS=$(SOURCES:%.flow=%.dfd.svg)

DATAFLOW=~/.cabal/bin/dataflow
K := $(if $(shell which $(DATAFLOW)),,$(error "No dataflow installed. See https://github.com/sonyxperiadev/dataflow for install instructions)))"))

.PHONY: all dfd seq clean

all: dfd

dfd: $(DFD_TARGETS)

%.dfd.svg: %.flow
	@$(DATAFLOW) dfd $< | dot -Tsvg > $@

clean:
	@rm -f $(DFD_TARGETS) 
