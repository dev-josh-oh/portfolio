<%@ Page Title="SQL Query Demo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Demo_SQLQueries.aspx.cs" Inherits="PortfolioJoshOh.Demo.Demo_SQLQueries" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">

        <h2><%: Title %>.</h2>

        <div class="col-md-12">
            <p>
                This demo will allow you to enter data into the employee table and retrieve the 2nd highest salary.
            </p>
            <p>
                The source code for this demo can be found here: <a href="https://github.com/hire-josh-oh/portfolio" target="_blank">https://github.com/hire-josh-oh/portfolio</a>
            </p>                
        </div>
    </div>

    <hr />

    <asp:Button ID="btnGetEmployeeRecord" CssClass="btn btn-default" runat="server" Text="Get top 10 paid employees" />

</asp:Content>
