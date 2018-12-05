#!/bin/bash
#: Title       : flac2m4a
#: Date        : 2010-09-07
#: Author      : "Stephen Nichols" <ChinnoDog@lonesheep.net>
#: Version     : 1.0
#: Description : Convert flac file to m4a using neroAacEnc with vbr 192kbps
#: Options     : <input file> [-of outputfile] [-q quality]

# Validate input file
infile=$1

# Validate output file
outfile=${1%.*}.m4a

# Convert file
echo Transcoding $infile
flac -d -c "$infile" 2>/dev/null | neroAacEnc -q 0.55 -if - -of "$outfile" 2>/dev/null

# Read tags
tagparams=$(metaflac --export-tags-to=- "$infile" | sed 's/^\(.*\)=\(.*\)/-meta-user:\1="\2"/' | tr "\n" ";")

# Write tags
echo Tagging $outfile
IFS=\;
neroAacTag "$outfile" $tagparams 2>/dev/null
unset IFS

# premature exit
exit 0

# old stuff
ls *.flac | while read file
do
  flac -d -c "$file" | neroAacEnc -q 0.55 -if - -of "${file%.*}.m4a"
  IFS=''
  neroAacTag "${file%.*}.m4a" $(metaflac --export-tags-to=- "$file" | sed 's/^\(.*\)=\(.*\)/-meta-user:\1="\2"/' | tr "\n" " ")
  unset IFS
done
