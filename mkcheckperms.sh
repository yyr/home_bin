#!/bin/sh

find . -xdev \( -type f -o -type d \) \
 -printf "if [ \`stat -c '%%u:%%g:0%%a' '%h/%f'\` != %U:%G:%#m ]; then echo \"chown %U:%G '%h/%f' ; chmod %#m '%h/%f'\"; fi\n" \
| sort
