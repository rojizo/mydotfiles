#!/bin/bash
# Lista todos los monitores conectados y asigna números

monitors=$(hyprctl monitors | grep '^Monitor ' | sed -E 's/^Monitor ([^(]+) \(ID [0-9]+\):$/\1/')

output="{\"text\":\""
num=1
for m in $monitors; do
    output+="Monitor $num ($m)  "
    ((num++))
done
output+='" }'

echo "$output"
