using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PortfolioJoshOh.Blockchain
{
    public class Block
    {
        public string hash { get; set; }
        public string previousHash { get; set; }
        public string data { get; set; }
        public DateTime timeStamp { get; set; }
        public int nonce { get; set; }

        public Block(string data, string previousHash)
        {
            this.data = data;
            this.previousHash = previousHash;
            this.timeStamp = DateTime.Now;
            this.hash = calculateHash();
        }

        public string calculateHash()
        {
            string stringToBeHashed = this.previousHash + this.timeStamp + data;
            string calculatedHash = Blockchain.SHA.GenerateSHA256String(stringToBeHashed);
            return calculatedHash;
        }

        public void mineBlock(int difficulty)
        {
            string target = new string(new char[difficulty]).Replace('\0', '0');
            while(!this.hash.Substring(0, difficulty).Equals(target))
            {
                this.nonce++;
                this.hash = calculateHash();
            }
        }
    }
}