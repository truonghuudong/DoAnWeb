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

        .taikhoan__popover{
            border-radius:3px;
            position:absolute;
            background-color:var(--while-color);
            display:none;
            animation:HeaderNotifyGrowth ease-in 0.3s;
            transform-origin:20px top;
            z-index:999;
            margin-left:50px;
        }
        .taikhoan__popover ul{
            margin:0px;
        }

        .tentaikhoan:hover .taikhoan__popover{
             display:block;
        }
            .taikhoan__popover::before{
                content: "";
                border-width: 10px 16px;
                border-style: solid;
                border-color: transparent transparent var(--while-color) transparent;
                left: 65%;
                position:absolute;
                top: -20px;
                z-index:0
            }
            .taikhoan__popover::after{
                    content: "";
                    display: block;
                    position: absolute;
                    width: 100px;
                    height: 10px;
                    left: 15px;
                    top: -10px;
                    z-index: 999;
            }

            .taikhoan__popover-list {
                list-style: none;
                padding: 0;
            }

            .buttonBaoCao{
                color:red;
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
                        <th>Tên Tài Khoản</th>
                        <th>Người Nhận</th>
                        <th>Số Điện Thoại</th>
                        <th>Địa Chỉ</th>
                        <th>Ngày Đặt</th>
                        <th >Phí Ship</th>
                        <th>Trạng Thái</th>
                        <th>Chức Năng</th>
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
                        <div class="tentaikhoan"><%#Eval("TenTaiKhoan")%>
                            <div class="taikhoan__popover">
                                <ul class="taikhoan__popover-list">
                                    <%--<li class="list-item">
                                        <a href="../../Form_NguoiBan/QuanLyTaiKhoan/QuangLyTaiKhoan.aspx" class="list-item_link">Tài Khoản Của Tôi</a>
                                    </li>   --%>        
                                    <asp:Button ID="btnBaoCao" CssClass="buttonBaoCao" runat="server" CommandArgument='<%#Eval("IdTaiKhoan")%>' Text="Báo Cáo" class="list-item_link btndangxuat" OnClick="btnBaoCao_Click"/>
                                </ul>
                            </div>
                        </div>

                    </td>
                    <td>
                        <%#Eval("TenNguoiNhan")%>
                    </td>
                    <td>
                        <%#Eval("SDTNguoiNhan")%>
                    </td>
                    <td>
                        <%#Eval("DiaChi")%>
                    </td>
                    <td>
                        <asp:Label ID="lb_Ngay" runat="server"></asp:Label>
                    </td>
                    <td >
                        <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="ddl_phiShip_SelectedIndexChanged" CssClass="dropdownlist"  ID="ddl_phiShip" runat="server"></asp:DropDownList>

                    </td>
                    <td>
                        <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="ddl_TrangThai_SelectedIndexChanged" CssClass="dropdownlist" ID="ddl_TrangThai" runat="server"></asp:DropDownList>
                    </td>
                    <td>
                        <asp:Button ID="btn_Xoa_HD" CommandArgument='<%#Eval("IdHoaDon")%>' runat="server" Text="Xóa" OnClick="btn_Xoa_HD_Click"/>
                    </td>
                </tr>
                <tr id="td_ChiTietHD" runat="server" visible="false">
                    <td ></td>
                    <td colspan="9">
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

