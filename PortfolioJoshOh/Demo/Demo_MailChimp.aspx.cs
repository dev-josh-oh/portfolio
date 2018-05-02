using PortfolioJoshOh.Mailchimp;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PortfolioJoshOh.Demo
{
    public partial class Demo_MailChimp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmitAPIKey_Click(object sender, EventArgs e)
        {
            string apiKey = this.txtAPIKey.Text;
            string server = apiKey.Split('-').Last();
            string mailChimpURL = string.Format("https://{0}.api.mailchimp.com/3.0/", server);

            try
            {
                GetResponseRoot rootResponse = PortfolioJoshOh.Mailchimp.Endpoints.GetRootAsync(mailChimpURL, apiKey).GetAwaiter().GetResult();

                if(rootResponse.account_id != null)
                {
                    this.lblPingResult.InnerHtml = "Ping successful.<br/> Account ID: " + rootResponse.account_id;
                    ScriptManager.RegisterStartupScript(upAPI, upAPI.GetType(), "showDiv", "showPingResult();", true);
                }
            }
            catch (WebException ex)
            {

                throw ex;
            }
        }

        protected void btnGetLists_Click(object sender, EventArgs e)
        {
            this.divGetLists.Style.Remove("display");

            string apiKey = this.txtAPIKey.Text;
            string server = apiKey.Split('-').Last();
            string mailChimpURL = string.Format("https://{0}.api.mailchimp.com/3.0/lists", server);

            GetResponseLists listsResponse = PortfolioJoshOh.Mailchimp.Endpoints.GetListsAsync(mailChimpURL, apiKey).GetAwaiter().GetResult();

            if(listsResponse != null)
            {
                divGetListsResults.Style.Remove("display");
                gvListResults.DataSource = listsResponse.lists;
                gvListResults.DataBind();
            }
        }
    }
}