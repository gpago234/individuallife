﻿<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PRG_LI_REQ_ENTRY_RPT.aspx.vb"
    Inherits="I_LIFE_PRG_LI_REQ_ENTRY_RPT" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" href="SS_ILIFE.css" type="text/css" />
    <link rel="stylesheet" href="calendar.css" />
    <link href="css/general.css" rel="stylesheet" type="text/css" />
    <link href="css/grid.css" rel="stylesheet" type="text/css" />
    <link href="css/rounded.css" rel="stylesheet" type="text/css" />

    <script src="jquery-1.11.0.js" type="text/javascript"></script>

    <script src="jquery.simplemodal.js" type="text/javascript"></script>

    <script language="JavaScript" src="calendar_eu.js" type="text/javascript"></script>

    <title></title>
</head>
<body onload="<%= FirstMsg %>">
    <form id="LifeReportsPrint" runat="server">
    <div>
    </div>
    <div class="newpage" style="margin-left: 20%!important; margin-right: 20%!important;
        width: 100%;">
        <table align="center" width="100%">
            <tr>
                <td>
                    <asp:Literal runat="server" Visible="false" ID="litMsgs"></asp:Literal>
                    <asp:Label runat="server" ID="Status" Font-Bold="true" ForeColor="Red" Visible="true"
                        Text="Status:"> </asp:Label>
                    <asp:Label runat="server" ID="Label1" Font-Bold="True" ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
        <div class="grid" style="width: 60%!important;">
            <div class="rounded">
                <div class="top-outer">
                    <div class="top-inner">
                        <div class="top">
                            <h2>
                                PRINT: Claims Reported Listing</h2>
                        </div>
                    </div>
                </div>
                <div class="mid-outer">
                    <div class="mid-inner">
                        <div class="mid">
                            <table class="tbl_menu_new">
                                <tr>
                                    <td colspan="2" class="myMenu_Title" align="center">
                                        <asp:Label ID="lblDesc1" runat="server" Text="List Print" Visible="False"></asp:Label>
                                        <br />
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Filter Option:
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="pFilterOption" runat="server">
                                            <asp:ListItem>-- Select Option --</asp:ListItem>
                                            <asp:ListItem Value="1">Effective Date</asp:ListItem>
                                            <asp:ListItem Value="2">Notification Date</asp:ListItem>
                                            <asp:ListItem Value="3">Entry Date</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Start Date :
                                    </td>
                                    <td>
                                        <asp:TextBox ID="sStartDate" runat="server" Width="150px" MaxLength="10"></asp:TextBox>

                                        <script language="JavaScript" type="text/javascript">
                                            new tcal({ 'formname': 'PRG_LI_REQ_ENTRY_1', 'controlname': 'sStartDate' });</script>

                                        dd/mm/yyyy
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        End Date :
                                    </td>
                                    <td>
                                        <asp:TextBox ID="sEndDate" runat="server" Width="150px" MaxLength="10"></asp:TextBox>

                                        <script language="JavaScript" type="text/javascript">
                                            new tcal({ 'formname': 'PRG_LI_REQ_ENTRY_1', 'controlname': 'sEndDate' });</script>

                                        dd/mm/yyyy
                                    </td>
                                </tr>
                                <tr style="display: none;">
                                    <td>
                                        Report Type
                                    </td>
                                    <td>
                                        <asp:RadioButtonList ID="rblTransType" runat="server">
                                            <asp:ListItem Text="Claims List" Value="PRG_LI_REQ_ENTRY_1"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr style="display: none;">
                                    <td colspan="2">
                                        <p>
                                            &nbsp;
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Button ID="butOK" runat="server" Text="OK" Style="height: 26px" />
                                        <asp:Button ID="butClose" runat="server" Text="Close" 
                                            PostBackUrl="~/I_LIFE/PRG_LI_REQ_ENTRY.aspx" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="bottom-outer">
                    <div class="bottom-inner">
                        <div class="bottom">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
