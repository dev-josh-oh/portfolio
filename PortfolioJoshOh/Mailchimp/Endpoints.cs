using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Runtime.Serialization.Json;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace PortfolioJoshOh.MailChimp
{
    public class Endpoints
    {
        static HttpClient client = new HttpClient();

        public static async Task<MailChimp.GetResponseRoot> GetRootAsync(string path, string apiKey)
        {
            MailChimp.GetResponseRoot rootResponse = new GetResponseRoot();
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic", apiKey);

            //// to test error handling, reassign the X-Trigger-Error header
            //// beginning of error checking code
            //client.DefaultRequestHeaders.Remove("X-Trigger-Error");
            //client.DefaultRequestHeaders.Add("X-Trigger-Error", XTriggerError._401APIKeyMissing);
            //// end of error checking code


            try
            {
                HttpResponseMessage response = await client.GetAsync(path).ConfigureAwait(false);
                var responseResult = await response.Content.ReadAsStringAsync();
                if (response.IsSuccessStatusCode)
                {
                    var serializer = new DataContractJsonSerializer(typeof(MailChimp.GetResponseRoot));
                    var memoryStream = new MemoryStream(Encoding.UTF8.GetBytes(responseResult));
                    rootResponse = (MailChimp.GetResponseRoot)serializer.ReadObject(memoryStream);
                }
                else
                {
                    var serializer = new DataContractJsonSerializer(typeof(MailChimp.GetResponseError));
                    var memoryStream = new MemoryStream(Encoding.UTF8.GetBytes(responseResult));
                    rootResponse.responseError = (MailChimp.GetResponseError)serializer.ReadObject(memoryStream);
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                throw;
            }
            return rootResponse;
        }

        public static async Task<MailChimp.GetResponseLists> GetListsAsync(string path, string apiKey)
        {
            MailChimp.GetResponseLists listsResponse = null;
            client.DefaultRequestHeaders.Authorization = new System.Net.Http.Headers.AuthenticationHeaderValue("Basic", apiKey);

            try
            {
                HttpResponseMessage response = await client.GetAsync(path).ConfigureAwait(false);
                if (response.IsSuccessStatusCode)
                {
                    var responseResult = await response.Content.ReadAsStringAsync();

                    var serializer = new DataContractJsonSerializer(typeof(MailChimp.GetResponseLists));

                    var memoryStream = new MemoryStream(Encoding.UTF8.GetBytes(responseResult));
                    listsResponse = (MailChimp.GetResponseLists)serializer.ReadObject(memoryStream);

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