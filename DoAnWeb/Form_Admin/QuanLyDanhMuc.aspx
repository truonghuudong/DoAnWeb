<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_Admin.master" AutoEventWireup="true" CodeFile="QuanLyDanhMuc.aspx.cs" Inherits="Form_Admin_QuanLyDanhMuc" %>
<title>Danh mục</title>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .title_danhmuc{
            padding:10px;
            background-color:var(--while-color);
            font-size:1.5rem;
            box-shadow:rgba(0,0,0,0.3) 1px 1px;
        }
        .btn_gridview{
            border:none;
            margin:0;
            font-size:2rem;
        }
        .btn_gridview:hover{
            background-color:var(--primary-color);
        }
        .tendanhmuc-link{
            text-decoration:none;
        }
        /*form modal layout*/
        .form__modal{
            position:fixed;
            top:0;
            bottom:0;
            left:0;
            right:0;
            /*min-height:100%;
            min-width:100%;*/
            display:flex;
        }
        .modal-overlay{
            position:absolute;
            width:100%;
            height:100%;
            background-color:rgba(0,0,0,0.4);
        }
        .modal-body{
            padding:5px;
            margin:auto;
            background-color:var(--while-color);
            z-index:1;
            border-radius:5px;
        }
        .modal-inner{
            align-items:center;
            width:290px;
        }
        .danhmuc_title{
            font-size:2rem;
            padding:15px 0px 10px 0px;
            color:var(--primary-color);
            text-align:center;
        }
        .danhmuc_ibtn{
            text-align:center;
        }
        .ibtn_DanhMuc{
            width:200px;
            height:200px;
        }
        .danhmuc_txt{
            margin-top:15px;
            text-align:center;
        }
        .txt_DanhMuc{
            width:100%;
            text-align:center;
            font-size:1.5rem;
        }
        .danhmuc_btn{
            margin-top:15px;
            text-align:center;
        }
        .btn_danhmuc:hover{
            background-color:var(--primary-color);
        }
        .danhmuc_thongbao{
            margin-top:5px;
            text-align:center;
            font-size:1.5rem;
            color:red;
        }
        /*.danhmuc a{
            text-decoration:none;
        }
        .danhmuc-danhsach{
            border-collapse:collapse;
            width:100%;
            font-size:13px;
            box-shadow:rgba(0,0,0,0.3) 2px 2px;
        }
            .danhmuc-danhsach th {
                border: 1px solid black;
                background-color: cornflowerblue;
                text-align: left;
                padding: 8px;
            }
            .danhmuc-danhsach td {
                border: 1px solid black;
                text-align: left;
                padding: 8px;
            }
            .danhmuc-danhsach tr:nth-child(even) {
                background-color: lightgrey;
            }
        .table-hinhanh{
            text-align:center;
        }
        .table-tendanhmuc{
            font-size:1.5rem;
            font-weight:500;
            padding-left:20px;
        }
        .table-chucnang{
            text-align:center;
        }*/
        /*.file-upload {
            margin-top:10px;
            display: inline-block;
            overflow: hidden;
            text-align: center;
            vertical-align: middle;
            font-family: Arial;
            border: 1px solid #124d77;
            background: #007dc1;
            color: #fff;
            border-radius: 6px;
            -moz-border-radius: 6px;
            cursor: pointer;
            text-shadow: #000 1px 1px 2px;
            -webkit-border-radius: 6px;
        }
        .file-upload:hover {
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #0061a7), color-stop(1, #007dc1));
            background: -moz-linear-gradient(top, #0061a7 5%, #007dc1 100%);
            background: -webkit-linear-gradient(top, #0061a7 5%, #007dc1 100%);
            background: -o-linear-gradient(top, #0061a7 5%, #007dc1 100%);
            background: -ms-linear-gradient(top, #0061a7 5%, #007dc1 100%);
            background: linear-gradient(to bottom, #0061a7 5%, #007dc1 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#0061a7', endColorstr='#007dc1',GradientType=0);
            background-color: #0061a7;
        }
        .file-upload {
            height: 30px;
        }
            .file-upload, .file-upload span {
                width: 90px;
            }
                .file-upload input {
                    top: 0;
                    left: 0;
                    margin: 0;
                    font-size: 11px;
                    font-weight: bold;
       
                    opacity: 0;
                    filter: alpha(opacity=0);
                }
                .file-upload strong {
                    font: normal 12px Tahoma,sans-serif;
                    text-align: center;
                    vertical-align: middle;
                }
                .file-upload span {
                    top: 0;
                    left: 0;
                    display: inline-block;
                    padding-top: 5px;
                }*/

        .upload-btn-wrapper {
            margin-top:5px;
            position: relative;
            overflow: hidden;
            display: inline-block;
        }

        .btnFileUpload {
            border: 2px solid gray;
            color:var(--text-color);
            background-color: white;
            padding: 4px 15px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
        }

        .upload-btn-wrapper input[type=file] {
            font-size: 50px;
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
        }


        .themdanhmuc{
            position: fixed;
            bottom: 10%;
            right: 20%;
        }
        .themdanhmuc__button{
            width:40px;
            height:40px;
            border-radius:20px;
            background-color:green;
            padding:8px 5px;
            color:var(--while-color);
        }


        /*phan trang*/
                .phantrang{
                    background-color:var(--ưhile-color);
                    display:flex;
                    text-align:center;
                    align-items:center;
                    align-content:center;
                    justify-content:center;
                    margin-top:15px;
                }
                .btn_page{
                    margin: 0 5px;
                    text-align:center;
                    min-width:80px;
                    min-height:29px;
                    max-height:29px;
                }
                .btn_page input[type=image]{
                    color:var(--text-color);
                }
                .btn_page:hover{
                    background-color:var(--primary-color);
                }
                .btn_page_nextprev{
                    margin: 0 5px;
                    align-items:center;
                    text-align:center;
                    min-width:80px;
                    min-height:25px;
                    font-size:2rem;
                    font-weight:bold;
                }
                .btn_page_nextprev:hover{
                    background-color:var(--primary-color);
                }
                /*phan trang*/

    </style>
    
