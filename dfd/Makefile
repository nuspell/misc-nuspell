SOURCES=$(wildcard *.flow)
DFD_TARGETS=$(SOURCES:%.flow=%.dfd.svg)
SEQ_TARGETS=$(SOURCES:%.flow=%.seq.svg)

DATAFLOW=~/.cabal/bin/dataflow
K := $(if $(shell which $(DATAFLOW)),,$(error "No dataflow installed. See https://github.com/SonyMobile/dataflow for install instructions)))"))

.PHONY: all dfd seq clean

all: dfd seq

dfd: $(DFD_TARGETS)

seq: $(SEQ_TARGETS)

%.dfd.svg: %.flow
	@$(DATAFLOW) dfd $< | dot -Tsvg > $@

%.seq.svg: %.flow
	@$(DATAFLOW) seq $< | plantuml -tsvg -pipe > $@

clean:
	@rm -f $(DFD_TARGETS) $(SEQ_TARGETS)
