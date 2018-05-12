<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PortfolioJoshOh._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h2>Welcome to Josh Oh's Portfolio</h2>
        <p class="lead">A showcase of my creations in ASP.NET</p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <a class="btn btn-success" href="Demo/Home.aspx">See my demos &raquo;</a>
        </div>
    </div>
    <br />
    <div class="row">
        <div class="col-md-4">
            <a class="btn btn-default" href="https://github.com/hire-josh-oh/portfolio" target="_blank">github for this entire website &raquo;</a>
        </div>
    </div>
    <div style="height:400px"></div>
</asp:Content>
