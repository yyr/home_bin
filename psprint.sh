#!/bin/bash

if [[ $# != 1 ]]; then
    echo "usage: $0 FILE" > /dev/stderr
    exit 2
fi

in="$1"
out="/tmp/$(basename "$in").ps"
emacs \
    --quick \
    --batch \
    --file "$in" \
    --eval "
(let ((ps-top-margin 0)
        (ps-left-margin 0)
        (ps-right-margin 0)
        (ps-inter-column 0)
        (ps-landscape-mode t)

        ;; adjust this and font size if enabling line numbers
        (ps-number-of-columns 2)

        (ps-print-header t)
        (ps-print-footer nil)
        (ps-print-header-frame nil)
        (ps-header-offset 5.58001116)
        (ps-header-title-font-size '(10 . 12))
        (ps-header-font-size (quote (7 . 8.5)))

        ;; 80 chars per line
        (ps-font-size 8.25)
        (ps-line-number t)

        (ps-line-number-font-size 10)
        (ps-line-number-step 10)

        (ps-print-color-p 'black-white))

        (ps-print-buffer-with-faces \"$out\")

  ;; gives chars per line info, among other things
  ;;  (ps-line-lengths)
  ;;  (write-file \"/tmp/line-lengths.txt\")

    (kill-emacs))
"
echo "$in -> $out"
