<%@ Page Title="View Employees" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ViewEmployees.aspx.cs" Inherits="ViewEmployees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card { padding: 20px; border: 1px solid #ddd; border-radius: 5px; margin: 20px; }
        .form-group { margin-bottom: 15px; }
        .grid-view { width: 100%; border-collapse: collapse; margin-top: 15px; }
        .grid-view th, .grid-view td { padding: 8px; border: 1px solid #ddd; }
        .grid-view th { background-color: #f2f2f2; }
        .btn { padding: 5px 10px; margin: 2px; cursor: pointer; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card">
        <h2>Employee List</h2>
        
        <div class="form-group">
            <label>Filter by Department:</label>
            <asp:DropDownList ID="ddlFilterDepartment" runat="server" AutoPostBack="true" 
                OnSelectedIndexChanged="ddlFilterDepartment_SelectedIndexChanged" CssClass="form-control">
                <asp:ListItem Value="">All Departments</asp:ListItem>
                <asp:ListItem>HR</asp:ListItem>
                <asp:ListItem>IT</asp:ListItem>
                <asp:ListItem>Finance</asp:ListItem>
                <asp:ListItem>Marketing</asp:ListItem>
            </asp:DropDownList>
        </div>
        
        <asp:GridView ID="gvEmployees" runat="server" AutoGenerateColumns="False" CssClass="grid-view">
            <Columns>
                <asp:BoundField DataField="EmployeeID" HeaderText="ID" />
                <asp:BoundField DataField="FullName" HeaderText="Name" />
                <asp:BoundField DataField="Position" HeaderText="Position" />
                <asp:BoundField DataField="Department" HeaderText="Department" />
                <asp:BoundField DataField="Salary" HeaderText="Salary" DataFormatString="{0:C}" />
                <asp:BoundField DataField="HireDate" HeaderText="Hire Date" DataFormatString="{0:d}" />
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-primary" 
                            CommandArgument='<%# Eval("EmployeeID") %>' OnClick="btnEdit_Click" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger" 
                            CommandArgument='<%# Eval("EmployeeID") %>' OnClick="btnDelete_Click" 
                            OnClientClick="return confirm('Are you sure you want to delete this employee?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>