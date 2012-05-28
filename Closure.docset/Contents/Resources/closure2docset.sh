#!/bin/bash

# process.sh by Robin Zhong 
cd $(dirname $0)

ref_dir="Documents/doc"
#package_html="$ref_dir/classes.html"
class_html="$ref_dir/classes.html"

xml="Tokens.xml"
#file_packages=tmp.packages
file_classes=tmp.classes



grep "<span class=\"fn\">" $ref_dir/*.html | grep -v ".js.html" | sed -e 's/<span class="fn">//g' | sed -e 's/<\/span>//g' | tr ":" " "  | sed -e 's/Documents\///' > $file_classes

###
echo "Tokens.xml: merging..."
cat > $xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<Tokens version="1.0">
EOF
#cat "$file_packages" | awk '{print "<File path=\""$1"\"><Token><TokenIdentifier>//apple_ref/java/cl/"$2"</TokenIdentifier></Token></File>"}' \
#    >> $xml
cat "$file_classes" | awk '{print "<File path=\""$1"\"><Token><TokenIdentifier>//apple_ref/java/cl/"$2"</TokenIdentifier></Token></File>"}' \
    >> $xml
echo "</Tokens>" >> $xml
echo "Tokens.xml: done."


/Developer/usr/bin/docsetutil index -verbose ../../../Closure.docset/ 