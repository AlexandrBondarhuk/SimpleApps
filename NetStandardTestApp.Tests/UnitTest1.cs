using NUnit.Framework;

namespace NetStandardTestApp.Tests
{
    public class Tests
    {
        [SetUp]
        public void Setup()
        {
        }

        [Test]
        public void Test1()
        {
            int result = DateTimeHelper.GetCurrentYear();
            Assert.AreEqual(result, 2020);
        }
    }
}