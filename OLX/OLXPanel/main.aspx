<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="UberPanel.Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Olx - Technical Assessment</title>
</head> 

 
<body>
    <form id="form1" runat="server">
        <h4>Insert CSV File</h4>
        <div>
                <asp:FileUpload id="FileUploadControl" runat="server" />  
                <br /><br />
        </div>
        <div>
                <asp:LinkButton runat="server" id="UploadButton" text="Upload" OnClick="UploadButton_Click" class="btn"  />
        </div>
    </form>
</body>


</html>
