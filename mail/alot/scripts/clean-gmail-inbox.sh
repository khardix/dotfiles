#!/usr/bin/sh
# Really remove messages that are not tagged as inbox from Inbox folder
notmuch search --output=files --format=text0 folder:gmail/Inbox AND NOT tag:inbox \
  | grep -z 'Inbox' \
  | xargs -0 --no-run-if-empty rm -f
notmuch new
