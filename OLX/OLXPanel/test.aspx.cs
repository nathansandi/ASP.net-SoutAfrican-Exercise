using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UberPanel
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Test_Click(object sender, EventArgs e)
        {
            String telephone = (form1.FindControl("tbTelephone") as TextBox).Text.Trim();
            var regexp = @"^((?:\+27|27)|0)(\d{2})-?(\d{3})-?(\d{4})$";
            String fix = "";
            if (telephone.StartsWith("8"))
            {
                telephone = "0" + telephone;
                fix =  "Initial zero added in the mobile number. ";

                //Fix the number digits to 10 digits 
                if (telephone.Length > 10)
                {
                    telephone = telephone.Substring(0, 10);
                    fix = "Initial zero added in the mobile number and Extra digits deleted.";
                }
               

            }
            if (telephone.StartsWith("2"))
            {
                if (telephone.Length > 11)
                {
                    telephone = telephone.Substring(0, 11);
                    fix = "Extra digits deleted";
                }
            }
            Match match = Regex.Match(telephone, regexp, RegexOptions.IgnoreCase);
            if (match.Success)
            {
                if (fix != "")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('The telephone is not right, the error is:" + fix + ". After apply a fix, the corrected number is:" + telephone + "');", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('The format is correct.');", true);
                }

            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('The format is wrong.');", true);
            }
        }
    }
}