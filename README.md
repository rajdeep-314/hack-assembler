# An assembler for HACK using OCaml

An assembler for the Hack ASM language (part of [nand2tetris](https://nand2tetris.org)), programmed in OCaml.

## Polymorphism

You will notice that the types defined in `lib/ast.ml` are polymorphic. For example, the `inst` type is instantiated by another type, which is meant to represent virtual addresses. It is not hard-coded in the type that the address used in instructions be an integer, or a natural number. It can be any type!

This is extremely useful, considering that this project is meant to be used for the JackVM to assembly translation, and for the Jack compiler.

In those scenarios, it might be of interest to us to have addresses represented by, say, a sequence of identifiers. For example, a method `bar` of some class `foo` might correspond to an address that we can represent by a type that stores a list of such identifiers. So, not having restrictions on these types and making them polymorphic enables ease of maintenance and scaling.


# File info

## Modules

### ast.ml

- Contains algebraic types to represent the abstract syntax of Hack ASM and functions to operate on values of these types.
- The `Helper` sub-module provides helper function for ease of construction of values of the types.
- `Helper` was used extensively in the [JackVM project](https://github.com/rajdeep-314/jackvm). See [lib/backend/hack/subroutines.ml](https://github.com/rajdeep-314/jackvm/blob/main/lib/backend/hack/subroutines.ml) for an example.

### encode.ml

- This module is the main translation unit. It translates Hack ASM's abstract syntax to machine instructions, as per the specifications.
- The machine instructions are represented quite directly - as 16-character binary strings.
- Some implementation-specific functions based on the JackVM translator's implementation are also present.

### parser.ml

- A basic parser to parse Hack ASM code.
- The parser returns values of the types in `ast.ml`.
- Working with AST rather than strings makes the entire program more rigorous and type-safe.


## Top-level

### main.ml

- This is the main, top-level file that is executed.
- It takes input from stdin, till EOF is encountered.
- Once EOF is encountered, it parses the code, translates it to machine instructions and prints out each instruction as a 16-character binary string, one in each line.


## Test cases

The `test-snippets` directory contains two `.asm` files to test the assembler. `pong.asm` is from the nand2tetris website.



# How to use?

Make sure that you have [Dune](https://dune.build/install), a build-system for OCaml, installed.

Once that is done, simply go to the project repository and execute

```bash
dune exec assembler
```

You can start typing the machine instructions in the shell after that. Once you are done, hit `<Ctrl-D>` to pass EOF and finish passing the input. The assembler will perform the translation and print the machine instructions to `stdout` after that.

However, this isn't very convenient, so I recommend using Linux's input and output redirection. Two `.asm` files for testing are present in the `test-snippets` directory. You can type something like this in the shell

```bash
dune exec assembler < test-snippets/test.asm > out_test.bin
```

which will make the assembler read input from `test-snippets/test.asm` and will redirect the translated binary instructions to `out_test.bin`.



