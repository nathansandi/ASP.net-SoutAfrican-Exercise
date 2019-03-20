using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using ClosedXML.Excel;
using System.Configuration;
using System.Data.SqlClient;


namespace UberPanel
{
    public partial class analysis : System.Web.UI.Page
    {
        public String teste = "Teste aa";
        String config = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            string[] lines = System.IO.File.ReadAllLines(Server.MapPath("~/") + "DBConfig.txt");
            foreach (string line in lines)
            {
                config = config + line;
            }
            //Colect Statistics 
            using (SqlConnection con = new SqlConnection(config))
            {
                SqlCommand cmd = new SqlCommand("select distinct  isfixed as Fixes, count(*) as Number from SouthAfrican_Telephones group by isfixed");
                SqlCommand cmd1 = new SqlCommand("select distinct 'Incorrect Numbers' as Rejected ,count(*) as Number from Incorrect_SouthAfrican_Telephones ");
                using (SqlDataAdapter sda = new SqlDataAdapter())
                {
                    //Fill WS I
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    DataTable dtTable = new DataTable();
                    sda.Fill(dtTable);

                    gvCorrect.DataSource = dtTable;

                    gvCorrect.DataBind();
                    for (int i = 0; i < dtTable.Rows.Count; i++)
                    {
                        if (gvCorrect.Rows[i].Cells[0].Text == "&nbsp;")
                        {
                            gvCorrect.Rows[i].Cells[0].Text = "Correct Numbers";
                        }
                    }
                    //Fill WS II
                    cmd1.Connection = con;
                    sda.SelectCommand = cmd1;
                    DataTable dtTableIn = new DataTable();
                    sda.Fill(dtTableIn);
                    gvIncorrect.DataSource = dtTableIn;

                    gvIncorrect.DataBind();


                }
            }
        }
        protected void Download_Click(object sender, EventArgs e)
        {
            ExportExcel();
        }
        protected void ExportExcel()
        {
            //string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection(config))
            {
                    SqlCommand cmd = new SqlCommand("SELECT  id as Id,telephone as Telephone FROM SouthAfrican_Telephones where isfixed = ''");
                    SqlCommand cmd1 = new SqlCommand("SELECT id as Id, telephone as Telephone, isfixed as Error FROM SouthAfrican_Telephones where isfixed != ''");
                    SqlCommand cmd2 = new SqlCommand("SELECT id as Id, telephone as Telephone FROM Incorrect_SouthAfrican_Telephones");
                using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                            //Fill WS I
                            cmd.Connection = con;
                            sda.SelectCommand = cmd;
                            DataTable dt = new DataTable();       
                            sda.Fill(dt);
                            //Fill WS II
                            cmd1.Connection = con;
                            sda.SelectCommand = cmd1;
                            DataTable dt1 = new DataTable();
                            sda.Fill(dt1);
                            //Fill WS III
                            cmd2.Connection = con;
                            sda.SelectCommand = cmd2;
                            DataTable dt2 = new DataTable();
                            sda.Fill(dt2);

                    using (XLWorkbook wb = new XLWorkbook())
                            {
                                wb.Worksheets.Add(dt, "CorrectNumbers");
                                wb.Worksheets.Add(dt1, "CorrectedNumbers");
                                wb.Worksheets.Add(dt2, "IncorrectNumbers");

                                Response.Clear();
                                Response.Buffer = true;
                                Response.Charset = "";
                                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                                Response.AddHeader("content-disposition", "attachment;filename=SqlExport.xlsx");
                                using (MemoryStream MyMemoryStream = new MemoryStream())
                                {
                                    wb.SaveAs(MyMemoryStream);
                                    MyMemoryStream.WriteTo(Response.OutputStream);
                                    Response.Flush();
                                    Response.End();
                                }
                            }
                       
                    }
                
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}