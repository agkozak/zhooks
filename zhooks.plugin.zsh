# zhooks: Display all ZSH hook arrays and functions
#
# MIT License
#
# Copyright (c) 2018 Alexandros Kozak
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# https://github.com/agkozak/zhooks
#

############################################################
# Display all ZSH hook arrays and functions
#
# Returns true if any functions have been associated with
# ZSH hooks
############################################################
zhooks() {
  if (( $(tput colors) >= 8 )); then
    autoload -Uz colors && colors
    local start_color="$fg[yellow]"
  else
    local start_color=''
  fi

  local -a hook_names
  hook_names=(
    'chpwd' \
    'periodic' \
    'precmd' \
    'preexec' \
    'zshaddhistory' \
    'zsh_directory_name' \
    'zshexit'
    )

  local i exit_code
  for i in $hook_names; do
    # Display contents of hook arrays
    local hook_var="${i}_functions"
    local hook_var_content="$(print -l ${(P)hook_var})"
    if [[ -n $hook_var_content ]]; then
      printf '%s:\n%s\n\n' "${start_color}${hook_var}${reset_color}" "$hook_var_content"
      (( exit_code++ ))
    fi
    # Display defined hook functions
    if [[ $(whence -w $i) == *function ]]; then
      local hook_function="$(whence -c $i)"
      printf '%s\n\n' "${start_color}${hook_function%%\{*}${reset_color}${hook_function##*\(\)}"
      (( exit_code++ ))
    fi
  done

  (( exit_code ))
}
