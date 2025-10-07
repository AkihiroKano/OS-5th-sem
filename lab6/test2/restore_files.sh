#!/bin/bash

for i in {1..20}; do
    cp "backups/file${i}.original" "file${i}.txt"
done
