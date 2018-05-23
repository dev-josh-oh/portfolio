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
        public List<Employee> GetAllEmployees()
        {
            List<Employee> webAPIEmployees = new List<Employee>();
            List<employee> listOfEmployeeEntities = new List<employee>();
            //Querying with LINQ to Entities 
            using (var context = new PortfolioJoshOh.NorthwindEntities())
            {
                listOfEmployeeEntities = context.employees
                    .OrderByDescending(element => element.salary)
                    .ToList();
            }
            webAPIEmployees = Employee.CopyFromEntity(listOfEmployeeEntities);
            return webAPIEmployees;
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
        public List<Employee> GetTopFiveEarningEmployees()
        {
            List<Employee> webAPIEmployee = new List<Employee>();
            webAPIEmployee = this.GetAllEmployees().Take(5).ToList();
            return webAPIEmployee;
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
            using (var context = new PortfolioJoshOh.NorthwindEntities())
            {
                employee employeeInContext = new employee() { first_name = newEmployee.FIRST_NAME, last_name = newEmployee.LAST_NAME, salary = newEmployee.SALARY };

                context.employees.Add(employeeInContext);
                context.SaveChanges();
                // After SaveChanges, Employee ID is updated for the context employee object so we return the correct ID here
                newEmployee.EMPLOYEE_ID = employeeInContext.id;
            }
            return Ok(newEmployee);
        }

        [HttpPost]
        [ActionName("reset")]
        public IHttpActionResult PostResetTableToDefault()
        {
            using (var context = new PortfolioJoshOh.NorthwindEntities())
            {
                // employee id ranging from 201 through 220 are from the northwind database and I want to preserve the original records.
                // deleting only user created rows which are employee id 221 and higher.
                context.Database.ExecuteSqlCommand("ALTER TABLE orders NOCHECK CONSTRAINT ALL;" +
                    "DELETE FROM employees WHERE id >= 221;" +
                    "ALTER TABLE orders CHECK CONSTRAINT ALL;");
                context.SaveChanges();
            }
            return Ok();
        }
    }
}
