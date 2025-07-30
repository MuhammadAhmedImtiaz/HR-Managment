<%@ Page Title="About" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card">
        <h2>About HR System</h2>
        <p>This HR Management System was developed for PMAS Arid Agriculture University as part of the Advanced Programming course.</p>
        <p>It demonstrates the implementation of:</p>
        <ul style="margin: 15px 0 15px 30px;">
            <li>Database operations with SQL Server</li>
            <li>ASP.NET Web Forms</li>
            <li>Master Page implementation</li>
            <li>Session management for login/logout</li>
            <li>Form validation controls</li>
        </ul>
        <p>The system allows administrators to efficiently manage employee records and user registrations.</p>
    </div>
</asp:Content>