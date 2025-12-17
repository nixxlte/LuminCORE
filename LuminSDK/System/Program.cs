using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Threading;

// HII! That code is the first part of the LuminOS project, that was made to integrate C# with the Linux Kernel.
// The focus of Lumin is create a Linux Distro based on C# and .NET technologies
// (together with AvaloniaUI, cause its a cool project :D )

// Specifically, "overlay" is the layer that can use C# things with the system
// Basically, Linux (and Ubuntu) is just the base, but almost everything is made in C#
// also, Linux is important here cause its... the non-C# parts, WE JUST WANT C#, and some other stuff.
// Like KDE, and what i want to say is that Linux already have a lot of apps, like VS Code, Firefox, Python, etc.
// If i try to make my own kernel, the OS will not have any app stuff, and will be useless

namespace Overlay {
    // Code by NixxLTE UwU
    class Registry {
        public string Type { get; set; } = string.Empty;   // REG_SZ, REG_DWORD, etc.
        public string Name { get; set; } = string.Empty;   // <REG_TYPE Name="...">
        public string Value { get; set; } = string.Empty;  // <REG_TYPE Value="...">
    }

    internal class Program {
        // Make registries accessible to methods across the class
        static Dictionary<string, Registry> registries = new Dictionary<string, Registry>();

        public static string blink_ = " ";
        public static bool is_blinking = false;

        public static string errorcode = "Cx0000"; // Default error code

        public static string SDKedition = "Lumin.Overlay.SDK.System"; // System package name
        public static int exceptionNumber = 0;

        public static void catchError(string reason, string code) {
            errorcode = "Cx" + code;
            Console.WriteLine("An error occurred: " + reason + " Error code: " + errorcode);
        }

        public static async Task underscore(int times) {
            int blinked = 0;
            is_blinking = true;
            while (is_blinking && blinked < times) {
                blink_ = "_";
                await Task.Delay(500);
                blink_ = " ";
                await Task.Delay(500);
                blinked++;
            }

            // ensure blinking flag is reset when done
            is_blinking = false;
            blink_ = " ";
        }

        public static void exception(string str) {
            Console.WriteLine("Exception on running program, " + str);
            exceptionNumber = exceptionNumber + 1;
            if (exceptionNumber >= 5) {
                Console.WriteLine("Exception numbers exceeded the limit of 5, exiting");
                Thread.Sleep(500);
                Environment.Exit(0);
            }
        }

        public static void end(int code) { 
            if (code == 0) {
                Console.Write(".");
            } else if (code == 1) {
                Console.Write("!!!");
            } else {
                exception("returned code is invalid!!!");
            }
        }

        public static void ASCII(string draw) {
            if (string.Equals(draw, "OSlogo", StringComparison.OrdinalIgnoreCase)){
                Console.WriteLine("{ L U M I N ]");
                // start blinking (fire-and-forget)
                if (!is_blinking) {
                    _ = underscore(10);
                }
            } else {
                catchError("ASCII art not found", "0404");
            }
        }

        public static void checkREG(string path, bool exist, bool isDEBUG){
            exist = false;                                               
            if (registries.ContainsKey(path)) {                     
                exist = true;
                if (isDEBUG) {
                    Console.WriteLine("Requested registry key exists.");
                }
            } else {
                exist = false;
                if (isDEBUG) {
                    Console.WriteLine("Requested registry key doesn't exists.");
                }
            }
        }

        public static void Main(string[] args) {
            Console.WriteLine("Hello, World!\n");
            StartOverlay();
        }

        public static void Bash() {
            Console.Write("<Lumin@SDK> ");
            string command = Console.ReadLine() ?? string.Empty;
            string[] splited = command.Split(' ', StringSplitOptions.RemoveEmptyEntries);

            if (splited.Length == 0)
                return;

            string binary = splited[0];
            string[] cmdArgs = splited.Length > 1 ? splited[1..] : Array.Empty<string>();

            CMDchk(binary, cmdArgs);
        }

        public static void regedit(string path) { 
            Console.WriteLine("Regedit BETA 2, for testing purposes only.");
            if (string.IsNullOrWhiteSpace(path)) {
                Console.WriteLine("No path provided.");
                return;
            }

            if (registries.ContainsKey(path)) {
                Console.WriteLine($"Requested registry value: {registries[path].Value}");
            } else {
                Console.WriteLine($"Registry path not found: {path}");
            }
        }

