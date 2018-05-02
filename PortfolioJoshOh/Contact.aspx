<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="PortfolioJoshOh.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <h2><%: Title %></h2>

    <div class="LI-profile-badge"  data-version="v1" data-size="small" data-locale="en_US" data-type="horizontal" data-theme="light" data-vanity="josh-oh-27123254"><a class="LI-simple-link" href='https://www.linkedin.com/in/josh-oh-27123254?trk=profile-badge'>Josh Oh</a></div>

    <address>
        <strong>Email:</strong><a href="mailto:hire.josh.oh@gmail.com">hire.josh.oh@gmail.com</a><br />
        <strong>Phone:</strong>719-232-2450
    </address>
    <script type="text/javascript" src="https://platform.linkedin.com/badges/js/profile.js" async defer></script>
</asp:Content>
