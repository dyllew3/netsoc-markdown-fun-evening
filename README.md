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
