using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PortfolioJoshOh.MailChimp
{
    /// <summary>
    /// Error values that can be sent as a part of the header when making MailChimp API calls to force an error. For error handling testing.
    /// 
    /// For more details, see http://developer.mailchimp.com/documentation/mailchimp/guides/get-started-with-mailchimp-api-3/#errors
    /// </summary>
    public class XTriggerError
    {
        public const string _400BadRequest = "BadRequest";
        public const string _400InvalidAction = "InvalidAction;";
        public const string _400InvalidResource = "InvalidResource";
        public const string _400JSONParseError = "JSONParseError";
        public const string _401APIKeyMissing = "APIKeyMissing";
        public const string _401APIKeyInvalid = "APIKeyInvalid";
        public const string _403Forbidden = "Forbidden";
        public const string _403UserDisabled = "UserDisabled";
        public const string _403WrongDatacenter = "WrongDatacenter";
        public const string _404ResourceNotFound = "ResourceNotFound";
        public const string _405MethodNotAllowed = "MethodNotAllowed";
        public const string _414ResourceNestingTooDeep = "ResourceNestingTooDeep";
        public const string _422InvalidMethodOverride = "InvalidMethodOverride";
        public const string _422RequestedFieldsInvalid = "RequestedFieldsInvalid";
        public const string _429TooManyRequests = "TooManyRequests";
        public const string _500InternalServerError = "InternalServerError";
        public const string _503ComplianceRelated = "ComplianceRelated";
    }
}