PANDOC_FLAGS:= --number-sections --table-of-contents

dist/report.pdf: media meta src
	pandoc $(PANDOC_FLAGS) \
			   -o $@ \
         --bibliography meta/bibliography.bib \
				 $(shell ls src/*.md) \
		     meta/footer.md \
				 meta/metadata.yml

.PHONY: clean

clean:
	rm -f dist/*
