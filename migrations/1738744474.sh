#!/bin/bash

# Local XCompose must change for included files to be picked up by ibus
[ -f ~/.XCompose ] && sed -i '1i # Touched to update for Pegasus defaults' ~/.XCompose 2>/dev/null || true
ibus restart 2>/dev/null || true
