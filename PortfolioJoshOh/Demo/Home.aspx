<%@ Page Title="Demo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PortfolioJoshOh.Demo.Demo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <h2><%: Title %></h2>
        <div class="col-md-4">
            <h4>MailChimp API Integration Demo</h4>
            <p>
                MailChimp is an email marketing platform. This demo app will ping the MailChimp API and then retrieve the email list for the associated account.
            </p>
            <p>
                <a class="btn btn-default" href="Demo_MailChimp.aspx">See Demo &raquo;</a>
            </p>
        </div>
    </div>
    <hr />
    <div class="row">
        <div class="col-md-4">
            <h4>SQL Query Demo</h4>
            <p>
                Simple demo showing GET and POST operations. This one was done with zero postbacks.
                All requests are done through clientside AJAX calls. Even the tables are databound using jQuery instead of the .NET controls.
                Other notable remarks include usage of bootstrap classes, 3rd party jQuery validator plugin,
                Web API 2 to facilitate the AJAX requests and Entity Framework 6 to establish the ORM.
            </p>
            <p>
                <a class="btn btn-default" href="Demo_SQLQueries.aspx">See Demo &raquo;</a>
            </p>
        </div>
    </div>
</asp:Content>
