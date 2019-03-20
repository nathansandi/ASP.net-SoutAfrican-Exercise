<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="analysis.aspx.cs" Inherits="UberPanel.analysis" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Analysis of Data</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h3>Statistic Data</h3>
            
            Correct Numbers:
            <br />
            <asp:GridView ID="gvCorrect" runat="server" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            </asp:GridView>
            <br />
            Incorrect Numbers:
            <br />
            <asp:GridView ID="gvIncorrect" runat="server" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            </asp:GridView>
            <br />


            <h3>Download Processed File</h3>
            <asp:LinkButton runat="server" id="Download" text="Download Results" OnClick="Download_Click" class="btn"  />
            <br/>


        </div>
    </form>
</body>
</html>
