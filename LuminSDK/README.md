## LuminSDK
that's the main part of LuminOS, the C# part.  
LuminOS itself isn't written entirely in C#, as that would be unfeasible.
This OS, like many others, is based on Ubuntu/Debian and Linux.  
But LuminSDK is the C# layer that runs on top of Linux. This means that
all standard Linux applications and utilities will work here, while also being optimized to run applications written in C#  
and AvaloniaUI.

### First.
LuminSDK is internally called "overlay", cause it was it's codename on first versions.  
But LuminCommunitySDK doesn't have that codename, so don't get confused.  

### Second.
LuminSDK is made for SYSTEM APPS, any third party apps should use DotNet 8.0LTS (latest LTS version) for linux  
and also LuminCommunitySDK, that's just a .cs file you can integrate on your project  
LuminCommunitySDK is not avaible yet, cause it's based on LuminSDK, that still in early development.

#### Working functions
LuminSDK and CommunitySDK have custom commands, and thats the current working commands:  
by the way, to use the commands, you'll need to use SDK. as a prefix.<br>
SDK.underscore(*bool* isBlinking, *int* how_many_times_will_underscore_blink);
SDK.ASCII(*string* "what draw do you want");
SDK.checkREG(*string* registy path", *bool* you_guess_it_exists, *bool* is_in_debug_mode);<br>  

**thats it for now :3**