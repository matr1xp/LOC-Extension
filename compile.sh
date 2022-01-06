#!/bin/bash

#Import tools for compiling extension binaries
export PATH=$PATH:/opt/libreoffice7.2/sdk/bin:/Applications/LibreOffice.app/Contents/MacOS

#Setup directories 
mkdir "${PWD}"/LOC/
mkdir "${PWD}"/LOC/META-INF/

#Compile the binaries
idlc -I /opt/libreoffice7.2/sdk/idl "${PWD}"/idl/LOC.idl
regmerge -v "${PWD}"/LOC/LOC.rdb UCR "${PWD}"/idl/LOC.urd
rm "${PWD}"/idl/LOC.urd

#Copy extension files and generate metadata
cp -f "${PWD}"/src/loc.py "${PWD}"/LOC/
cp -f "${PWD}"/src/errors.py "${PWD}"/LOC/
cp -f "${PWD}"/src/exchange.py "${PWD}"/LOC/
cp -f "${PWD}"/src/exchanges.py "${PWD}"/LOC/
cp -f "${PWD}"/src/version.py "${PWD}"/LOC/
cp -f "${PWD}"/src/description-en-US.txt "${PWD}"/LOC/
python "${PWD}"/src/generate_metainfo.py

#Package into oxt file
pushd "${PWD}"/LOC/
zip -r "${PWD}"/LOC.zip ./*
popd
mv "${PWD}"/LOC/LOC.zip "${PWD}"/LOC.oxt
