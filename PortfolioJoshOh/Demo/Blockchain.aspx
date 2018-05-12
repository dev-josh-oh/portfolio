<%@ Page Title="Blockchain Demo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Blockchain.aspx.cs" Inherits="PortfolioJoshOh.Demo.Blockchain" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="row">

        <h2><%: Title %></h2>

        <div class="col-md-12">
            <p>
                <span class="glyphicon glyphicon-wrench" style="font-size:25px; vertical-align:sub;" ></span>
                This demo is currently under construction.
                <span class="glyphicon glyphicon-wrench" style="font-size:25px; vertical-align:sub;" ></span>
            </p>
            <p>
                Blockchain demo roadmap:
            </p>
            <ul>
                <li>
                    <b>Phase 1</b>
                    <ul>
                        <li>Ability to store data in blocks</li>
                        <li>Has digital signature that chains the blocks together</li>
                        <li>Proof of work mining to validate new blocks</li>
                        <li>Can check to see if data in the chain is valid and unchanged</li>
                    </ul>
                </li>
                <li>
                    <b>Phase 2</b>
                    <ul>
                        <li>Allows users to create wallets</li>
                        <li>Provide wallets with public and private keys using Elliptic-Curve cryptography</li>
                        <li>Secure transfer of funds by using a digital signature algorithm to prove ownership</li>
                        <li>Allow users to make transactions on the blockchain</li>
                    </ul>
                </li>
            </ul>
<%--            <p>
                The source code for this demo can be found here: <a href="https://github.com/hire-josh-oh/portfolio" target="_blank">https://github.com/hire-josh-oh/portfolio</a>
            </p>   
--%>
        </div>
    </div>
</asp:Content>
