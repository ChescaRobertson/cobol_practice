# GnuCOBOL Starter

A starter template to get you up and running with a COBOL project. It includes
the unit test framework [GCBLUnit](https://github.com/OlegKunitsyn/gcblunit)
and a few utilities to help you get running.

Tested on Mac only.

## Quickstart

Install the prerequisites:

* [Git](https://git-scm.com/)
* [GNUCobol](https://gnucobol.sourceforge.io/)

If you're on a mac and have brew you can do this:

```bash
; brew install gnu-cobol
```

And then to set up a new project:

```bash
; mkdir your-project-name
; cd your-project-name
; git clone git@github.com:makersacademy/gnucobol-starter.git .
; ./cbl setup
```

And you're good to go!

## Usage

```bash
; ./cbl help
Cobol Runner v0.1

Usage:

  * ./cbl test  # to run unit & environment comparison tests
  * ./cbl run   # to run main-program.cbl
  * ./cbl setup # to set up this project
  * ./cbl help  # show this message
```

## Environment Comparison Tests

The `env/` directory is to facilitate running your COBOL tests in a controlled
directory and then asserting on the contents of that directory afterwards.

You might use this to test a program in which you read from and then wrote to 
some files.

To see this in action, change the contents of 
`env/test/expected/WHAT_IS_THIS.md` and then run `./cbl test` to see the
failure.

There is also a `main` env, in which your `main-program` will be run. You
can store necessary data files in there.

## The Rules

* Tests go in `test/`.
* Code goes in `src/`.
* Name your files the same as the `PROGRAM-ID`. So if your `PROGRAM-ID` is
  "wonderful-nice-thing" then your file should be called
  "wonderful-nice-thing.cbl".
* Same with the test files. I suggest "test-wonderful-nice-thing.cbl".

Break any of these rules and the scripts might also break.
