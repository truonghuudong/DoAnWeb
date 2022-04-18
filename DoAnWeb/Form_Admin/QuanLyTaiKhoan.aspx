<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_Admin.master" AutoEventWireup="true" CodeFile="QuanLyTaiKhoan.aspx.cs" Inherits="Form_Admin_TrangChuAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Quản lý tài khoản</title>
    <style>
        .nguoimua-title{
            font-size:1.7rem;
            background-color:var(--while-color);
            padding:15px 5px;
            font-weight:500;
            border-radius:5px;
        }
        .girdview{
            margin-top:5px;
        }
        .btn_gridview{
            font-size:1.3rem;
        }
        .btn_gridview:hover{
            background-color:var(--primary-color);
        }


        /*form*/
        .form_chinhsuataikhoan{
            display:flex;
            top:0;
            left:0;
            bottom:0;
            right:0;
            position:fixed;
        }
        .form_overlay{
            position:absolute;
            width:100%;
            height:100%;
            background-color:rgba(0,0,0,0.4);
        }
        .form_body{
            padding:15px;
            margin:auto;
            background-color:var(--while-color);
            z-index:1;
            border-radius:5px;
        }
        .body-inner_title{
            font-size:1.5rem;
            color:var(--primary-color);
            font-weight:600;
            text-align:center;
        }
        .body-inner_ibtn{
            margin-top:5px;
            text-align:center;
        }
            .fileUpload-button{
                /*width:120px;*/
                margin-left:35px;
                position: relative;
                width:120px;
                height:120px;
                overflow:hidden;
            }
            .body-inner_ibtn input[type=image]{
                border-radius:60px;
                width:120px;
                height:120px;
            }
            .fileUpload{
                font-size: 120px;
                position: absolute;
                left: 0;
                top: 0;
                opacity: 0;
            }
            

        .body-inner_txt{
            text-align:center;
            margin-top:5px;
        }
            .body-inner_txt input[type=text]{
                text-align:center;
                font-size:1.5rem;
                margin:3px 0;
            }
        .form__body-thongbao{
            margin:5px 0;
            font-size:1.3rem;
            color:red;
            text-align:center;
        }
        .body-inner_button{
            margin-top:5px;
            text-align:center;
        }
            .body-inner_button input[type=submit]{
                padding:2px 0;
                min-width:94px;
                font-size:1.5rem;
                border-radius:5px;
            }
            .body-inner_button input[type=submit]:hover{
                background-color:var(--primary-color);
                border-radius:5px;
            }

        .nguoiban{
            margin-top:30px;
        }
        /*form*/

    </style>

    <script type="text/javascript">
        function UploadFile(fileUpload) {
            if (fileUpload.value != '') {
                document.getElementById("<%=ibtn_AnhDaiDien.ClientID%>").click();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="phanthan">
        <%-- Phần người mua --%>
        <div class="nguoimua">
            <div class="nguoimua-title"> 
                Người Mua
            </div>
            <div class="girdview">
                <asp:gridview runat="server" ID="gv_nguoinhan" AllowSorting="True"   Width="100%" AutoGenerateColumns="False">
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
                        <asp:TemplateField HeaderText="Id Tài Khoản" >
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lb_idTaiKhoan" runat="server" Text='<%#Eval("IdTaiKhoan")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tên Tài Khoản" >
                            <HeaderStyle HorizontalAlign="Center"/>
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lb_TenTaiKhoan" runat="server" Text='<%#Eval("TenTaiKhoan")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hình Ảnh" >
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <img style=" Width:50px ; height:50px; border-radius:25px;" src='../HinhAnh/Sprites_AnhDaiDien/<%#Eval("Anh")%>'/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Địa Chỉ" >
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lb_diachi" runat="server" Text='<%#Eval("DiaChi")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Số Điện Thoại" >
                            <HeaderStyle HorizontalAlign="Center"/>
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lb_sdt" runat="server" Text='<%#Eval("SDT")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Trạng Thái" >
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:CheckBox AutoPostBack="true"   ID="cb_trangthai" runat="server" OnCheckedChanged="cb_trangthai_CheckedChanged"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Chức năng" >
                            <HeaderStyle HorizontalAlign="Center" Width="120px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                 <asp:Button CommandArgument='<%#Eval("IdTaiKhoan")%>' class="btn_gridview" ID="btn_Sua" runat="server" Text="Sửa" OnClick="btn_Sua_Click"></asp:Button>
                                 <asp:Button CommandArgument='<%#Eval("IdTaiKhoan")%>' class="btn_gridview" ID="btn_Xoa" runat="server" Text="Xóa" OnClick="btn_Xoa_Click"></asp:Button> 
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:gridview>
            </div>
        </div>
        <%-- Phần người mua --%>

        <%-- Phần người bán --%>
        <div class="nguoiban">
            <div class="nguoimua-title"> 
                Người Bán
            </div>
            <div class="girdview">
                <asp:gridview runat="server" ID="gv_nguoiban" AllowSorting="True"   Width="100%" AutoGenerateColumns="False">
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
                        <asp:TemplateField HeaderText="Id Tài Khoản" >
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lb_idTaiKhoan" runat="server" Text='<%#Eval("IdTaiKhoan")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tên Tài Khoản" >
                            <HeaderStyle HorizontalAlign="Center"/>
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lb_TenTaiKhoan" runat="server" Text='<%#Eval("TenTaiKhoan")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hình Ảnh" >
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <img style=" Width:50px ; height:50px; border-radius:25px;" src='../HinhAnh/Sprites_AnhDaiDien/<%#Eval("Anh")%>'/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Địa Chỉ" >
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lb_diachi" runat="server" Text='<%#Eval("DiaChi")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Số Điện Thoại" >
                            <HeaderStyle HorizontalAlign="Center"/>
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lb_sdt" runat="server" Text='<%#Eval("SDT")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Trạng Thái" >
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:CheckBox AutoPostBack="true"   ID="cb_trangthai" runat="server" OnCheckedChanged="cb_trangthai_CheckedChanged"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Chức năng" >
                            <HeaderStyle HorizontalAlign="Center" Width="120px" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                 <asp:Button CommandArgument='<%#Eval("IdTaiKhoan")%>' class="btn_gridview" ID="btn_Sua" runat="server" Text="Sửa" OnClick="btn_Sua_Click"></asp:Button>
                                 <asp:Button CommandArgument='<%#Eval("IdTaiKhoan")%>' class="btn_gridview" ID="btn_Xoa" runat="server" Text="Xóa" OnClick="btn_Xoa_Click"></asp:Button> 
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:gridview>
            </div>
        </div>
        <%-- Phần người bán --%>

    </div>


    <div class="form_chinhsuataikhoan" runat="server" id="form_chinhsuataikhoan">
        <div class="form_overlay">
        </div>
        <div class="form_body">
            <div class="body-inner">
                <div class="body-inner_title">
                    <asp:Label ID="lb_form_title" CssClass="label-title" runat="server" Text="Sua Tai Khoan"></asp:Label>
                </div>
                <div class="body-inner_ibtn">
                    <div class="fileUpload-button" runat="server" id="fileUpload_button">
                        <asp:ImageButton ID="ibtn_AnhDaiDien" ImageUrl="~/HinhAnh/Sprites_AnhDaiDien/anhdaidien1.jpg" OnClick="ibtn_AnhDaiDien_Click" runat="server"/>
                        <asp:FileUpload CssClass="fileUpload" ID="fileUpload" runat="server" />
                        <asp:Label ID="lb_linkanhtamthoi" runat="server" Hidden="hidden"></asp:Label>
                    </div>
                </div>
                <div class="body-inner_txt">
                    <asp:Label ID="lb_idTaiKhoan_form" runat="server" Hidden="Hidden"></asp:Label>
                    <asp:TextBox ID="txt_TenTaiKhoan_form" PlaceHolder="Tên Tài Khoản" runat="server"></asp:TextBox>
                    <div></div>
                    <asp:TextBox ID="txt_DiaChi_form" runat="server" PlaceHolder="Địa Chỉ"></asp:TextBox>
                    <div></div>
                    <asp:TextBox ID="txt_SDT_form" runat="server" PlaceHolder="Số Điện Thoại"></asp:TextBox>
                    <div></div>
                    <asp:TextBox ID="txt_Email_form" runat="server" PlaceHolder="Email"></asp:TextBox>
                </div>
                <div class="form__body-thongbao">
                    <asp:Label ID="lb__form_thongbao" runat="server" Text="Label"></asp:Label>
                </div>
                <div class="body-inner_button">
                    <asp:Button  ID="btn_xacnhan_form" runat="server" Text="Xác Nhận" OnClick="btn_xacnhan_form_Click"/>
                    <asp:Button  id="btn_thoat_form" runat="server" Text="Thoát" OnClick="btn_thoat_form_Click"/>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

