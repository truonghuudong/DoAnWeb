<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_NguoiBan.master" AutoEventWireup="true" CodeFile="TatCaDonHang.aspx.cs" Inherits="Form_NguoiBan_QuanLyDonHang_TatCaDonHang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Tất Cả Đơn Hàng</title>
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

    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="donhang">
        <div class="title">
            Quản Lý Đơn Hàng 
        </div>


        <div class="div_button">
            <asp:Button CssClass="btn" ID="btn_DonHangMoi" runat="server" Text="Đơn Hàng Mới" OnClick="btn_DonHangMoi_Click" />
            <asp:Button CssClass="btn" ID="btn_DangGiao" runat="server" Text="Đang Giao" OnClick="btn_DangGiao_Click"/>
            <asp:Button CssClass="btn" ID="btn_DaGiao" runat="server" Text="Đã Giao" OnClick="btn_DaGiao_Click"/>
            <asp:Button CssClass="btn" ID="btn_DaHuy" runat="server" Text="Đã Hủy" OnClick="btn_DaHuy_Click"/>
        </div>

        <asp:Repeater ID="rpt_HoaDon" OnItemDataBound="rpt_HoaDon_ItemDataBound" runat="server">
            <HeaderTemplate>
                <table class="table_donhang-ngoai">
                    <tr>
                        <th></th>
                        <th>Id Đơn Hàng</th>
                        <th>Người Nhận</th>
                        <th>Số Điện Thoại</th>
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
                        <%#Eval("TenNguoiNhan")%>
                    </td>
                    <td>
                        <%#Eval("SDTNguoiNhan")%>
                    </td>
                    <td>
                        <%#Eval("Ngay")%>
                    </td>
                    <td>
                        <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="ddl_TrangThai_SelectedIndexChanged" CssClass="dropdownlist" ID="ddl_TrangThai" runat="server"></asp:DropDownList>
                    </td>
                </tr>
                <tr id="td_ChiTietHD" runat="server" visible="false">
                    <td ></td>
                    <td colspan="6">
                        <asp:Panel ID="pnl_ChiTietHD" runat="server">
                            <asp:Repeater ID="rpt_ChiTietHoaDon" runat="server">
                                <HeaderTemplate>
                                    <table class="table_donhang">
                                        <tr>
                                            <th style="width:100px;">
                                                Id Sản Phẩm
                                            </th>
                                            <th style="width:400px;">
                                                Sản Phẩm
                                            </th>
                                            <th style="width:100px;">
                                                Số Lượng
                                            </th>
                                            <th style="width:100px;">
                                                Đơn Giá
                                            </th>
                                        </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <%#Eval("IdSP")%>
                                        </td>
                                        <td style="display:flex">
                                            <img style="width:50px;height:50px;" src="../../HinhAnh/Sprites_SP/<%#Eval("AnhSP")%>"/>
                                            <div style="margin-left:5px;"><%#Eval("TenSP")%></div>
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
</asp:Content>

