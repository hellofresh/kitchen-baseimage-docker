#!/bin/sh

version="busser"
busser="sudo -E /tmp/verifier/bin/busser"
plugins="busser-serverspec"

$gem list busser -i 2>&1 >/dev/null
if test $? -ne 0; then
  echo "-----> Installing Busser ($version)"
  $gem install $gem_install_args
else
  echo "-----> Busser installation detected ($version)"
fi

if test ! -f "$BUSSER_ROOT/bin/busser"; then
  $busser setup
fi

echo "       Installing Busser plugins: $plugins"
$busser plugin install $plugins

#Add kitchen user
useradd -d /home/kitchen -m -s /bin/bash kitchen

mkdir -p /tmp/verifier/suites
chown kitchen:kitchen /tmp/verifier/suites
