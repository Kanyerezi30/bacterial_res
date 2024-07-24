#!/usr/bin/env bash

snippy-core --ref /home/hivdr/comoros/uganda/UG-Kayunga-23-1307/ref.fa $( cat snippycore.txt | sed -z 's/\n/ /g; s/ $/\n/')
