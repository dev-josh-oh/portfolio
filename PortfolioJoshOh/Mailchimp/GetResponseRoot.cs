using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace PortfolioJoshOh.MailChimp
{
    [DataContract]
    public class GetResponseRoot
    {
        [DataMember]
        public string account_id { get; set; }
        [DataMember]
        public string login_id { get; set; }
        [DataMember]
        public string account_name { get; set; }
        [DataMember]
        public string email { get; set; }
        [DataMember]
        public string first_name { get; set; }
        [DataMember]
        public string last_name { get; set; }
        [DataMember]
        public string username { get; set; }
        [DataMember]
        public string avatar_url { get; set; }
        [DataMember]
        public string role { get; set; }
        [DataMember]
        public string member_since { get; set; }
        [DataMember]
        public string pricing_plan_type { get; set; }
        [DataMember]
        public string first_payment { get; set; }
        [DataMember]
        public string account_timezone { get; set; }
        [DataMember]
        public string account_industry { get; set; }
        [DataMember]
        public Contact contact { get; set; }
        [DataMember]
        public bool pro_enabled { get; set; }
        [DataMember]
        public string last_login { get; set; }
        [DataMember]
        public int total_subscribers { get; set; }
        [DataMember]
        public IndustryStats industry_stats { get; set; }
        [DataMember]
        public List<Link> _links { get; set; }
        [DataMember]
        public GetResponseError responseError { get; set; }
    }
}