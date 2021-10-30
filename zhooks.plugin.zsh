# zhooks: Display all Zsh hook arrays and functions
#
# MIT License
#
# Copyright (c) 2018-2021 Alexandros Kozak
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
# Display all Zsh hook arrays and functions
#
# Returns true if any functions have been associated with
# Zsh hooks
############################################################
zhooks() {

  (( ${+terminfo} )) || zmodload zsh/terminfo
  if (( ${terminfo[colors]:-0} >= 8 )); then
    local start_color=${(%):-%F{yellow}}
    local end_color=${(%):-%f}
  fi

  local -a hooks
  hooks=(
    'chpwd' \
    'periodic' \
    'precmd' \
    'preexec' \
    'zshaddhistory' \
    'zsh_directory_name' \
    'zshexit'
    )

  local hook hook_array_name hook_array_content hook_function ret
  for hook in ${hooks[@]}; do
    # Display contents of hook arrays
    hook_array_name="${hook}_functions"
    hook_array_content=$(print -l -- ${${(P)hook_array_name}[@]})
    if [[ -n $hook_array_content ]]; then
      printf -- '%s:\n%s\n\n' "${start_color}${hook_array_name}${end_color}" "$hook_array_content"
      (( ret++ ))
    fi
    # Display defined hook functions
    if (( ${+functions[$hook]} )); then
      hook_function=$(whence -c $hook)
      printf -- '%s\n\n' "${start_color}${hook_function%%\(*}${end_color}${hook_function#* }"
      (( ret++ ))
    fi
  done

  (( ret ))
}

############################################################
# Unload function
#
# See https://github.com/agkozak/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc#unload-fun
############################################################
zhooks_plugin_unload() {
  unfunction zhooks $0
}
