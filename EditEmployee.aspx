<%@ Page Title="Edit Employee" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="EditEmployee.aspx.cs" Inherits="EditEmployee" %>

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
        <h2>Edit Employee</h2>
        
        <asp:HiddenField ID="hdnEmployeeID" runat="server" />
        
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
            <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtSalary" 
                ErrorMessage="Salary is required" CssClass="error" Display="Dynamic">*</asp:RequiredFieldValidator>
            <asp:CompareValidator runat="server" ControlToValidate="txtSalary" 
                Operator="DataTypeCheck" Type="Currency" ErrorMessage="Must be a valid number" 
                CssClass="error" Display="Dynamic">*</asp:CompareValidator>
        </div>
        
        <div class="form-group">
            <asp:Button ID="btnUpdate" runat="server" Text="Update Employee" 
                CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                CssClass="btn btn-secondary" OnClick="btnCancel_Click" CausesValidation="false" />
            <asp:ValidationSummary runat="server" CssClass="error" />
            <asp:Label ID="lblMessage" runat="server" CssClass="success" Visible="false"></asp:Label>
        </div>
    </div>
</asp:Content>