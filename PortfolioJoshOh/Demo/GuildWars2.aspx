<%@ Page Title="Guild Wars 2 API Demo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GuildWars2.aspx.cs" Inherits="PortfolioJoshOh.Demo.GuildWars2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            registerAPISubmitButtonOnClick();
            loadSavedAPIKeyFromLocalStorage();
        });

        function registerAPISubmitButtonOnClick() {
            $("input[id*='btnSubmitAPIKey']").on('click', function () {
                saveAPIKeyToLocalStorage();
                callGW2Endpoint('account', localStorage.getItem("GW2APIKey"));
            });
        }

        function saveAPIKeyToLocalStorage() {
            localStorage.setItem('GW2APIKey', $("input[id*='inpAPIKey']").val());
        }

        function loadSavedAPIKeyFromLocalStorage() {
            $("input[id*='inpAPIKey']").val(localStorage.getItem("GW2APIKey"));
        }

        function callGW2Endpoint(endpoint, apiKey) {
            // This will trip the same orgin policy check and fail the preflight call.
            // There may be a way to do a jsonp cross domain request similar to MailChimp (unofficial/ undocumented) but I can't figure it out.
            // mailchimp cross domain call example: https://stackoverflow.com/questions/21526408/mailchimp-subscribe-using-jquery-ajax

            //var response = $.ajax({
            //    headers: { 'Authorization': "Bearer" + apiKey },
            //    url: 'https://api.guildwars2.com/v2/' + endpoint,
            //    type: 'GET',
            //    dataType: 'json',
            //    crossDomain: true
            //});

            var response = $.ajax('https://api.guildwars2.com/v2/' + endpoint + '?access_token=' + apiKey);
            response.done(function (data) {
                populateTableWithAPIResponseObject(data, "tblAPIResult", false);
            });
            response.fail(function (data) {
                alert("ERROR: API call failed.");
                populateTableWithAPIResponseObject(data.responseJSON, "tblAPIResult", true);
            })
        }

        function populateTableWithAPIResponseObject(data, tableID, isError) {
            insertBasicTable(data, tableID, isError);
        }

        // code taken from https://codereview.stackexchange.com/questions/77286/output-javascript-object-into-html-table-of-key-value-pairs-using-jquery
        function insertBasicTable(basic_data, insert_id, isError) {
            /* Insert the key/value pairs into a table element on the DOM.
    
            basic_data = object containing key/value pairs
            insert_id  = the id on the DOM to insert the table into 
    
            Intentionally not including closing tags in the jquery requests;
            http://stackoverflow.com/a/14737115/2355035 */

            table_id = '#' + insert_id;
            var array_length = Object.keys(basic_data).length;
            var array_obj_names = Object.keys(basic_data);
            var tagFontStyle = isError ? 'style="color:red; font-weight: bold"' : 'style="color:green; font-weight: bold"';

            // create the table header
            $(table_id).empty();
            $(table_id).append('<thead>');
            $(table_id).find('thead:last').append('<th>Key');
            $(table_id).find('thead:last').append('<th>Value');

            // begin the table body and iterate through key/value pairs
            $(table_id).append('<tbody>');
            for (var i = 0; i < array_length; i++) {
                var attr_name = array_obj_names[i];
                var tag = '<td ' + tagFontStyle + ' class="col-md-5">' + array_obj_names[i];
                var data = '<td>' + basic_data[attr_name];

                $(table_id).find('tbody:last').append('<tr>' + tag + data);
            }
        }

    </script>
    <div class="row">

        <h2><%: Title %></h2>

        <div class="col-md-8">
            <p>
                This demo will make basic GET calls to Guild Wars 2 (MMORPG) endpoints and return the result in a table format.
            </p>
            <p>
                The source code for this demo can be found here: <a href="https://github.com/hire-josh-oh/portfolio" target="_blank">https://github.com/hire-josh-oh/portfolio</a>
            </p>
        </div>
    </div>

    <hr />

    <p>
        To start, enter your Guild Wars 2 API key here. 
    </p>
    <div class="input-group col-md-8">
        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
        <input id="inpAPIKey" type="text" class="form-control" style="max-width: 800px;" name="inpAPIKey" placeholder="Guild Wars 2 API Key">
    </div>
    <input id="btnSubmitAPIKey" type="button" class="btn btn-success" value="Submit" />
    <br />
    <br />
    <div class="row">
        <table id="tblAPIResult" class="table table-striped table-hover"></table>
    </div>
</asp:Content>
