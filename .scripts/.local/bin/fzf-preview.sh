#!/usr/bin/env bash
#
# Universal fzf / fzf-tab preview.
#   - directory   -> recursive tree (files + subdirs, via eza/tree/ls)
#   - image / pdf -> rendered inline via kitty's graphics protocol (kitten icat)
#   - text        -> syntax highlighted via bat (Tokyo Night theme)
#   - anything else (binaries, unknown types) -> empty
#
# Usage: fzf-preview.sh <path>

file=$1
[[ -z $file ]] && exit 1

realfile=$(realpath -m -- "$file" 2>/dev/null || printf '%s' "$file")

# ---- directories: recursive tree ----------------------------------------
if [[ -d $realfile ]]; then
  if command -v eza &>/dev/null; then
    eza --tree --level=2 --icons --color=always --group-directories-first -- "$realfile"
  elif command -v tree &>/dev/null; then
    tree -C -L 2 --dirsfirst -- "$realfile"
  else
    ls -la --color=always -- "$realfile"
  fi
  exit 0
fi

[[ -f $realfile ]] || exit 0

mime=$(file --mime-type -Lb -- "$realfile" 2>/dev/null)

# helper: is a kitty-graphics-capable terminal actually available?
have_kitty_graphics() {
  [[ -n $KITTY_WINDOW_ID ]] && command -v kitten &>/dev/null
}

# fzf only sets these while actually running a preview. Fall back to
# something sane so a manual/standalone run (or an odd fzf version) doesn't
# hand kitten an empty size and crash.
place_w=${FZF_PREVIEW_COLUMNS:-80}
place_h=${FZF_PREVIEW_LINES:-24}

case "$mime" in
  image/*)
    if have_kitty_graphics; then
      kitten icat --clear --transfer-mode=memory --unicode-placeholder --stdin=no \
        --place="${place_w}x${place_h}@0x0" "$realfile" \
        | sed '$d' | sed $'$s/$/\e[m/'
    fi
    # not in kitty (or no kitten found) -> stay empty rather than dumping garbage
    ;;

  application/pdf)
    if have_kitty_graphics && command -v pdftoppm &>/dev/null; then
      tmp="/tmp/fzf-pdf-preview-$$"
      pdftoppm -singlefile -jpeg -jpegopt quality=60 -- "$realfile" "$tmp"
      kitten icat --clear --transfer-mode=memory --unicode-placeholder --stdin=no \
        --place="${place_w}x${place_h}@0x0" -- "${tmp}.jpg" \
        | sed '$d' | sed $'$s/$/\e[m/'
      rm -f -- "${tmp}.jpg"
    fi
    ;;

  text/* | *json* | *xml* | *yaml* | *javascript* | *x-empty* | *x-shellscript*)
    if command -v bat &>/dev/null; then
      bat --color=always --style=numbers --paging=never --line-range=:400 -- "$realfile"
    elif command -v batcat &>/dev/null; then
      batcat --color=always --style=numbers --paging=never --line-range=:400 -- "$realfile"
    else
      cat -- "$realfile"
    fi
    ;;

  *)
    # binary we don't know how to render -> intentionally empty
    exit 0
    ;;
esac
