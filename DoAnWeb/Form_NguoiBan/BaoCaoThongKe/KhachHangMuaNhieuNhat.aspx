<%@ Page Title="" Language="C#" MasterPageFile="~/Form_NguoiBan/BaoCaoThongKe/MasterPage_BaoCaoThongKe.master" AutoEventWireup="true" CodeFile="KhachHangMuaNhieuNhat.aspx.cs" Inherits="Form_NguoiBan_BaoCaoThongKe_KhachHangMuaNhieuNhat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Khách Hàng Mua Nhiều Nhất</title>
    <style>
        .thongke{
            margin-top:10px;
            margin-left:30px;
        }
        .title-thongke{
            background-color:var(--while-color);
            padding:10px;
            font-size:1.5rem;
            box-shadow:rgba(0,0,0,0.1) 2px 2px;
            border-radius:3px;
            font-weight:600;
        }
        .noidung-thongke{
            margin-top:5px;
        }

        .khachhangmaunhieu{
            border-radius:5px;
            border-collapse:collapse;
            width:100%;
            font-size:13px;
            box-shadow:rgba(0,0,0,0.3) 2px 2px;
        }

            .khachhangmaunhieu th:first-child{
                border-top-left-radius:5px;
            }
            .khachhangmaunhieu th:last-child{
                border-top-right-radius:5px;
            }
            .khachhangmaunhieu th {
                background-color: cornflowerblue;
                text-align: center;
                padding: 8px;
            }
            .khachhangmaunhieu td {
                /*border: 1px solid black;*/
                text-align: center;
                padding: 8px;
                font-size:1.7rem;
                font-weight:500;
            }
            .td-tentaikhoan{
                line-height: 1.8rem;
                font-weight: 400;
                overflow: hidden;
                height: 1.8rem;
                display: block;
                display: -webkit-box;
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 1;

            }


            .khachhangmaunhieu tr:nth-child(even) {
                background-color: lightgrey;
            }
            .anhdaidien{
                width:50px;
                height:50px;
                border-radius:25px;
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="thongke">
        <div class="title-thongke">
            Top 10 Người Mua Nhiều Nhất
        </div>
        <div class="noidung-thongke">
            <table class="khachhangmaunhieu">
                <tr>
                    <th style="width:120px">Tên Tài Khoản</th>
                    <th style="width:120px">Ảnh</th>
                    <th style="width:120px">Số Lượng</th>
                    <th style="width:120px">Tổng Tiền</th>
                </tr>
                <asp:Repeater ID="rpt_ThongKe" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td>
                                <div class="td-tentaikhoan"><%#Eval("TenTaiKhoan")%></div>
                            </td>
                            <td>
                                <image  class="anhdaidien" src="../../HinhAnh/Sprites_AnhDaiDien/<%#Eval("Anh")%>"/>
                            </td>
                            <td>
                                <%#Eval("SoLuong")%>
                            </td>
                            <td>
                                <%#Eval("TongDonGia")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>
    </div>


</asp:Content>

