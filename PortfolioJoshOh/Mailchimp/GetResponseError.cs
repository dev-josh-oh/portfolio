using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace PortfolioJoshOh.MailChimp
{   
    [Serializable]
    [DataContract]
    public class GetResponseError
    {
        [DataMember]
        public string type { get; set; }
        [DataMember]
        public string title { get; set; }
        [DataMember]
        public int status { get; set; }
        [DataMember]
        public string detail { get; set; }
        [DataMember]
        public string instance { get; set; }
    }
}