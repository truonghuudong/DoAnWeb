<%@ Page Title="" Language="C#" MasterPageFile="~/Form_User/HoSoTaiKhoan/MasterPage_HoSoTaiKhoan.master" AutoEventWireup="true" CodeFile="DonMua.aspx.cs" Inherits="Form_User_HoSoTaiKhoan_DonMua" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Lịch Sử Mua Hàng</title>
    <style>
        .table_donhang-ngoai{
            border-collapse:collapse;
            width:100%;
            font-size:13px;
            box-shadow:rgba(0,0,0,0.3) 2px 2px;
        }
            .table_donhang-ngoai th {
                border: 1px solid black;
                background-color: cornflowerblue;
                text-align: center;
                padding: 8px;
            }
            .table_donhang-ngoai td {
                border: 1px solid black;
                background-color:var(--while-color);
                text-align: center;
                padding: 8px;
            }
            .table_donhang-ngoai tr:nth-child(even) {
                /*background-color: lightgrey;*/
            }

        .table_donhang{
            border-collapse:collapse;
            width:100%;
            font-size:13px;
            box-shadow:rgba(0,0,0,0.3) 2px 2px;
        }
            .table_donhang th {
                border: 1px solid black;
                background-color: cornflowerblue;
                text-align: center;
                padding: 8px;
            }
            .table_donhang td {
                border: 1px solid black;
                text-align: center;
                padding: 8px;
            }
            .table_donhang tr:nth-child(even) {
                /*background-color: lightgrey;*/
            }

        .dropdownlist{
            border:none;
            background-color:none;
        }

        .donhang{
            margin-left:10px;
            min-height:100%;
        }


        .div_button{
            margin:10px 0; 
            border-bottom:3px solid;
            background-color:var(--while-color);
        }
        .btn{
             background-color:var(--while-color);
        }
        .btn:hover{
            background-color:var(--primary-color);
        }
        .title{
            padding:10px 0px 10px 5px;
            font-size:1.7rem;
            border-radius:3px;
            font-weight:500;
            box-shadow:rgba(0,0,0,0.1) 2px 2px;
            background-color:var(--while-color);
        }


        /*from*/
                .form{
                    position:fixed;
                    top:0;
                    bottom:0;
                    left:0;
                    right:0;
                    /*min-height:100%;
                    min-width:100%;*/
                    display:flex;
                }
                .form__overlay{
                    position:absolute;
                    width:100%;
                    height:100%;
                    background-color:rgba(0,0,0,0.4);
                }
                .form__body{
                    margin:auto;
                    padding:30px;
                    background-color:var(--while-color);
                    z-index:1;
                    border-radius:5px;
                    box-shadow:rgba(0,0,0,0.2) 2px 2px;
                }
                .form__body-inner{
                    margin:auto;
                    text-align:center;
                }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="donhang">
        <div class="title">
            Đơn Mua
        </div>
        <div class="div_button">
            <asp:Button CssClass="btn" ID="btn_DonHangMoi" runat="server" Text="Đơn Mới" OnClick="btn_DonHangMoi_Click" />
            <asp:Button CssClass="btn" ID="btn_DangGiao" runat="server" Text="Đang Giao" OnClick="btn_DangGiao_Click"/>
            <asp:Button CssClass="btn" ID="btn_DaGiao" runat="server" Text="Đã Nhận" OnClick="btn_DaGiao_Click"/>
            <asp:Button CssClass="btn" ID="btn_DaHuy" runat="server" Text="Đã Hủy" OnClick="btn_DaHuy_Click"/>
        </div>

        <asp:Repeater ID="rpt_HoaDon" OnItemDataBound="rpt_HoaDon_ItemDataBound" runat="server">
            <HeaderTemplate>
                <table class="table_donhang-ngoai">
                    <tr>
                        <th></th>
                        <th>Id Đơn Hàng</th>
                        <th>Shop</th>
                        <th>Ngày Đặt</th>
                        <th>Trạng Thái</th>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:Button ID="btn_hienThi" runat="server" Text="+" OnClick="btn_hienThi_Click" />
                        <asp:Label Hidden="hidden" ID="lb_IdHoaDon" runat="server" Text='<%#Eval("IdHoaDon")%>'></asp:Label>
                    </td>
                    <td>
                        <%#Eval("IdHoaDon")%>
                    </td>
                    <td>
                        <%#Eval("TenTaiKhoan")%>
                    </td>
                    <td>
                        <asp:Label ID="lb_Ngay" runat="server" ></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="ddl_TrangThai_SelectedIndexChanged" CssClass="dropdownlist" ID="ddl_TrangThai" runat="server"></asp:DropDownList>
                    </td>
                </tr>
                <tr id="td_ChiTietHD" runat="server" visible="false">
                    <td ></td>
                    <td colspan="6">
                        <asp:Panel ID="pnl_ChiTietHD" runat="server">
                            <asp:Repeater ID="rpt_ChiTietHoaDon" OnItemDataBound="rpt_ChiTietHoaDon_ItemDataBound" runat="server">
                                <HeaderTemplate>
                                    <table class="table_donhang">
                                        <tr>
                                            <th style="width:400px;">
                                                Sản Phẩm
                                            </th>
                                            <th>
                                                Số Lượng
                                            </th>
                                            <th>
                                                Đơn Giá
                                            </th>
                                        </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    
                                    <tr>
                                        <td style="display:flex;width:400px">
                                            <asp:Label ID="lb_IdSP" Hidden="hidden" runat="server" Text='<%#Eval("IdSP")%>'></asp:Label>
                                            <asp:LinkButton Enabled="false" OnClick="lbtn_sp_Click"  style="align-items:center;display:flex;width:400px;text-decoration:none;color:var(--text-color)" ID="lbtn_sp" runat="server">
                                                <img style="width:50px;height:50px;" src="../../HinhAnh/Sprites_SP/<%#Eval("AnhSP")%>"/>
                                                <div style="margin-left:5px;"><%#Eval("TenSP")%></div>
                                            </asp:LinkButton>
                                        </td>
                                        <td>
                                            <%#Eval("SoLuong")%>
                                        </td>
                                        <td>
                                            <%#Eval("DonGia")%>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>            
                        </asp:Panel>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </div>

    <div class="form" runat="server" onclick="" visible ="false" id="form_muahang"> 
        <div class="form__overlay">
        </div> 
        <div class="form__body">
            <div class="form__body-inner">
                <div style="font-size:1.7rem;font-weight:600">Bạn Không Thể Thực Hiện Thao Tác Này</div>
            </div>
            <asp:Button ID="btn_thoat_form" runat="server" Hidden="hidden" OnClick="btn_thoat_form_Click1" />
        </div>
    </div>

    <script type="text/javascript">
        function form_Click() {
                document.getElementById("<%=btn_thoat_form.ClientID%>").click();
        }
    </script>

</asp:Content>

