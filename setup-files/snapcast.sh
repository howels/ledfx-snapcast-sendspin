#!/bin/bash

snapclient --host "$HOST" --daemon 1 --hostID $(hostname) "$SNAPCLIENT_OPTS"