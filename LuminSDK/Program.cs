using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

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
                    } else { 
                        Console.WriteLine("Aborting end.");
                        break;
                    }
                case "help":
                    Console.WriteLine("Available commands:");
                    Console.Write(" - echo [text]: Prints the text to the console\n");
                    Console.Write(" - break: Exits the LuminSDK Shell\n");
                    Console.Write(" - regedit [path]: Reads a registry value from Registry.xml\n");
                    Console.Write(" - console.clear: Clears the console");
                    Console.Write(" - luminver: Show info about SDK")
                    break;
                case "regedit":
                    if (args.Length == 0) {
                        Console.WriteLine("Usage: regedit [path]\n");
                    } else {
                        // pass the first argument as the registry path
                        regedit(args[0]);
                    }
                    break;
                case "console.clear":
                    Console.Clear();
                    break;
                case "luminver":
                    Console.Clear();
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
                    Console.WriteLine("for testing purposes only | last code edit 20251103\n");
                    break;
            }
        }

        public static void StartOverlay() {
            XmlDocument doc = new XmlDocument();
            try {
                doc.Load("Registry.xml");
            } catch (Exception ex) {
                Console.WriteLine("Failed to load Registry.xml: " + ex.Message);
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

            while(true) {
                Bash(); // For testing purposes only, will be removed later (this is not a shell, just a compatibility layer)
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
