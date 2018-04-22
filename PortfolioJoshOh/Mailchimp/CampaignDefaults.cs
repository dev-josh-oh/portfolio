using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace PortfolioJoshOh.Mailchimp
{
    [DataContract]
    public class CampaignDefaults
    {
        [DataMember]
        public string from_name { get; set; }
        [DataMember]
        public string from_email { get; set; }
        [DataMember]
        public string subject { get; set; }
        [DataMember]
        public string language { get; set; }
    }
}