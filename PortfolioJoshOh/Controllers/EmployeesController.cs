using PortfolioJoshOh.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace PortfolioJoshOh.Controllers
{
    /* 
        Note about WebApi routing behavior. This is taken from:
        https://docs.microsoft.com/en-us/aspnet/web-api/overview/web-api-routing-and-actions/routing-and-action-selection
        HTTP Methods. The framework only chooses actions that match the HTTP method of the request, determined as follows:
        1. You can specify the HTTP method with an attribute: AcceptVerbs, HttpDelete, HttpGet, HttpHead, HttpOptions, HttpPatch, HttpPost, or HttpPut.
        2. Otherwise, if the name of the controller method starts with "Get", "Post", "Put", "Delete", "Head", "Options", or "Patch", then by convention the action supports that HTTP method.
        3. If none of the above, the method supports POST.
    */

    public class EmployeesController : ApiController
    {
        [HttpGet]
        [ActionName("default")]
        public List<EMPLOYEE> GetAllEmployees()
        {
            List<PortfolioJoshOh.EMPLOYEE> employeesFromDB = new List<EMPLOYEE>();
            //Querying with LINQ to Entities 
            using (var context = new PortfolioJoshOh.AzureSQLDBEntities())
            {
                employeesFromDB = context.EMPLOYEEs
                    .OrderByDescending(element => element.SALARY)
                    .ToList();
            }
            return employeesFromDB;
        }

        [HttpGet]
        [ActionName("getbyid")]
        public IHttpActionResult GetEmployeeByID(long employeeID)
        {
            var employee = "test";
            if (employee == null)
            {
                return NotFound();
            }
            return Ok();
        }

        [HttpGet]
        [ActionName("topfive")]
        public List<EMPLOYEE> GetTopFiveEarningEmployees()
        {
            List<EMPLOYEE> employeesFromDB = new List<EMPLOYEE>();
            employeesFromDB = this.GetAllEmployees().Take(5).ToList();
            return employeesFromDB;
        }

        //[HttpGet]
        //[ActionName("secondhighest")]
        //public IHttpActionResult GetEmployeeWithSecondHighestSalary()
        //{
        //    // TODO: get employee record with 2nd highest salary and pass it along in the Ok result
        //    return Ok();
        //}

        [HttpPost]
        [ActionName("post")]
        public IHttpActionResult PostEmployee(PortfolioJoshOh.Models.Employee newEmployee)
        {
            using (var context = new PortfolioJoshOh.AzureSQLDBEntities())
            {
                EMPLOYEE employeeInContext = new EMPLOYEE() { FIRST_NAME = newEmployee.FIRST_NAME, LAST_NAME = newEmployee.LAST_NAME, SALARY = newEmployee.SALARY };

                context.EMPLOYEEs.Add(employeeInContext);
                context.SaveChanges();
                // After SaveChanges, Employee ID is updated for the context employee object so we return the correct ID here
                newEmployee.EMPLOYEE_ID = employeeInContext.EMPLOYEE_ID;
            }
            return Ok(newEmployee);
        }

        [HttpPost]
        [ActionName("reset")]
        public IHttpActionResult PostResetTableToDefault()
        {
            using (var context = new PortfolioJoshOh.AzureSQLDBEntities())
            {
                context.Database.ExecuteSqlCommand("DELETE FROM [EMPLOYEE]");
                EMPLOYEE employeeInContext = new EMPLOYEE() { FIRST_NAME = "Gary", LAST_NAME = "Stu", SALARY = 54000 };
                context.EMPLOYEEs.Add(employeeInContext);
                employeeInContext = new EMPLOYEE() { FIRST_NAME = "John", LAST_NAME = "Everyman", SALARY = 64000 };
                context.EMPLOYEEs.Add(employeeInContext);
                employeeInContext = new EMPLOYEE() { FIRST_NAME = "Mary", LAST_NAME = "Sue", SALARY = 86000 };
                context.EMPLOYEEs.Add(employeeInContext);
                context.SaveChanges();
            }
            return Ok();
        }
    }
}
