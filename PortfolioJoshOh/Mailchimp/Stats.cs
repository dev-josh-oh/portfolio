using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Web;

namespace PortfolioJoshOh.MailChimp
{
    [DataContract]
    public class Stats
    {
        [DataMember]
        public int member_count { get; set; }
        [DataMember]
        public int unsubscribe_count { get; set; }
        [DataMember]
        public int cleaned_count { get; set; }
        [DataMember]
        public int member_count_since_send { get; set; }
        [DataMember]
        public int unsubscribe_count_since_send { get; set; }
        [DataMember]
        public int cleaned_count_since_send { get; set; }
        [DataMember]
        public int campaign_count { get; set; }
        [DataMember]
        public string campaign_last_scent { get; set; }
        [DataMember]
        public int merge_field_count { get; set; }
        [DataMember]
        public decimal avg_sub_rate { get; set; }
        [DataMember]
        public decimal avg_unsub_rate { get; set; }
        [DataMember]
        public decimal target_sub_rate { get; set; }
        [DataMember]
        public decimal open_rate { get; set; }
        [DataMember]
        public decimal click_rate { get; set; }
        [DataMember]
        public string last_sub_date { get; set; }
        [DataMember]
        public string last_unsub_date { get; set; }
    }
}