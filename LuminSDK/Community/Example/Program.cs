using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using LuminSDK;

namespace myprogram
{
    class Program
    {
        static void Main(string[] args)
        {
            SDK.ASCII("OSlogo");
            Console.WriteLine("this is a luminSDK program");
            SDK.catchError("This is a test error", "2090");
            SDK.catchError("This code doesnt do anything", "123789456");
            SDK.exception("If you catch 3 or more exception, the program crashes", "10930");
        }
    }
}
