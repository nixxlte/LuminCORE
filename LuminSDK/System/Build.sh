#!/bin/bash
dotnet publish -c Release -r linux-x64 -p:PublishSingleFile=true --self-contained false
cd bin/Release/net8.0/linux-x64/publish/
mv Overlay overlay.sdkx
echo "Build complete."