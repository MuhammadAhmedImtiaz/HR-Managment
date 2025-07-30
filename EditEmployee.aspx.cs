using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EditEmployee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["EmployeeID"] != null)
            {
                int employeeId;
                if (int.TryParse(Request.QueryString["EmployeeID"], out employeeId))
                {
                    hdnEmployeeID.Value = employeeId.ToString();
                    LoadEmployeeData(employeeId);
                }
                else
                {
                    Response.Redirect("ViewEmployees.aspx");
                }
            }
            else
            {
                Response.Redirect("ViewEmployees.aspx");
            }
        }
    }

    private void LoadEmployeeData(int employeeId)
    {
        string connectionString = ConfigurationManager.ConnectionStrings["HRSystemConnection"].ConnectionString;

        try
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetEmployeeByID", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmployeeID", employeeId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtFullName.Text = reader["FullName"].ToString();
                    txtPosition.Text = reader["Position"].ToString();
                    ddlDepartment.SelectedValue = reader["Department"].ToString();
                    txtSalary.Text = Convert.ToDecimal(reader["Salary"]).ToString("0.00");
                }
                else
                {
                    lblMessage.Text = "Employee not found!";
                    lblMessage.CssClass = "error";
                    lblMessage.Visible = true;
                }
                reader.Close();
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error loading employee data: " + ex.Message;
            lblMessage.CssClass = "error";
            lblMessage.Visible = true;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["HRSystemConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    // Check for duplicate employee name (requirement E)
                    SqlCommand checkCmd = new SqlCommand("CheckEmployeeNameExists", conn);
                    checkCmd.CommandType = CommandType.StoredProcedure;
                    checkCmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                    checkCmd.Parameters.AddWithValue("@CurrentEmployeeID", Convert.ToInt32(hdnEmployeeID.Value));

                    conn.Open();
                    int duplicateCount = (int)checkCmd.ExecuteScalar();

                    if (duplicateCount > 0)
                    {
                        lblMessage.Text = "An employee with this name already exists!";
                        lblMessage.CssClass = "error";
                        lblMessage.Visible = true;
                        return;
                    }

                    // Update employee if no duplicates found
                    SqlCommand updateCmd = new SqlCommand("UpdateEmployee", conn);
                    updateCmd.CommandType = CommandType.StoredProcedure;

                    updateCmd.Parameters.AddWithValue("@EmployeeID", Convert.ToInt32(hdnEmployeeID.Value));
                    updateCmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                    updateCmd.Parameters.AddWithValue("@Position", txtPosition.Text.Trim());
                    updateCmd.Parameters.AddWithValue("@Department", ddlDepartment.SelectedValue);

                    // Parse salary with culture-invariant format
                    decimal salary;
                    if (decimal.TryParse(txtSalary.Text, System.Globalization.NumberStyles.Currency,
                        System.Globalization.CultureInfo.InvariantCulture, out salary))
                    {
                        updateCmd.Parameters.AddWithValue("@Salary", salary);
                    }
                    else
                    {
                        throw new FormatException("Please enter a valid salary amount");
                    }

                    updateCmd.ExecuteNonQuery();

                    lblMessage.Text = "Employee updated successfully!";
                    lblMessage.CssClass = "success";
                    lblMessage.Visible = true;
                }
            }
            catch (FormatException fex)
            {
                lblMessage.Text = "Invalid salary format: " + fex.Message;
                lblMessage.CssClass = "error";
                lblMessage.Visible = true;
            }
            catch (SqlException sqlEx)
            {
                lblMessage.Text = "Database error: " + sqlEx.Message;
                lblMessage.CssClass = "error";
                lblMessage.Visible = true;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.CssClass = "error";
                lblMessage.Visible = true;
            }
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("ViewEmployees.aspx");
    }
}