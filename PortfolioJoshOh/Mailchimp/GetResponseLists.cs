using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace PortfolioJoshOh.Mailchimp
{
    [DataContract]
    public class GetResponseLists
    {
        [DataMember]
        public List<MailchimpList> lists { get; set; }
        [DataMember]
        public int total_items { get; set; }
        [DataMember]
        public List<Link> _links { get; set; }
    }

    [DataContract]
    public class MailchimpList
    {
        [DataMember]
        public string id { get; set; }
        [DataMember]
        public int web_id { get; set; }
        [DataMember]
        public string name { get; set; }
        [DataMember]
        public Contact contact { get; set; }
        [DataMember]
        public string permission_reminder { get; set; }
        [DataMember]
        public bool use_archive_bar { get; set; }
        [DataMember]
        public CampaignDefaults campaignDefaults { get; set; }
        [DataMember]
        public string notify_on_subscribe { get; set; }
        [DataMember]
        public string notify_on_unsubscribe { get; set; }
        [DataMember]
        public string date_created { get; set; }
        [DataMember]
        public int list_rating { get; set; }
        [DataMember]
        public bool email_type_option { get; set; }
        [DataMember]
        public string subscribe_url_short { get; set; }
        [DataMember]
        public string subscribe_url_long { get; set; }
        [DataMember]
        public string beamer_address { get; set; }
        [DataMember]
        public string visibility { get; set; }
        [DataMember]
        public List<string> modules { get; set; }
        [DataMember]
        public Stats stats { get; set; }
        [DataMember]
        public List<Link> _links { get; set; }
    }
}