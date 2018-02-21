# Doing reports in Markdown with Pandoc and Make
Andrew Shaw: shawa1@tcd.ie

# Why are you doing this?


| Tool              | Why it is bad                      |
|-------------------|------------------------------------|
| Microsoft Word    | It is proprietary!                 |
| LibreOffice Write | Too slow, and proprietary!         |
| Google Docs       | It is proprietary, _and_ too slow! |
| LaTeX             | Arcane syntax `\oh{dear}[no]`      |


## WYSIWYG is a false prophet

> What you see is what you get

1. Spend more time fiddling than writing
    - Fiddling with font families
    - Tables are a nightmare
    - Where do I put the page breaks?
    - Embedded code blocks
    - Trying to write equations? _*HA!*_

2. The text editors in WYSIWYG tools are abysmal
    - Plugins? `vi` keys?

3. How about _what you write is what you want_?
    - WYWIWYW
      - bonus palindrome 


## We already do this

> See: "Programming languages" "Compilers"

* As a programmer you already do this
* HTML and CSS for the web
* Writing `C` files instead of machine code
    - I am not as good at the compiler as writing optimised machine code
* I am not a typesetter or a designer
    - How hubristic to think I know how to lay out a document


## Why Markdown?

* Non-proprietary is not just a _**lol the FSF**_ joke
    - If the vendor discontinues your WYSIWYG, you can't open your docs
    - If your cloud editor shuts down, you lose your docs!
    - What happens in 30 years when you want to read your docs?


* Lightweight syntax
    - Source code is almost as pleasant to read as the output
    - Anyone can write a compiler for it [^1]
    - _It's just plain text_: never going out of fashion

## Other Features
```c
did someone() {
   say *code = blocks & high : lighting ? "NO PROBLEM!";
}
```

> I thought we were having steamed clams.  
> D'oh, no. I said steamed hams; that's what I call hamburgers!  
> You call hamburgers steamed hams?  
> Yes!  

# Lets Go!

## Step Zero

* The first step is to get the tools installed
  - It actually depends on LaTeX lol

* OSX
    - `brew cask install mactex && brew install pandoc`
* Debian
    - `apt install pandoc`
* Windows
    - I don't know! Submit a PR! :)


# Simple beginnings

* For simple `C` programs, it usually suffices to just run the compiler
    - `gcc -o program program.c other_thing.c`

* Exactly the same for simple documents.
    - `pandoc -o report.pdf report.md`

## Detour: Metadata
* Data about the document, author, date, etc.
* Ready by Pandoc to give you a nice heading
* YAML block put right at the top

    ```yaml
    ---
    author: Andrew Shaw <shawa1@tcd.ie>
    title: Why Haskell is Really Good
    subtitle: Lambda Calculus > Turing Machines
    date: \today
    ...
    ```


## Upgrade!
* We've got our prose written, (and _structured_!)
* Other embellishments are independent of what we've written.
* Lets add numbers to the sections
    - `pandoc --number-sections -o report.pdf report.md`
* Good! How about a table of contents?
    - `pandoc --table-of-contents --number-sections -o report.pdf report.md`
* Even better!


## The Report Evolves
* The report is growing and growing.
* Like we break a program into modules. We break the report into chapters
* _A file for everything, and everything in its file_
    - A file for each chapter, prefixed with the chapter number
* The metadata should go in its own file right?
    - `pandoc --table-of-contents --number-sections -o report.pdf 01-introduction.md 02-maths.md metadata.yml`
* This is getting a bit unwieldy...
    - Good luck remembering that


# `Make`ing our lives easier
* We are adding more chapters and media to our report
    - ``![caption](path/to/image.png)`

## Detour: Dependency graphs
* If we're writing a big program, we end up with dedpendencies
* e.g. a Systems Programming assignment, we may have
  - `main.c`
  - `linked-list.{c,h}`
  - `huffman-tree.{c,h}`

A simple dependency graph would be

```
main.c
  |- `linked-list.{c,h}`
  |
  .- `huffman-tree.{c,h}`
```

* Main depends on both our linked list and our Huffman tree implementation
* If we modify either of those, we have to recompile main.
* BUT: If we _only_ modify `main`, we only have to recompile main!

There is a tool for modeling this, and its name is make.

## Makefiles

* A `Makefile` is a description of your project's dependency graph
* As well as instructions for how to build it
    - What compiler to use, what flags to pass to the compiler
* source files, objects, targets, and dependencies
* Tracks when files change, knows how much (or how little) needs to be recompiled



```makefile
CFLAGS = -std=c99 -Wall
CCOMP = gcc

huff_codec: huff_codec.c
	$(CCOMP) $(CFLAGS) -g -o huff_codec.o huff_codec.c bitfile.c huffman_tree.c

link:
	ln -s huff_codec.o huffcode
	ln -s huff_codec.o huffdecode

test_bitfile: test_bitfile.c
	$(CCOMP) $(CFLAGS) -g -o test_bitfile.o test_bitfile.c

test_bit_array: test_bit_array.c
	$(CCOMP) $(CFLAGS) -g -o test_bit_array.o test_bit_array.c


bitfile.o: bitfile.c
	$(CCOMP) $(CFLAGS) -o bitfile.o bitfile.c

.PHONY: clean

clean:
	rm -rf *.o *.html *.pdf *.dSYM *.bf
```

## Making the Report

* Just like our program, our report has source files
  - the chapters
  - the meta file

* It has objects
  - media (images)

* It has dependencies
  - a chapter might include an image

* Most importantly, it has a target (the PDF!)

```makefile
PANDOC_FLAGS:= --number-sections --table-of-contents

dist/report.pdf: media meta src
	pandoc $(PANDOC_FLAGS) -o $@ $(shell ls src/*.md) meta/metadata.yml

.PHONY: clean

clean:
	rm -f dist/*

```

# Extra bits

## Citations
* Citations are an absolute nightmare in general
* A citation is basically an `href` for the real world
* Pandoc makes this somewhat easy, requires `pandoc-citeproc` installed
* Structure `->` easy to customise

## Bibliography
* You put all of your references in a bibliography file
  - normally in `bibTeX` format
* Tell Pandoc where to find the bibfile
* Reference your citations in the document


## Automatic Change Monitoring
* `when-changed` is a Python tool for watching for filesystem changes and running a command in response
* e.g. Rebuilding your report when you save
* `when-changed -r src meta media -c make`
    - `-r`ecursively watch `src`, `meta`, and `media`
    - and when they change, run the `-c`ommand `make`


## Caveats
### File Extensions
* File paths are relative to _where you run pandoc, not where the file is_
    - in practice, relative to the makefile.

* e.g. if our directory looks like this

    ```
    ├── README.md
    ├── media
    │   └── lobster.png
    ...
    └── src
        ├── 01-introduction.md
        ├── 02-maths.md
        ├── 03-a-diagram.md
        └── 04-Turboencabulators.md
    ```

* Include media in the chapters as `media/file.ext`

* check out org mode

## That is basically it
* This whole thing is on Github at `https://github.com/shawa/netsoc-talk`
* Contact me if you have questions <shawa1@tcd.ie>
    - `shawa1@tcd.ie`, `twitter.com/shawa_a`, `shawa@mastodon.social`
    - open an issue on the github repo!
