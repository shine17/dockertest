using System;

namespace Dockertest
{
    class Program
    {
        static void Main(string[] args)
        {
            var i = 0;
            while(true)
            {
                Console.WriteLine($"Am alive! and iteration count is {i}", i++);
                System.Threading.Thread.Sleep(3000);
            }
           
        }
    }
}
