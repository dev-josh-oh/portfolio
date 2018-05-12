<%@ Page Title="SQL Query Demo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SQLQueries.aspx.cs" Inherits="PortfolioJoshOh.Demo.Demo_SQLQueries" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">

        <h2><%: Title %></h2>

        <div class="col-md-12">
            <p>
                This demo will allow you to enter data into the employee table and retrieve the top 5 highest salary from the SQL database.
            </p>
            <p>
                The source code for this demo can be found here: <a href="https://github.com/hire-josh-oh/portfolio" target="_blank">https://github.com/hire-josh-oh/portfolio</a>
            </p>                
        </div>
    </div>

    <hr />

    <input id="btnGetEmployeeRecord" type="button" class="btn btn-primary" runat="server" onclick="getEmployees()" value="Get top 5 paid employees" />
    <input id="btnEnterEmployeeRecord" type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal" runat="server" value="Add Employee Record" />
    <input id="btnResetEmployeeTable" type="button" class="btn btn-danger navbar-right" data-toggle="modal" data-target="#dvResetEmployeeTableModal" runat="server" value="Reset Employee Table" />

    <!-- Add Employee Record Modal -->
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                <button id="btnTopCloseModal" type="button" class="close modalshutdown" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Add Employee Record</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="inpFirstName">First Name:</label>
                        <input id="inpFirstName" type="text" class="form-control" required />
                    </div>
                    <div class="form-group">
                        <label for="inpLastName">Last Name:</label>
                        <input id="inpLastName" type="text" class="form-control" required />
                    </div>
                    <div class="form-group">
                        <label for="inpSalary">Salary:</label>
                        <input id="inpSalary" type="text" class="form-control" required number="true" />
                    </div>
                </div>
                <div class="modal-footer">
                <button id="btnCloseModal" type="button" class="btn btn-default navbar-left modalshutdown" data-dismiss="modal">Close</button>
                <button id="btnSubmitEmployeeRecord" type="button" class="btn btn-success navbar-right" onclick="ValidateAndSubmitAddEmployForm(); return false;" value="Submit" />
                </div>
            </div>
        </div>
    </div>

    <!-- Reset Employee Table Modal -->
    <div id="dvResetEmployeeTableModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                <button id="btnResetEmployeeTableTopCloseModal" type="button" class="close modalshutdown" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Are you sure?</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <p>
                            By choosing yes, you will <span style="color:red">wipe out all added employees</span> and reset the table with default records.
                        </p>
                    </div>
                </div>
                <div class="modal-footer">
                <button id="btnResetEmployeeTableCloseModal" type="button" class="btn btn-default navbar-left modalshutdown" data-dismiss="modal">Close</button>
                <button id="btnResetEmployeeTableSubmit" type="button" class="btn btn-danger navbar-right" onclick="resetEmployeeTable(); return false;" value="Yes" />
                </div>
            </div>
        </div>
    </div>

    <div id="dvEmployees">
        <h2>Top 5 paid employees</h2>
        <table id="tbEmployees" class="table table-striped">
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Salary</th>
                </tr>
            </thead>
            <tbody id="tbodEmployees"></tbody>
        </table>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#dvEmployees").hide();
            $(".modalshutdown").on('click', function () {
                resetAddEmployeeInputFields();
            });
        });

        function getEmployees() {
            $("#dvEmployees").show();
            $('#tbodEmployees').empty();
            $(document).ready(function () {
                var uri = '/api/employees/topfive';
                $.getJSON(uri)
                    .done(function (data) {
                            $.each(data, function(key, item) {
                                var $tr = $('<tr>').append(
                                    $('<td>').text(item.EMPLOYEE_ID),
                                    $('<td>').text(item.FIRST_NAME),
                                    $('<td>').text(item.LAST_NAME),
                                    $('<td>').text(item.SALARY)
                                ).appendTo('#tbodEmployees');
                            });
                        });
                    });
        }

        function ValidateAndSubmitAddEmployForm() {
            var validator = $("form").validate({
                validClass: "has-success",
                errorClass: "has-error",
                highlight: function (element, errorClass, validClass) {
                    $(element).parent().addClass(errorClass).removeClass(validClass);
                },
                unhighlight: function (element, errorClass, validClass) {
                    $(element).parent().removeClass(errorClass);
                }
            });
            var isFirstNameValid = validator.element("input[id*='inpFirstName']");
            var isLastNameValid = validator.element("input[id*='inpLastName']");
            var isSalaryValid = validator.element("input[id*='inpSalary']");
            var isAllElementValid = true;
            isAllElementValid = isFirstNameValid
                && isLastNameValid
                && isSalaryValid;

            if (isAllElementValid) {
                // Add employee record to DB
                var newEmployee = {
                    first_name: $("input[id*='inpFirstName']").val(),
                    last_name: $("input[id*='inpLastName']").val(),
                    salary: $("input[id*='inpSalary']").val()
                }
                var response = $.ajax({
                    url: '/api/employees/post',
                    type: 'POST',
                    contentType: "application/json",
                    data: JSON.stringify(newEmployee)
                });
                response.done(function (data) {
                    getEmployees();
                    $("#btnCloseModal").click();
                    resetAddEmployeeInputFields();
                });
                response.fail(function (data) {
                    alert('failed to add employee. error message: ' + data.responseJSON.ExceptionMessage);
                });
            }
        }

        function resetAddEmployeeInputFields() {
            $("#inpFirstName").val("");
            $("#inpLastName").val("");
            $("#inpSalary").val("");
        }

        function resetEmployeeTable() {
            var response = $.ajax({
                url: '/api/employees/reset',
                type: 'POST',
                contentType: "application/json"
            });

            response.done(function (data) {
                // TODO: include the employee list in the response so we don't have to double dip the DB here
                getEmployees();
            });

            response.fail(function (data) {
                alert('failed to add employee. error message: ' + data.responseJSON.ExceptionMessage);
            });

            response.always(function (data) {
                $("#btnResetEmployeeTableCloseModal").click()
            });
        }
    </script>
</asp:Content>
