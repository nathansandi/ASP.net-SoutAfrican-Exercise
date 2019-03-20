<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UberPanel.Default" %>


<!DOCTYPE html>



<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head> 
<!-- this should go after your </body> -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/momentjs/2.14.1/moment.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css">

  <link href="StyleSheet1.css" rel="stylesheet" />
 
<body>
    <form id="form1" runat="server">

          
        <div class="modal fade" id="modalInsert" tabindex="-1" role="dialog" aria-labelledby="modalInsert"
          aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header text-center">
                <h4 class="modal-title w-100 font-weight-bold">Insert data here</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body mx-3">
                <div class="md-form mb-5">
                  <i class="fas fa-envelope prefix grey-text input-group date"></i>
                  <input type='text' class="form-control" id="ipStrDate" name="ipStrDate" required="required" />
                  <label data-error="wrong" data-success="right" ">Start Date</label>
                </div>

                <div class="md-form mb-5">
                  <i class="fas fa-envelope prefix grey-text input-group date"></i>
                  <input type='text' class="form-control" id="ipEndDate"  name="ipEndDate" required="required"/>
                  <label data-error="wrong" data-success="right" ">End Date</label>
                </div>

                <div class="md-form mb-5">
                  <i class="fas fa-envelope prefix grey-text"></i>
                  <input type="text" id="ipCategory" name="ipCategory" class="form-control validate" required="required" />
                  <label data-error="wrong" data-success="right" ">Category</label>
                </div>

                <div class="md-form mb-5">
                  <i class="fas fa-envelope prefix grey-text"></i>
                  <input type="text" id="ipStart" name="ipStart" class="form-control validate" required="required" />
                  <label data-error="wrong" data-success="right" ">Start</label>
                </div>

                <div class="md-form mb-5">
                  <i class="fas fa-envelope prefix grey-text"></i>
                  <input type="text" id="ipStop" name="ipStop" class="form-control validate" required="required" />
                  <label data-error="wrong" data-success="right" ">Stop</label>
                </div>

                <div class="md-form mb-5">
                  <i class="fas fa-envelope prefix grey-text"></i>
                  <input type="number" name="ipMiles" step="0.01" min="0" max="1000" id="ipMiles" class="form-control validate" required="required" />
                  <label data-error="wrong" data-success="right" ">Miles</label>
                </div>

                <div class="md-form mb-5">
                  <i class="fas fa-envelope prefix grey-text"></i>
                  <input type="text" id="ipPurpose" name="ipPurpose" class="form-control validate" />
                  <label data-error="wrong" data-success="right" ">Purpose</label>
                </div>

              </div>
              <div class="modal-footer d-flex justify-content-center">
                <asp:Button ID="btnSubmit" Text="Submit" runat="server" OnClick="Submit" class="btn btn-success" />
         
              </div>
            </div>
          </div>
        </div>


         <div class="modal fade" id="modalUploadFile" tabindex="-1" role="dialog" aria-labelledby="modalInsert"
          aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header text-center">
                <h4 class="modal-title w-100 font-weight-bold">Insert data here</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" >
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body mx-3">
                <asp:FileUpload id="FileUploadControl" runat="server" />
                
                <br /><br />
              </div>
              <div class="modal-footer d-flex justify-content-center">
                
                  <asp:LinkButton runat="server" id="UploadButton" text="Upload" OnClick="UploadButton_Click" class="btn btn-default btn-rounded mb-4 btn-success"  />
         
              </div>
            </div>
          </div>
        </div>

        <h4 class="modal-title w-100 font-weight-bold">Data from database</h4>
        <br />  
        <div class="table-responsive">
            <asp:Label ID="lblSuccess" Text="" runat="server" ForeColor ="Green" />
            <asp:Label ID="lblError" Text="" runat="server" ForeColor ="Red" />
        </div>
            
            <asp:GridView ID="gvUberData" runat="server" ShowHeaderWhenEmpty ="true" BackColor="White"  
                AutoGenerateColumns="false" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CssClass="table table-bordered table-condensed"
                CellPadding="4" ForeColor="Black" GridLines="Horizontal" OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                OnRowEditing="gvUberData_RowEditing" OnRowCancelingEdit="gvUberData_RowCancelingEdit" OnRowUpdating ="gvUberData_RowUpdating" OnRowDeleting="gvUberData_RowDeleting" AllowPaging="true" OnPageIndexChanging="gdview_PageIndexChanging">
                <PagerStyle HorizontalAlign="Center" CssClass ="pagination-ys"/>
                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                
                <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                <SortedDescendingHeaderStyle BackColor="#242121" />
                <Columns> 
                    <asp:TemplateField HeaderText ="ID" Visible ="false">
                        <ItemTemplate>
                            <asp:TextBox ID="ID" Text='<%# Eval("ID") %>' runat="server" Enabled ="false" Visible ="false"></asp:TextBox>
                        </ItemTemplate>
                         <EditItemTemplate>
                            <asp:TextBox ID="ID" Text='<%# Eval("ID") %>' runat="server" Enabled ="false" Visible ="false"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Start Date*">
                        <ItemTemplate>
                            <asp:label Text='<%# Eval("START_DATE","{0:yyyy-MM-dd HH:mm:ss}") %>' runat="server"></asp:label>
                        </ItemTemplate> 
                        <EditItemTemplate>
                            <asp:TextBox ID="cldStartDate" Text='<%# Eval("START_DATE","{0:yyyy-MM-dd HH:mm:ss}") %>' runat="server"  ></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="End Date*">
                        <ItemTemplate>
                            <asp:label Text='<%# Eval("END_DATE","{0:yyyy-MM-dd HH:mm:ss}") %>' runat="server"></asp:label>
                        </ItemTemplate> 
                        <EditItemTemplate>
                            <asp:TextBox ID="cldEndDate" Text='<%# Eval("END_DATE","{0:yyyy-MM-dd HH:mm:ss}") %>' runat="server"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Category*">
                        <ItemTemplate>
                            <asp:label Text='<%# Eval("CATEGORY") %>' runat="server"></asp:label>
                        </ItemTemplate> 
                        <EditItemTemplate>
                            <asp:TextBox ID="txtCategory" Text='<%# Eval("CATEGORY") %>' runat="server"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Start*">
                        <ItemTemplate>
                            <asp:label Text='<%# Eval("START") %>' runat="server"></asp:label>
                        </ItemTemplate> 
                        <EditItemTemplate>
                            <asp:TextBox ID="txtStart" Text='<%# Eval("START") %>' runat="server"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Stop*">
                        <ItemTemplate>
                            <asp:label Text='<%# Eval("STOP") %>' runat="server"></asp:label>
                        </ItemTemplate> 
                        <EditItemTemplate>
                            <asp:TextBox ID="txtStop" Text='<%# Eval("STOP") %>' runat="server"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText ="Miles*">
                        <ItemTemplate>
                            <asp:label Text='<%# Eval("MILES") %>' runat="server"></asp:label>
                        </ItemTemplate> 
                        <EditItemTemplate>
                           <asp:TextBox ID="txtMiles" Text='<%# Eval("MILES") %>' runat="server" ></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText ="Purpose">
                        <ItemTemplate>
                            <asp:label Text='<%# Eval("PURPOSE") %>' runat="server"></asp:label>
                        </ItemTemplate> 
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPurpose" Text='<%# Eval("PURPOSE") %>' runat="server"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandName="Edit" class="btn btn-default btn-rounded mb-4 btn-success" />
                            <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandName="Delete" class="btn btn-default btn-rounded mb-4 btn-danger" />
                        </ItemTemplate> 
                        <EditItemTemplate>
                           <asp:LinkButton ID="lnkUpd" runat="server" Text="Update" CommandName="Update"  class="btn btn-default btn-rounded mb-4 btn-success"/>
                           <asp:LinkButton ID="lnkCancel" runat="server" Text="Cancel" CommandName="Cancel"  class="btn btn-default btn-rounded mb-4 btn-danger" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns> 
            </asp:GridView>
        <h1">*Mandatory</h1>
        <br /> 
        <div class="text-center">
          <a href="" class="btn btn-default btn-rounded mb-4 btn-success" data-toggle="modal"  data-target="#modalInsert">Add new data</a>
        </div>  
        <br />
         <div class="text-center">
          <a href="" class="btn btn-default btn-rounded mb-4 btn-success" data-toggle="modal"  data-target="#modalUploadFile">Upload CSV File</a>
        </div>  

        <script>
          $(function () {
            $('#ipStrDate').datetimepicker();
         });
        </script>
        <script>
          $(function () {
            $('#ipEndDate').datetimepicker();
         });
        </script>
       
       

        
    </form>
</body>

 <script type="text/javascript">
    function CallButtonEvent() {
        document.getElementById("<%=btnSubmit %>").click();
        
    }
</script>

</html>
