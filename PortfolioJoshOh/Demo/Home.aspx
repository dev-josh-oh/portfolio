<%@ Page Title="Demo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PortfolioJoshOh.Demo.Demo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <div class="row">

        <h2><%: Title %>.</h2>

        <div class="col-md-4">
            <h3>Mailchimp API Integration Demo</h3>
            <p>
                Mailchimp is an email marketing platform. This demo shows the basic mechanism of integrating with Mailchimp.
            </p>
            <p>
                <a class="btn btn-default" href="Demo_MailChimp.aspx">See Demo &raquo;</a>
            </p>
        </div>
    </div>

</asp:Content>
