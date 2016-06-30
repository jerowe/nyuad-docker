#!/usr/bin/bash

/etc/init.d/munge start
/usr/bin/supervisord &