<%--    <script type="text/javascript">
        function UploadFile(fileUpload) {
            if (fileUpload.value != '') {
                document.getElementById("<%=btnUpload.ClientID %>").click();
            }
        }
    </script>--%>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1"  Runat="Server">

    <asp:GridView ID="gridView_DanhMuc" runat="server" AllowSorting="True" Width="100%"  AutoGenerateColumns="False">
        <AlternatingRowStyle BackColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        <Columns>
            
            <%--<asp:TemplateField HeaderText="Hình Ảnh" >
                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <img style=" Width:50px ; height:50px" src='../HinhAnh/Sprites_DanhMuc/<%#Eval("AnhDanhMuc")%>'/>
                </ItemTemplate>
            </asp:TemplateField>--%>

            <asp:TemplateField HeaderText="Tên Danh Mục" >
                <ItemTemplate>
                   <a class="tendanhmuc-link" href="QuanLyChiTietDanhMuc.aspx?IdDanhMuc=<%#Eval("IdDanhMuc")%>"><%#Eval("TenDanhMuc")%></a>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Chức năng">
                <HeaderStyle HorizontalAlign="Center" Width="120px" />
                <ItemStyle HorizontalAlign="Center"/>
                <ItemTemplate>
                    <asp:Button CommandArgument='<%#Eval("IdDanhMuc")%>' class="btn_gridview" ID="btn_Sua" runat="server" Text="Sửa" OnClick="Btn_Sua_Click" />
                    <asp:Button CommandArgument='<%#Eval("IdDanhMuc")%>' class="btn_gridview" ID="btn_Xoa" runat="server" Text="Xóa" OnClick="btn_Xoa_Click"/>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>


    <%--<div class="danhmuc">
            <table class="danhmuc-danhsach">
                <tr>
                    <th>Hình Ảnh</th>
                    <th>Danh Mục</th>
                    <th>Chức Năng</th>
                </tr>
                <asp:Repeater ID="rpt_danhmuc" runat="server">
                    <ItemTemplate>
                            <tr>
                                <td style="Width:100px" class="table-hinhanh">
                                     <img style=" Width:50px ; height:50px" src="../HinhAnh/Sprites_DanhMuc/<%#Eval("AnhDanhMuc")%>"/>
                                </td>
                                <td class="table-tendanhmuc">
                                    <%#Eval("TenDanhMuc")%>
                                </td>
                                <td style="Width:120px" class="table-chucnang"> 
                                    <asp:Button CommandArgument='<%#Eval("IdDanhMuc")%>' class="btn_gridview" ID="btn_Sua_Test" runat="server" Text="Sửa" OnClick="Btn_Sua_Click" />
                                    <asp:Button CommandArgument='<%#Eval("IdDanhMuc")%>' class="btn_gridview" ID="btn_Xoa_Test" runat="server" Text="Xóa" OnClick="btn_Xoa_Click"/>
                                </td>
                            </tr>
                        <tr class="chitietdanhmuc">
                            <asp:GridView ID="GridView<%#Eval("IdDanhMuc")%>" runat="server">
                                <Columns>
                                    <asp:BoundField  DataField="TenLoaiSP" HeaderText="Tên Danh Mục">
                                    </asp:BoundField>    
                                    <asp:TemplateField HeaderText="Chức Năng">
                                        <HeaderStyle HorizontalAlign="Center" Width="120px" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:CheckBox CommandArgument='<%#Eval("IdLoaiSP")%>' ID="ckTrangThai" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Chức Năng">
                                        <HeaderStyle HorizontalAlign="Center" Width="120px" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Button CommandArgument='<%#Eval("IdLoaiSP")%>' class="btn_gridview" ID="btn_Sua" runat="server" Text="Sửa" OnClick="Btn_Sua_Click" />
                                            <asp:Button CommandArgument='<%#Eval("IdLoaiSP")%>' class="btn_gridview" ID="btn_Xoa" runat="server" Text="Xóa" OnClick="btn_Xoa_Click"/>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
    </div>--%>

    <%-- Phan trang --%>

        <div class="phantrang">
            <div>
                <asp:Button cssclass="btn_page" ID="btn_TrangDau" runat="server" Text="Trang Đầu" OnClick="btn_TrangDau_Click"/>
            </div>
            <div>
                <asp:Button cssclass="btn_page_nextprev"  ID="btn_Prev" runat="server" Text="<" OnClick="btn_Prev_Click"/>
            </div>
            <div>
                <asp:TextBox style="width:50px;text-align:center;min-width:80px;min-height:30px;max-height:30px;" ID="txt_STTPage" runat="server" Enabled="false"></asp:TextBox>
            </div>
            <div>
                <asp:Button cssclass="btn_page_nextprev"  ID="btn_Next" runat="server" Text=">"  OnClick="btn_Next_Click"/>
            </div>
            <div>
                <asp:Button cssclass="btn_page" ID="btn_TrangCuoi" runat="server" Text="Trang Cuối" OnClick="btn_TrangCuoi_Click"/>
            </div>
        </div>


    <!--form modal layout -->
    <div class="form__modal" runat="server" id="form_chinhsuadanhmuc">
        <div class="modal-overlay">
        </div> 
        <div class="modal-body">
            <div class="modal-inner">
                <div class="danhmuc_title">
                    <asp:Label ID="lb_title" runat="server" Text="Thêm Danh Mục"></asp:Label>
                </div> 
                <%--<div class="danhmuc_ibtn">
                    <asp:Image ID="imgHinhAnh" runat="server" CssClass="ibtn_DanhMuc"/>
                    <div></div>
                    <label runat="server" id="lbUploadHinhAnh" class="file-upload"> <span><strong>Upload Image</strong></span> <asp:FileUpload ID="fileUpload" runat="server" > </asp:FileUpload> </label>   
                    <asp:Button ID="btnUpload" runat="server" Text="Button" Style="display:none" OnClick="btnUpload_Click"/>
                    <div class="upload-btn-wrapper" id="btn_upload_file" runat="server">
                        <asp:Button class="btnFileUpload" ID="btnUpload" runat="server" Text="Hình Ảnh" OnClick="btnUpload_Click"/>
                        <asp:FileUpload ID="fileUpload" runat="server" />
                    </div>
                </div>--%>
                <div class="danhmuc_txt">
                    <asp:TextBox CssClass="txt_DanhMuc" ID="txt_TenDanhMuc" runat="server"></asp:TextBox>
                </div>
                <div class="danhmuc_thongbao">
                    <asp:Label ID="lb_thongbao_danhmuc" runat="server"></asp:Label>
                    <asp:Label ID="lb_thongbao_danhmuc_id" runat="server" hidden="hidden"></asp:Label>
                    <asp:Label ID="lb_thongbao_danhmuc_anhdanhmuc" runat="server" hidden="hidden"></asp:Label>
                </div>
                <div class="danhmuc_btn">
                    <asp:Button class="btn btn_danhmuc" ID="btn_danhmuc_Them" runat="server" Text="Thêm" OnClick="btn_DanhMuc_Them_Click"/>
                    <asp:Button class="btn btn_danhmuc" ID="btn_danhmuc_Thoat" runat="server" Text="Thoát" OnClick="btn_DanhMuc_Thoat_Click"/>
                </div>
            </div>
        </div>
    </div>


    <!--button them -->
    <div class="themdanhmuc">
        <asp:ImageButton ImageUrl="~/HinhAnh/Icon/buttonAdd.png" CssClass="themdanhmuc__button" ID="ibtn_themdanhmuc" runat="server" OnClick="ibtn_themdanhmuc_Click"/>
    </div>

</asp:Content>