using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;

namespace UberPanel
{
    public partial class Default : System.Web.UI.Page
    {

        String config = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string[] lines = System.IO.File.ReadAllLines(Server.MapPath("~/") + "DBConfig.txt");
            foreach (string line in lines)
            {
                config = config + line;
            }
        }
        protected void UploadButton_Click(object sender, EventArgs e)
        {
            if (FileUploadControl.HasFile)
            {
                try
                {
                    String filename = Path.GetFileName(FileUploadControl.FileName);
                    if(filename.Split('.')[1] != "csv")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('The file update is not in the right format (.csv)');", true);
                    }
                    else {
                        FileUploadControl.SaveAs(Server.MapPath("~/") + "olx.csv");
                        readExcel(Server.MapPath("~/") + "olx.csv");
                        File.Delete(Server.MapPath("~/") + "olx.csv");
                    }
                }
                catch (Exception ex)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('Error: "+ex+"');", true);
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('No file updated!');", true);
            }
        }

        private void readExcel(string Location)
        {
            StreamReader rd = new StreamReader(@Location);
            try
            {
                using (SqlConnection con = new SqlConnection(config)) {
                    var regexp = @"^((?:\+27|27)|0)(\d{2})-?(\d{3})-?(\d{4})$";

                    
                    //StreamReader rd = new StreamReader(@Location);
                   
                    string line = null;
                    string[] separatedLine = null;
                    int inC = 0;
                    con.Open();
                    int errorCount = 0;
                    String linesError = "But there are the follow lines with errors: ";
                    while ((line = rd.ReadLine()) != null)
                    {
                        separatedLine = line.Split(',');
                        //Treat date time Variable for inputs
                     
                            inC++;
                            String id = separatedLine[0].Replace("/", "-");
                            String telephone = separatedLine[1].Replace("/", "-");
                            String fix = "";
                            if (telephone.StartsWith("8"))
                            {
                                telephone = "0" + telephone;
                                fix = "Initial zero added in the mobile number";

                                //Fix the number digits to 10 digits 
                                if (telephone.Length > 10)
                                {
                                    telephone = telephone.Substring(0, 10);
                                    fix = "Initial zero added in the mobile number + Extra digits deleted";
                                }

                            }
                            if (telephone.StartsWith("2"))
                            {
                                if(telephone.Length > 11)
                                {
                                    telephone = telephone.Substring(0, 11);
                                    fix = "Extra digits deleted";
                                }
                            }
                        Match match = Regex.Match(telephone, regexp, RegexOptions.IgnoreCase);
                        //Make sure the line is a date
                      
                        if (id != "" && id != ""  &&
                            telephone != "" && telephone != "" ) 
                         {
                                
                                try {
                                    if (match.Success)
                                    {
                                        String Querry = "INSERT INTO [dbo].[SouthAfrican_Telephones]" +
                                                                       "(" +
                                                                       "[ID]," +
                                                                       "[TELEPHONE]," +
                                                                       "[ISFIXED])" +
                                                                 "VALUES" +
                                                                       "( " +
                                                                       "'" + id.ToString() + "'" +
                                                                      ",'" + telephone.ToString() + "'" +
                                                                      ",'" + fix + "'" +
                                                                              ")";
                                        SqlCommand sqlCmd = new SqlCommand(Querry, con);
                                        sqlCmd.ExecuteNonQuery();
                                }
                                else
                                {
                                    String Querry = "INSERT INTO [dbo].[Incorrect_SouthAfrican_Telephones]" +
                                                                       "(" +
                                                                       "[ID]," +
                                                                       "[TELEPHONE])" +                                                                       
                                                                 "VALUES" +
                                                                       "( " +
                                                                       "'" + id.ToString() + "'" +
                                                                      ",'" + telephone.ToString() + "'" +
                                                                        ")";
                                    SqlCommand sqlCmd = new SqlCommand(Querry, con);
                                    sqlCmd.ExecuteNonQuery();
                                }
                                }
                                catch (Exception ex)
                                {
                                    if (!id.ToUpper().Contains("ID"))
                                    {
                                        ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('Database Error: "+ex+"');", true);
                                    }
                                }
                        }
                        else
                        {
                            if (id != "id") { 
                                errorCount++;
                                linesError = linesError + "" + inC + "  ";
                            }

                        }
                       
                        
                    }
                    rd.Close();
                    Server.Transfer("analysis.aspx");
                }
            }
            catch (Exception ex)
            {
                String errorSTR =ex.Message.ToString();
                ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('Error: Please check database connection or template file.  Details: "+ errorSTR.Replace("'","") + ".');", true);
                rd.Close();
            }
            
            

        }
       
    }

}