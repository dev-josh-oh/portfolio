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
        public Decimal? SALARY { get; set; }

        /// <summary>
        /// takes in a list of employee entities and returns an equivalent list of Web API model of employee.
        /// </summary>
        /// <param name="listOfEntityEmployees"></param>
        /// <returns>List<PortfolioJoshOh.Models.Employee></returns>
        public static List<Employee> CopyFromEntity(List<employee> listOfEntityEmployees)
        {
            List<Employee> result = new List<Employee>();
            foreach (employee emp in listOfEntityEmployees)
            {
                result.Add(new Employee { EMPLOYEE_ID = emp.id, FIRST_NAME = emp.first_name, LAST_NAME = emp.last_name, SALARY = emp.salary });
            }
            return result;
        }
    }
}