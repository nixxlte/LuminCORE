#!/bin/bash

echo "building Lumin project..."

if [ -n "$1" ]; then
	dotnet publish -c Release -r linux-x64 --self-contained false
	chmod +x "bin/Release/net*/linux-x64/publish/$1"
else
	echo "usage: ./Compile.sh <ProjectName>"
	echo "<ProjectName> is the .csproj file name without the extension."
fi