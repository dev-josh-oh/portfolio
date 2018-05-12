using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace PortfolioJoshOh.MailChimp
{
    [DataContract]
    public class IndustryStats
    {
        [DataMember]
        public decimal open_rate { get; set; }
        [DataMember]
        public decimal bounce_rate { get; set; }
        [DataMember]
        public decimal click_rate { get; set; }
    }
}