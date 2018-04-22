using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace PortfolioJoshOh.Mailchimp
{
    public class Endpoints
    {
        static HttpClient client = new HttpClient();

        public static async Task<GetResponseRoot> GetRootAsync(string path, string apiKey)
        {
            GetResponseRoot rootResponse = null;
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic", apiKey);

            try
            {
                HttpResponseMessage response = await client.GetAsync(path).ConfigureAwait(false);
                if (response.IsSuccessStatusCode)
                {
                    var responseResult = await response.Content.ReadAsStringAsync();

                    var serializer = new DataContractJsonSerializer(typeof(GetResponseRoot));

                    var memoryStream = new MemoryStream(Encoding.UTF8.GetBytes(responseResult));
                    rootResponse = (GetResponseRoot)serializer.ReadObject(memoryStream);

                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                throw;
            }
            return rootResponse;
        }

        public static async Task<GetResponseLists> GetListsAsync(string path, string apiKey)
        {
            GetResponseLists listsResponse = null;
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic", apiKey);

            try
            {
                HttpResponseMessage response = await client.GetAsync(path).ConfigureAwait(false);
                if (response.IsSuccessStatusCode)
                {
                    var responseResult = await response.Content.ReadAsStringAsync();

                    var serializer = new DataContractJsonSerializer(typeof(GetResponseLists));

                    var memoryStream = new MemoryStream(Encoding.UTF8.GetBytes(responseResult));
                    listsResponse = (GetResponseLists)serializer.ReadObject(memoryStream);

                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                throw;
            }
            return listsResponse;
        }

    }
}