using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewEmployees : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindEmployees();
        }
    }

    private void BindEmployees(string department = "")
    {
        string connectionString = ConfigurationManager.ConnectionStrings["HRSystemConnection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand("GetEmployeesByDepartment", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            if (!string.IsNullOrEmpty(department))
            {
                cmd.Parameters.AddWithValue("@Department", department);
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvEmployees.DataSource = dt;
            gvEmployees.DataBind();
        }
    }

    protected void ddlFilterDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedDepartment = ddlFilterDepartment.SelectedValue;
        BindEmployees(selectedDepartment);
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string employeeId = btn.CommandArgument;
        Response.Redirect("EditEmployee.aspx?EmployeeID=" + employeeId);
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        string employeeId = btn.CommandArgument;

        string connectionString = ConfigurationManager.ConnectionStrings["HRSystemConnection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand("DeleteEmployee", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EmployeeID", employeeId);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        // Refresh the grid
        BindEmployees(ddlFilterDepartment.SelectedValue);
    }
}