using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PortfolioJoshOh.MailChimp.CustomControls
{
    [DefaultProperty("Text")]
    [ToolboxData("<{0}:ErrorResponse runat=server></{0}:ErrorResponse>")]
    public class ErrorResponse : WebControl
    {
        [Bindable(true)]
        [Category("Appearance")]
        [DefaultValue("")]
        [Localizable(true)]
        public string Text
        {
            get
            {
                String s = (String)ViewState["Text"];
                return ((s == null) ? String.Empty : s);
            }

            set
            {
                ViewState["Text"] = value;
            }
        }

        public GetResponseError response
        {
            get
            {
                return null;
            }
            set
            {

            }
        }

        protected override void RenderContents(HtmlTextWriter output)
        {
            output.Write(Text);
        }
    }
}
