using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PortfolioJoshOh.Blockchain;

namespace PortfolioJoshOh.Demo
{
    public partial class Demo_Blockchain : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<Block> blockchain = new List<Block>();

            blockchain.Add(new Block("Hi I'm the first block", "0"));
            blockchain.Add(new Block("Yo I'm the second block", blockchain[blockchain.Count - 1].hash));
            blockchain.Add(new Block("Hi I'm the third block", blockchain[blockchain.Count - 1].hash));

            //string blockchainJson = Newtonsoft.Json.JsonConvert.SerializeObject(blockchain);
            //this.lblResults.Text = "JSON data object: " + blockchainJson;
            this.repBlockchainExplorer.DataSource = blockchain;
            this.repBlockchainExplorer.DataBind();
        }
    }
}