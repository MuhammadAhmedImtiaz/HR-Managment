<%@ Page Title="Home" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card">
        <h2>Welcome to HR Management System</h2>
        <p>This system allows you to manage employee records efficiently. Use the navigation menu to:</p>
        <ul style="margin: 15px 0 15px 30px;">
            <li>Add new employees</li>
            <li>View and manage existing employee records</li>
            <li>Register new users with validation</li>
        </ul>
        <p>Select an option from the menu above to get started.</p>
    </div>
</asp:Content>