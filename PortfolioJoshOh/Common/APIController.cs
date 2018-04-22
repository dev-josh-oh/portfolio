using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;

namespace PortfolioJoshOh.Common
{
    public class APIController
    {
        private static readonly HttpClient HttpClient;

        static APIController()
        {
            HttpClient = new HttpClient();
        }
    }
}