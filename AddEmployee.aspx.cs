using System.Configuration;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddEmployee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblAddMessage.Visible = false;
        }
    }

    protected void btnAddEmployee_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["HRSystemConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("InsertEmployee", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Position", txtPosition.Text.Trim());
                    cmd.Parameters.AddWithValue("@Department", ddlDepartment.SelectedValue);

                    // Fixed decimal parsing with culture-invariant format
                    decimal salary;
                    if (decimal.TryParse(txtSalary.Text, System.Globalization.NumberStyles.Currency,
                        System.Globalization.CultureInfo.InvariantCulture, out salary))
                    {
                        cmd.Parameters.AddWithValue("@Salary", salary);
                    }
                    else
                    {
                        throw new FormatException("Please enter a valid salary amount");
                    }

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    // Show success message
                    lblAddMessage.Text = "Employee added successfully!";
                    lblAddMessage.CssClass = "alert alert-success";
                    lblAddMessage.Visible = true;

                    // Clear form
                    txtFullName.Text = "";
                    txtPosition.Text = "";
                    txtSalary.Text = "";
                    ddlDepartment.SelectedIndex = 0;
                }
            }
            catch (FormatException fex)
            {
                lblAddMessage.Text = "Invalid salary format: " + fex.Message;
                lblAddMessage.CssClass = "alert alert-danger";
                lblAddMessage.Visible = true;
            }
            catch (SqlException sqlEx)
            {
                lblAddMessage.Text = "Database error: " + sqlEx.Message;
                lblAddMessage.CssClass = "alert alert-danger";
                lblAddMessage.Visible = true;
            }
            catch (Exception ex)
            {
                lblAddMessage.Text = "Error: " + ex.Message;
                lblAddMessage.CssClass = "alert alert-danger";
                lblAddMessage.Visible = true;
            }
        }
    }
}