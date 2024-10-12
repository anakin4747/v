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

# Takeaway from VSCode comparison
- VSCode has superior LSP features for uncompiled C codebases
- RESOLVE THIS

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
<!-- - Add ctrl-l to terminal mode so that clearing doesnt acutallt clear the buffer -->
<!--   but just scrolls up -->
- Make it so that you can get lsp completion from the command line insert mode.
- Make the terminal buffer a double buffer, one that you can modify and one
  that is the acutal immutable output of the terminal. This makes it so that
  you can edit anywhere like editing a file path to then `gf` to. Or just
  properly edit your command line input.

<!-- # Modes -->
<!-- - Look into nvim-libmodal -->
<!-- - See if you could have a debug mode so that you don't need to prefix gdb-like -->
<!--   keybindings with leader -->
<!-- - Diagnostic mode? idk maybe -->
<!-- - i bet there are a bunch of ways to use this -->

# Tabs? buffers?

Maybe no more tabs, causes so many issues. just have high priority buffers
locked at low indices so that when too many pile up they just can be ignored.
Maybe no more cycling through buffers. treating buffers more like you do
windows in you wm.

## Tabs: an old opinion
<C-w>N goes to the Nth tab 
<C-W>N moves current buffer to Nth tab

only have buffers stay pinned if I want to otherwise buffer that I just jumped
to from lsp stuff just disappear (setlocal unlisted??)

No wrap around tab cycling
No wrap around buffer cycling

Now you can order your buffers and keep track of them

Add to <C-g> a mini little display of the tabs and the buffers in those tabs

Like an overview, also look into naming tabs like tmux that could make you more
organized


# Global nvim - Failed to implement
- Global neovim that is only for terminals and you use a nested neovim to edit
  files.
- This will keep things closer to how they used to be before you started using
  terminals in neovim. You will have tabs for each terminal (closer to tmux)
- <C-b>v, <C-b>s will manipulate the global neovim since they are terminal
  related
- The only buffers in the global neovim should only be terminals and the only
  buffers in the child neovims should only be files.
- solves a lot of the issues you have relating to a global neovim
- wont need tab local buffers any more since each child nvim instance will
  replicate the effect by being different instances.
## Reasons why this failed
- windowing became much more difficult to manage
- had to figure out how to set keymaps based on global or child (how to
  determine if in child or parent)
- couldn't have <esc><esc> only in parent. 

