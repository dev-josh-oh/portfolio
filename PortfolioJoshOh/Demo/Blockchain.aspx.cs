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
        public static int difficulty = 5;

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

        public static bool isChainValid(List<Block> blockchain, out string whyNotValid)
        {
            whyNotValid = "";
            Block currentBlock;
            Block previousBlock;
            string hashTarget = new string(new char[difficulty]).Replace('\0', '0');

            // loop through blockchain to check hashes:
            for (int i = 1; i < blockchain.Count(); i++)
            {
                currentBlock = blockchain[i];
                previousBlock = blockchain[i - 1];
                // compare registered hash and calculated hash:
                if (!currentBlock.hash.Equals(currentBlock.calculateHash()))
                {
                    whyNotValid = "Current Hashes not equal";
                    return false;
                }
                // compare previous hash and registered previous hash
                if (!previousBlock.hash.Equals(currentBlock.previousHash))
                {
                    whyNotValid = "Previous Hashes not equal";
                    return false;
                }
                // check if hash is solved
                if(!currentBlock.hash.Substring( 0 , difficulty).Equals(hashTarget))
                {
                    whyNotValid = "This block hasn't been mined";
                    return false;
                }
            }
            return true;
        }
    }
}