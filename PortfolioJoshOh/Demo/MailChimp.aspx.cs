using PortfolioJoshOh.MailChimp;
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
                GetResponseRoot rootResponse = PortfolioJoshOh.MailChimp.Endpoints.GetRootAsync(mailChimpURL, apiKey).GetAwaiter().GetResult();
                bool isPingFail = true;                

                if(rootResponse.account_id != null)
                {
                    this.lblPingResult.InnerHtml = "Ping successful.<br/> Account ID: " + rootResponse.account_id;
                    isPingFail = false;
                }
                else
                {
                    this.lblPingResult.InnerHtml = "Ping failed with the following message from the MailChimp server: <br/>" +
                        "<br/>" +
                        "<font style=\"color:red\" >detail</font> : " + rootResponse.responseError.detail + "<br/>" +
                        "<font style=\"color:red\" >instance</font> : " + rootResponse.responseError.instance + "<br/>" +
                        "<font style=\"color:red\" >status</font> : " + rootResponse.responseError.status + "<br/>" +
                        "<font style=\"color:red\" >title</font> : " + rootResponse.responseError.title + "<br/>";
                    isPingFail = true;
                }
                // injecting JS to handle display of the result instead of setting the div to show here to get the nice fade in effect from jQuery
                ScriptManager.RegisterStartupScript(upAPI, upAPI.GetType(), "showDiv", "showPingResult(" + isPingFail.ToString().ToLower() + ");", true);
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

            GetResponseLists listsResponse = PortfolioJoshOh.MailChimp.Endpoints.GetListsAsync(mailChimpURL, apiKey).GetAwaiter().GetResult();

            if(listsResponse != null)
            {
                divGetListsResults.Style.Remove("display");
                gvListResults.DataSource = listsResponse.lists;
                gvListResults.DataBind();
            }
        }
    }
}