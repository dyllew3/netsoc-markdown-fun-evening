PANDOC_FLAGS:= --number-sections --table-of-contents

dist/report.pdf: media meta src
	pandoc $(PANDOC_FLAGS) -o $@ $(shell ls src/*.md) meta/metadata.yml

.PHONY: clean

clean:
	rm -f dist/*