        public static void CMDchk(string binary, string[] args) {
            switch (binary.ToLower()) {
                default:
                    Console.WriteLine("Command not found: " + binary + " \n");
                    break;
                case "echo":
                    Console.WriteLine(" \n" + string.Join(' ', args) + " \n");
                    break;
                case "break":
                    Console.Write("Are you sure you want to exit LuminSDK Shell? (y/n): ");
                    string surely = Console.ReadLine() ?? string.Empty;
                    if (surely.ToLower() == "y" || surely.ToLower() == "yes") {
                        Environment.Exit(0);
                        break;
                    } else if (surely.ToLower() == "n" || surely.ToLower() == "no") { 
                        Console.WriteLine("Aborting end.");
                        break;
                    } else {
                        Console.Write("Please type 'y' or 'n' ");
                        while (true) {
                            surely = Console.ReadLine() ?? string.Empty;
                            if (surely.ToLower() == "y" || surely.ToLower() == "yes") {
                                Environment.Exit(0);
                                break;
                            } else if (surely.ToLower() == "n" || surely.ToLower() == "no") {
                                Console.WriteLine("Aborting end.");
                                break;
                            } else {
                                Console.Write("Please type 'y' or 'n': ");
                            }
                        }
                        break;
                    }
                case "help":
                    Console.WriteLine("Available commands:");
                    Console.Write(" - echo [text]: Prints the text to the console\n");
                    Console.Write(" - break: Exits the LuminSDK Shell\n");
                    Console.Write(" - regedit [path]: Reads a registry value from Registry.xml\n");
                    Console.Write(" - console.clear: Clears the console\n");
                    Console.Write(" - luminver: Show info about SDK\n");
                    break;
                case "regedit":
                    if (args.Length == 0) {
                        Console.WriteLine("Usage: regedit [path]\n");
                    } else {
                        // pass the first argument as the registry path
                        regedit(args[0]);
                    }
                    break;
                case "checkreg":
                    if (args.Length == 0) {
                        Console.WriteLine("Usage: checkreg [path]\n");
                    } else {
                        bool exist = false;
                        bool isDEBUG = false;
                        if (args.Length > 1 && args[1].ToLower() == "debug") {
                            isDEBUG = true;
                        }
                        checkREG(args[0], exist, isDEBUG);
                    }
                    break;
                case "console.clear":
                    Console.Clear();
                    break;
                case "luminver":
                    Console.Clear();
                    Console.WriteLine();
                    ASCII("OSlogo");
                    Console.WriteLine();
                    Console.WriteLine("LuminSDK, Beta 3");
                    Console.WriteLine("Code writen by Nyan Nix\n");
                    string path = "Lumin/LuminSDK/InstalledVersion";
                    if (registries.ContainsKey(path)) {
                        Console.WriteLine($"Running in compilation: {registries[path].Value}");
                    }
                    // reuse same variable instead of redeclaring
                    path = "Lumin/LuminSDK/TargetBuild";
                    if (registries.ContainsKey(path)) {
                        Console.WriteLine($"Built for LuminOS build {registries[path].Value}\n");
                    }
                    Console.WriteLine("for testing purposes only | code edition 20251217\n"); // im not using the REG key here cause it bugs the code completely
                    break;                                                                    // also "20251217" is the date of last edit (19th November 2025)
                case "ascii":                                                                 // and the date is used as the code version
                    if (args.Length == 0) {
                        Console.WriteLine("Usage: ascii [draw]\n");
                        break;
                    } else {
                        ASCII(args[0]);
                        break;
                    }
                case "osver":
                    Console.Clear();
                    Console.WriteLine();
                    ASCII("OSlogo");
                    Console.WriteLine();
                    Console.WriteLine("LuminOS, Beta 1");
                    Console.WriteLine("Code writen by NyanRay64\n");
                    path = "Lumin/LuminSDK/TargetBuild";
                    if (registries.ContainsKey(path))
                    {
                        Console.WriteLine($"LuminOS build {registries[path].Value}\n");
                    }
                    path = "Lumin/LuminSDK/InstalledVersion";
                    if (registries.ContainsKey(path))
                    {
                        Console.WriteLine($"Running under LuminSDK build {registries[path].Value}");
                    }
                    Console.WriteLine("for testing purposes only | code edition 20251217\n");
                    break;
                case "exception":
                    if (args.Length == 0) {
                        Console.WriteLine("Usage: exception [text]");
                        break;
                    } else {
                        exception(args[0]);
                        break;
                    }
            }
        }

        public static void StartOverlay() {
            XmlDocument doc = new XmlDocument();
            try {
                doc.Load("Registry.xml");
            } catch (Exception ex) {
                Console.WriteLine("Failed to load Registry.xml: " + ex.Message);
                Thread.Sleep(3000);
                return;
            }

            XmlNode? root = doc.SelectSingleNode("/registry/Hkey_ROOT");

            // Use the static 'registries' field (clear any existing entries)
            registries.Clear();

            if (root != null) {
                regREAD(root, "", registries);
            }

            // Example to access a specific registry value
            string path = "Lumin/LuminSDK/InstalledVersion";
            if (registries.ContainsKey(path)) {
                Console.WriteLine($"Running version: {registries[path].Value}\n");
            }

            if (SDKedition == "Lumin.Overlay.SDK.System") { 
                while(true) { Bash(); }  // For testing purposes only, will be removed later (this is not a shell, just a compatibility layer)
            } else { 
            
            }
        }

        static void regREAD(XmlNode node, string ActualPath, Dictionary<string, Registry> dict) {
            foreach (XmlNode child in node.ChildNodes) {
                if (child.Name.StartsWith("REG_")) {
                    string type = child.Name;
                    string name = child.Attributes?["Name"]?.Value ?? string.Empty;
                    string value = child.Attributes?["Value"]?.Value ?? string.Empty;

                    string EntirePath = string.IsNullOrEmpty(ActualPath) ? name : ActualPath + "/" + name;

                    Registry reg = new Registry { Type = type, Name = name, Value = value };
                    dict[EntirePath] = reg;
                } else {
                    string newPath = string.IsNullOrEmpty(ActualPath) ? child.Name : ActualPath + "/" + child.Name;
                    regREAD(child, newPath, dict);
                }
            }
        }
    }
}
