

# LSP
- For every LSP action have a fallback so that you still do something if the
  lsp fails.
- Add a way to choose to get your lsp information in a hover window, a popup
  window, in a split or jumping to the requested information
- Make lsp responses that appear on the same line just take you to that line
  instead of showing you a quickfix menu with two options that bring to the
  same line - its annoying
## Bash
- Hook into <C-k> man pages to open them in a vertical split instead of
  horizontal
## Hover
- Have a way to show type definitions in a hover menu instead of having to jump
  or atleast have the option between the two
- Learn how to customize the appearance of hover menu
### C
- Have the hover menu print the man page for the function if available
## References
- Add feauture for goto next/prev reference
- if no references are seen by the lsp, fallback to just grepping the codebase
  for the exact string of the vairable.

# Omnifunc
- Learn omnifunc

# CMP
- Learn how to customize the appearance of completion menu

# Snippets
- Creating custom snippets and getting snippet keybindings working

# Debugging
## Menu
- Add a menu for selecting your executable file and args
- Have the menu have memory from the previous run
- Have the menu also find executable files for you to choose from
- the menu could also provide an option to build maybe

# Terminal
- Add ctrl-l to terminal mode so that clearing doesnt acutallt clear the buffer
  but just scrolls up
- Make it so that you can get lsp completion from the command line insert mode.
- Make the terminal buffer a double buffer, one that you can modify and one
  that is the acutal immutable output of the terminal. This makes it so that
  you can edit anywhere like editing a file path to then `gf` to. Or just
  properly edit your command line input.
- Add commands to open a terminal split or a vertical terminal split

# Modes
- Look into nvim-libmodal
- See if you could have a debug mode so that you don't need to prefix gdb-like
  keybindings with leader
- Diagnostic mode? idk maybe
- i bet there are a bunch of ways to use this
