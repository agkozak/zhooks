# zsh-hooks

[![MIT License](img/mit_license.svg)](https://opensource.org/licenses/MIT)

**zsh-hooks** is a function/command that displays the contents of all ZSH hook arrays (such as `$precmd_functions`) as well as any hook functions (such as `precmd`) that have been defined. It also returns true when any hooks have been defined and false when they have not. It is intended to be used in debugging conflicts between scripts.

![zsh-hooks](img/demo.gif)

Simply source zsh-hooks from your `.zshrc`:

    source /path/to/zsh-hooks.zsh

or load it using your favorite ZSH framework.

Then run the command `zsh-hooks` from the command line to see a thorough report. You can even use the `zsh-hooks` function in a script (provided, of course, that it sources `zsh-hooks.zsh`), for example:

    if zsh-hooks &> /dev/null; then
      echo 'Hooks are being used.'
    else
      echo 'This house is clean.'
    fi
