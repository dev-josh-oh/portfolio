using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace PortfolioJoshOh.Mailchimp
{
    [DataContract]
    public class Link
    {
        [DataMember]
        public string rel { get; set; }
        [DataMember]
        public string href { get; set; }
        [DataMember]
        public string method { get; set; }
        [DataMember]
        public string targetSchema { get; set; }
        [DataMember]
        public string schema { get; set; }
    }
}