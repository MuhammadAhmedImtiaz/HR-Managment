using System;
using System.Web.UI;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            UpdateLoginStatus();
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Session["Username"] = "Admin";
        UpdateLoginStatus();
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session["Username"] = "";
        UpdateLoginStatus();
    }

    private void UpdateLoginStatus()
    {
        // Remove the semicolon at the end of this if statement!
        if (Session["Username"] != null && !string.IsNullOrEmpty(Session["Username"].ToString()))
        {
            lblLoginStatus.Text = "Welcome, " + Session["Username"].ToString();
            btnLogin.Visible = false;
            btnLogout.Visible = true;
        }
        else
        {
            lblLoginStatus.Text = "Please login";
            btnLogin.Visible = true;
            btnLogout.Visible = false;
        }
    }
}