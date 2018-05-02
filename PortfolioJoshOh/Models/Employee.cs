using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PortfolioJoshOh.Models
{
    public class Employee
    {
        public long EMPLOYEE_ID { get; set; }
        public string FIRST_NAME { get; set; }
        public string LAST_NAME { get; set; }
        public Decimal SALARY { get; set; }
    }
}