# zhooks

[![MIT License](img/mit_license.svg)](https://opensource.org/licenses/MIT)

**zhooks** is a tool for displaying the contents of all ZSH hook arrays (such as `$precmd_functions`) as well as any hook functions (such as `precmd`) that have been defined. It is intended to be used in debugging conflicts between scripts.

![zhooks](img/demo.gif)

Simply source zhooks from your `.zshrc`:

    source /path/to/zhooks.zsh

or load it using your favorite ZSH framework. Then run the command `zhooks` from the command line to see a thorough report.

You can even use the `zhooks` function in a script. For example:

    source /path/to/zhooks.zsh

    if zhooks &> /dev/null; then
      echo 'Hooks are being used.'
    else
      echo 'This house is clean.'
    fi

`zhooks` returns true when hooks are being used and false when they are not.
