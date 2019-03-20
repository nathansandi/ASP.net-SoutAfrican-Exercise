<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="UberPanel.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Test Single Telephone</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h4>Test Single Telephone</h4>
            Insert telephone Number here:
            <br />
            <asp:TextBox id="tbTelephone" runat="server" />
            <br />
            <asp:LinkButton runat="server" id="test" text="Click to test" OnClick="Test_Click" class="btn"  />
        </div>
    </form>
</body>
</html>
