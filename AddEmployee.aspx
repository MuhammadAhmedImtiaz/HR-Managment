<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddEmployee.aspx.cs" Inherits="AddEmployee" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .error { color: red; }
        .success { color: green; font-weight: bold; }
        .form-group { margin-bottom: 15px; }
        .card { padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card">
        <h2>Add New Employee</h2>
        
        <div class="form-group">
            <asp:Label AssociatedControlID="txtFullName" runat="server">Full Name:</asp:Label>
            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFullName" 
                ErrorMessage="Name is required" CssClass="error" Display="Dynamic">*</asp:RequiredFieldValidator>
        </div>
        
        <div class="form-group">
            <asp:Label AssociatedControlID="txtPosition" runat="server">Position:</asp:Label>
            <asp:TextBox ID="txtPosition" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        
        <div class="form-group">
            <asp:Label AssociatedControlID="ddlDepartment" runat="server">Department:</asp:Label>
            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control">
                <asp:ListItem Value="">-- Select Department --</asp:ListItem>
                <asp:ListItem>HR</asp:ListItem>
                <asp:ListItem>IT</asp:ListItem>
                <asp:ListItem>Finance</asp:ListItem>
                <asp:ListItem>Marketing</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlDepartment"
                InitialValue="" ErrorMessage="Department is required" CssClass="error" Display="Dynamic">*</asp:RequiredFieldValidator>
        </div>
        
        <div class="form-group">
            <asp:Label AssociatedControlID="txtSalary" runat="server">Salary:</asp:Label>
            <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control" 
                placeholder="Enter amount (e.g., 50000 or 50000.00)"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSalary" 
                ErrorMessage="Salary is required" CssClass="error" Display="Dynamic">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtSalary"
                ValidationExpression="^\d+(\.\d{1,2})?$" 
                ErrorMessage="Please enter a valid decimal number (e.g., 50000 or 50000.50)"
                CssClass="error" Display="Dynamic">*</asp:RegularExpressionValidator>
        </div>
        
        <div class="form-group">
            <asp:Button ID="btnAddEmployee" runat="server" Text="Save Employee" 
                CssClass="btn btn-primary" OnClick="btnAddEmployee_Click" />
            <asp:ValidationSummary runat="server" CssClass="error" />
            <asp:Label ID="lblAddMessage" runat="server" CssClass="success" Visible="false"></asp:Label>
        </div>
    </div>
</asp:Content>