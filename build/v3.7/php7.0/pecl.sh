#!/bin/sh

# first find which PHP binary to use
if test "x$PHP_PEAR_PHP_BIN" != "x"; then
  PHP="$PHP_PEAR_PHP_BIN"
else
  if test "/usr/bin/php" = '@'php_bin'@'; then
    PHP=php
  else
    PHP="/usr/bin/php"
  fi
fi

# then look for the right pear include dir
if test "x$PHP_PEAR_INSTALL_DIR" != "x"; then
  INCDIR=$PHP_PEAR_INSTALL_DIR
  INCARG="-d include_path=$PHP_PEAR_INSTALL_DIR"
else
  if test "/usr/share/php/7.0" = '@'php_dir'@'; then
    INCDIR=`dirname $0`
    INCARG=""
  else
    INCDIR="/usr/share/php/7.0"
    INCARG="-d include_path=/usr/share/php/7.0"
  fi
fi

# Find XML shared extension
if test "x$($PHP -r 'print_r(extension_loaded("xml"));')" != "x"; then
  if test "x$($PHP -n -r 'print_r(extension_loaded("xml"));')" = "x"; then
    XMLFLAG="-d extension_dir="`$PHP -i | grep ^extension_dir | sed 's/.*=> //')`" -d extension=xml.so"
  fi
fi

exec $PHP -C -n -q $INCARG -d date.timezone=UTC -d output_buffering=1 -d variables_order=EGPCS -d safe_mode=0 -d register_argc_argv="On" $XMLFLAG $INCDIR/peclcmd.php "$@"
