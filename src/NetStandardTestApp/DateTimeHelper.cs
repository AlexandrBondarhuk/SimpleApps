using System;
using System.Dynamic;

namespace NetStandardTestApp
{
    public class DateTimeHelper
    {
        public static int GetCurrentYear() => DateTime.UtcNow.Year;
    }
}
