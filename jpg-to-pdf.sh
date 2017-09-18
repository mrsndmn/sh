#!/bin/bash

# 		  		 -g means generel numeric value
jpgs=$(ls | sort -g | grep '.jpg');

if [ "$jpgs" == "" ];
then
	echo "no *.jpg files in this directory: ";
	pwd;
	exit 25;
fi;

echo -e "Do you want to convert tis files to pdf? \n $jpgs \n";

echo -n "Continue? (y/n)"

read item
case "$item" in
    y|Y) echo "Ok, converting..."
        ;;
    n|N) echo "Ok, bye."
        exit 25;
        ;;
    *) echo "Incorrect answer. Try again"
        ;;
esac;
# lead need format
list=$(echo $jpgs | perl -lne 'print map { "($_) viewJPEG showpage " } (split /\s/, $_) ');
#echo $list;

echo "Enter filename: ";
read filename;

# jpg to pdf
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$filename" /usr/share/ghostscript/9.20/lib/viewjpeg.ps -c "$list";

