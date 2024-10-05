# VSCode feature comparision
## C
### Before compiling
#### Go to definition
- vscode: go to definition does a best effort search and showed the correct
  definition as the most likely in a list of possible options when there is
  only one definition it opens it in a new file and jumps to it
- neovim: fails to go to definition but will sometimes jump to the declaration
  if it there is one
- desired behaviour: best effort search and providing a list of likely options
  and not jumping to declaration since I want a specific keybinding for that
  and I dont want them to overlap for no reason
#### Go to declaration
- vscode: go to declaration does a best effort search and showed the correct
  declaration as the most likely in a list of possible options when there is
  only one declaration it opens it in a new file and jumps to it
- neovim: either goes to declaration or fails
- desired behaviour: goes to declaration or alerts that no declaration was
  found or lists multiple if multiple options are available. Does not go to
  definition
#### Go to type definition
- vscode: goes to type definition - assuming it does a best effort search

# LSP
- For every LSP action have a fallback so that you still do something if the
  lsp fails.
- Add a way to choose to get your lsp information in a hover window, a popup
  window, in a split or jumping to the requested information
- Add this^ for everything lsp related
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

# xargs
- get xargs working with `v` bash function

# VMUX
- Add a way to store your vim related aliases required for muxing with vim in
  the codebase and sent out to the required system files on init. For example
  the bash function `v` and git related commands. In the same manner you did
  the zsh dependencies. Have the scripts be inside this codebase and just add
  lines to the other files to source the scripts.

# Omnifunc
- Learn omnifunc

# CMP
- Learn how to customize the appearance of completion menu

# Snippets
- Creating custom snippets and getting snippet keybindings working

# Debugging
- have every tree data structure just display as a fully folded file and have
  them open and close with fold commands
- Have a debug mode where n is next c is continue
- For debugging hide all the windows by default and figure out how to open
  specific ones manually.
  And have the default layout just be the file being debugged.
  If you want any of the items open it in telescope.
  God I need to be able to hover and see the current values of a variable.
  With folding and everything.
## Menu - not so important
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

# Modes
- Look into nvim-libmodal
- See if you could have a debug mode so that you don't need to prefix gdb-like
  keybindings with leader
- Diagnostic mode? idk maybe
- i bet there are a bunch of ways to use this
