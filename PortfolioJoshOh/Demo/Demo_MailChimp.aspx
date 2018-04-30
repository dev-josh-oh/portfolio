<%@ Page Title="MailChimp API Demo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Demo_MailChimp.aspx.cs" Inherits="PortfolioJoshOh.Demo.Demo_MailChimp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">

        <h2><%: Title %>.</h2>

        <div class="col-md-12">
                This demo will accept a MailChimp API key and do the following:
                <ul>
                    <li>call the root '/' endpoint for a healthcheck (ping)</li>
                    <li>call the '/lists' endpoint to retrieve the email lists and render the results on this page</li>
                </ul>
                <p>
                    How this demo works:
                    <br />
                    <iframe width="560" height="315" src="https://www.youtube.com/embed/e5WUYIxMFQo" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
                </p>
                <p>
                    The source code for this demo can be found here: <a href="https://github.com/hire-josh-oh/portfolio" target="_blank">https://github.com/hire-josh-oh/portfolio</a>
                </p>
        </div>
    </div>

    <hr />

    <asp:UpdatePanel ID="upAPI" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div id="divAPIKey" class="row">
                <p>
                    <label id="lblAPIKey" runat="server">API Key: </label>
                    <asp:TextBox ID="txtAPIKey" runat="server"></asp:TextBox>
                    <asp:Button ID="btnSubmitAPIKey" CssClass="btn btn-default" runat="server" Text="Submit" OnClick="btnSubmitAPIKey_Click" />
                </p>
            </div>
            <div id="divPingResult" class="row" style="display:none" runat="server">
                <label id="lblPingResult" runat="server"></label>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:UpdatePanel ID="upGetLists" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div id="divGetLists" class="row" style="display:none" runat="server">
                <hr />
                <asp:Button ID="btnGetLists" CssClass="btn btn-default" runat="server" Text="Get Lists" OnClick="btnGetLists_Click" />
                <div id="divGetListsResults" style="display:none; padding-top:20px;" runat="server">
                    <asp:GridView
                        ID="gvListResults"
                        AutoGenerateColumns="false"
                        SkinID="Professional"
                        Font-Name="Verdana"
                        Font-Size="10pt" Cellpadding="4"
                        HeaderStyle-BackColor="#444444"
                        HeaderStyle-ForeColor="White"
                        AlternatingRowStyle-BackColor="#dddddd"
                        runat="server">
                        <Columns>
                            <asp:BoundField DataField="id" HeaderText="ID" />
                            <asp:BoundField DataField="name" HeaderText="Name" />
                            <asp:BoundField DataField="date_created" HeaderText="Date Created" />
                            <asp:BoundField DataField="stats.member_count" HeaderText="Member Count" />
                            <asp:BoundField DataField="stats.last_sub_date" HeaderText="Last Sub Date" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script type="text/javascript">
        function showPingResult() {
            $("div[id*='divPingResult']").fadeIn(1000, function () {
                showGetListsDiv();
            });
        }
        function showGetListsDiv() {
            $("div[id*='divGetLists']").fadeIn(1000);
        }
    </script>



    <style>
    .overlay {
        position: fixed;
        width: 100%;
        height: 100%;
        left: 0;
        top: 0;
        background: rgba(51,51,51,0.7);
        z-index: 10;
    }
    </style>
    <div id="divOverlay" class="overlay" style="display:none" ></div>
</asp:Content>
