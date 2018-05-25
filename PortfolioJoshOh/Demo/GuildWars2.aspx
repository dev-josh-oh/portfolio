<%@ Page Title="Guild Wars 2 API Demo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GuildWars2.aspx.cs" Inherits="PortfolioJoshOh.Demo.GuildWars2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    .dropdown-submenu {
        position: relative;
    }
    
    .dropdown-submenu .dropdown-menu {
        top: 0;
        left: 100%;
        margin-top: -1px;
    }

    .endpoint {
        color:black;
    }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            registerAPISubmitButtonOnClick();
            loadSavedAPIKeyFromLocalStorage();
            registerNestedDropdownClickHandler();
        });

        function registerNestedDropdownClickHandler()
        {
            $('.dropdown-submenu a.nestedSubMenu').on("click", function (e) {
                $(this).parent().siblings().children('.dropdown-menu').hide();
                $(this).next('ul').toggle();
                e.stopPropagation();
                e.preventDefault();
            });
        }

        function registerAPISubmitButtonOnClick() {
            $("input[id*='btnSubmitAPIKey']").on('click', function () {
                saveAPIKeyToLocalStorage();
                // This call could be considered as a healthcheck
                callGW2Endpoint('account', localStorage.getItem("GW2APIKey"));
            });
        }

        function saveAPIKeyToLocalStorage()
        {
            localStorage.setItem('GW2APIKey', $("input[id*='inpAPIKey']").val());
        }

        function loadSavedAPIKeyFromLocalStorage()
        {
            if (localStorage.getItem("GW2APIKey") != null)
                $("input[id*='inpAPIKey']").val(localStorage.getItem("GW2APIKey"));
        }

        function clearAPIKeyFromLocalStorage()
        {
            localStorage.removeItem("GW2APIKey");
        }

        function callGW2Endpoint(endpoint, apiKey) {
            // This will trip the same orgin policy check and fail the preflight call.
            // There may be a way to do a jsonp cross domain request similar to MailChimp (unofficial/ undocumented) but I can't figure it out.
            // mailchimp cross domain call example: https://stackoverflow.com/questions/21526408/mailchimp-subscribe-using-jquery-ajax
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //var response = $.ajax({
            //    headers: { 'Authorization': "Bearer" + apiKey },
            //    url: 'https://api.guildwars2.com/v2/' + endpoint,
            //    type: 'GET',
            //    dataType: 'json',
            //    crossDomain: true
            //});
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            var response = $.ajax('https://api.guildwars2.com/v2/' + endpoint + '?access_token=' + apiKey);
            response.done(function (data) {
                populateTableWithAPIResponseObject(data, "tblAPIResult", false);
                displayEndpointPicker();
            });
            response.fail(function (data) {
                alert("ERROR: API call failed.");
                populateTableWithAPIResponseObject(data.responseJSON, "tblAPIResult", true);
                hideEndpointPicker();
                clearAPIKeyFromLocalStorage();
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

        function displayEndpointPicker()
        {
            $("ul[id*='ulEndpointPicker']").show();
        }

        function hideEndpointPicker()
        {
            $("ul[id*='ulEndpointPicker']").hide();
        }

    </script>
    <div class="row">

        <h2><%: Title %></h2>

        <div class="col-md-8">
            <p>
                This demo will make basic GET calls to Guild Wars 2 (MMORPG) endpoints and return the result in a table format.
            </p>
            <p>
                Guild Wars 2 API Documentation: <a href="https://wiki.guildwars2.com/wiki/API:Main" target="_blank">https://wiki.guildwars2.com/wiki/API:Main</a>
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
    <h3>Guild Wars 2 API Explorer</h3>
    <br />
    <ul id="ulEndpointPicker" class="nav nav-tabs">
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Achievements<span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="#">achievements</a></li>
                <li><a href="#">achievements/daily</a></li>
                <li><a href="#">achievements/daily/tomorrow</a></li>
                <li><a href="#">achievements/groups</a></li>
                <li><a href="#">achievements/categories</a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Account<span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="#">account</a></li>
                <li><a href="#">account/achievements</a></li>
                <li><a href="#">account/bank</a></li>
                <li><a href="#">account/dungeons</a></li>
                <li><a href="#">account/dyes</a></li>
                <li><a href="#">account/finishers</a></li>
                <li class="dropdown-submenu">
                    <a class="nestedSubMenu" href="#"><span class="endpoint">account/home</span><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">account/home/cats</a></li>
                        <li><a href="#">account/home/nodes</a></li>
                    </ul>
                </li>
                <li><a href="#">account/inventory</a></li>
                <li><a href="#">account/masteries</a></li>
                <li><a href="#">account/minis</a></li>
                <li><a href="#">account/outfits</a></li>
                <li><a href="#">account/raids</a></li>
                <li><a href="#">account/recipes</a></li>
                <li><a href="#">account/skins</a></li>
                <li><a href="#">account/titles</a></li>
                <li><a href="#">account/wallet</a></li>
            </ul>
        </li>
        <li><a href="#">Characters</a></li>
        <li><a href="#">Tokeninfo</a></li>
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Game Mechanics<span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="#">masteries</a></li>
                <li><a href="#">outfits</a></li>
                <li><a href="#">pets</a></li>
                <li><a href="#">professions</a></li>
                <li><a href="#">races</a></li>
                <li><a href="#">specializations</a></li>
                <li><a href="#">skills</a></li>
                <li><a href="#">traits</a></li>
                <li><a href="#">legends</a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Guild<span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li class="dropdown-submenu">
                    <a class="nestedSubMenu" href="#"><span class="endpoint">guild</span><span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <span id="spnGuildIDListPlaceholder"></span>
                        <li class="dropdown-submenu">
                            <a class="nestedSubMenu" href="#">guild/[id1]<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">guild/[id1]/log</li>
                                <li><a href="#">guild/[id1]/members</li>
                                <li><a href="#">guild/[id1]/ranks</li>
                                <li><a href="#">guild/[id1]/stash</li>
                                <li><a href="#">guild/[id1]/tresury</li>
                                <li><a href="#">guild/[id1]/teams</li>
                                <li><a href="#">guild/[id1]/upgrades</li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a class="nestedSubMenu" href="#">guild/[id2]<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">guild/[id2]/log</li>
                                <li><a href="#">guild/[id2]/members</li>
                                <li><a href="#">guild/[id2]/ranks</li>
                                <li><a href="#">guild/[id2]/stash</li>
                                <li><a href="#">guild/[id2]/tresury</li>
                                <li><a href="#">guild/[id2]/teams</li>
                                <li><a href="#">guild/[id2]/upgrades</li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a class="nestedSubMenu" href="#">guild/[id3]<span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">guild/[id3]/log</li>
                                <li><a href="#">guild/[id3]/members</li>
                                <li><a href="#">guild/[id3]/ranks</li>
                                <li><a href="#">guild/[id3]/stash</li>
                                <li><a href="#">guild/[id3]/tresury</li>
                                <li><a href="#">guild/[id3]/teams</li>
                                <li><a href="#">guild/[id3]/upgrades</li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li><a href="#">emblem</a></li>
                <li><a href="#">guild/permissions</a></li>
                <li><a href="#">guild/search</a></li>
                <li><a href="#">guild/upgrades</a></li>
            </ul>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">Items<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="#">finishers</a></li>
                    <li><a href="#">items</a></li>
                    <li><a href="#">itemstats</a></li>
                    <li><a href="#">materials</a></li>
                    <li class="dropdown-submenu">
                        <a class="nestedSubMenu" href="#">recipes<span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">recipes</a></li>
                            <li><a href="#">recipes/search</a></li>
                        </ul>
                    </li>
                    <li><a href="#">skins</a></li>
                </ul>
            </li>
        </li>
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Map Info<span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="#">continents</a></li>
                <li><a href="#">maps</a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Misc.<span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="#">build</a></li>
                <li><a href="#">colors</a></li>
                <li><a href="#">currencies</a></li>
                <li><a href="#">dungeons</a></li>
                <li><a href="#">files</a></li>
                <li><a href="#">quaggans</a></li>
                <li><a href="#">minis</a></li>
                <li><a href="#">raids</a></li>
                <li><a href="#">titles</a></li>
                <li><a href="#">worlds</a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Story<span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li class="dropdown-submenu">
                    <a class="nestedSubMenu" href="#">backstory<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">backstory/questions</a></li>
                        <li><a href="#">backstory/answers</a></li>
                    </ul>
                </li>
                <li class="dropdown-submenu">
                    <a class="nestedSubMenu" href="#">stories<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">stories</a></li>
                        <li><a href="#">stories/seasons</a></li>
                    </ul>
                </li>
            </ul>
        </li>
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">sPvP<span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="#">pvp</a></li>
                <li><a href="#">pvp/ranks</a></li>
                <li class="dropdown-submenu">
                    <a class="nestedSubMenu" href="#">pvp/seasons<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">pvp/seasons</a></li>
                        <li><a href="#">pvp/seasons/leaderboards</a></li>
                    </ul>
                </li>
                <li><a href="#">pvp/seasons/leaderboards</a></li>
                <li><a href="#">pvp/stats</a></li>
                <li><a href="#">pvp/games</a></li>
                <li><a href="#">pvp/standings</a></li>
                <li><a href="#">pvp/amulets</a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">Trading Post<span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="#">commerce/listings</a></li>
                <li class="dropdown-submenu">
                    <a class="nestedSubMenu" href="#">commerce/exchange<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">commerce/exchange</a></li>
                        <li><a href="#">commerce/exchange/coins</a></li>
                        <li><a href="#">commerce/exchange/gems</a></li>
                    </ul>
                </li>
                <li><a href="#">commerce/prices</a></li>
                <li><a href="#">commerce/transactions</a></li>
            </ul>
        </li>
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#">WvW<span class="caret"></span></a>
            <ul class="dropdown-menu">
                <li><a href="#">wvw</a></li>
                <li><a href="#">wvw/abilities</a></li>
                <li><a href="#">wvw/matches</a></li>
                <li><a href="#">wvw/objectives</a></li>
                <li><a href="#">wvw/ranks</a></li>
                <li><a href="#">wvw/upgrades</a></li>
            </ul>
        </li>
    </ul>
    <hr />
    <br />
    <div class="row">
        <table id="tblAPIResult" class="table table-striped table-hover"></table>
    </div>
</asp:Content>
