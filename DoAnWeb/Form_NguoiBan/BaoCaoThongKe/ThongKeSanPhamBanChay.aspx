<%@ Page Title="" Language="C#" MasterPageFile="~/Form_NguoiBan/BaoCaoThongKe/MasterPage_BaoCaoThongKe.master" AutoEventWireup="true" CodeFile="ThongKeSanPhamBanChay.aspx.cs" Inherits="Form_NguoiBan_BaoCaoThongKe_ThongKeSanPhamBanChay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Thống kê Sản Phẩm Bán Chạy</title>
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

        .sanphambanchay{
            border-radius:5px;
            border-collapse:collapse;
            width:100%;
            font-size:13px;
            box-shadow:rgba(0,0,0,0.3) 2px 2px;
        }

            .sanphambanchay th:first-child{
                border-top-left-radius:5px;
            }
            .sanphambanchay th:last-child{
                border-top-right-radius:5px;
            }
            .sanphambanchay th {
                background-color: cornflowerblue;
                text-align: center;
                padding: 8px;
            }
            .sanphambanchay td {
                /*border: 1px solid black;*/
                text-align: center;
                padding: 8px;
                font-size:1.7rem;
                font-weight:500;
            }
            .td-tensannpham{
                line-height: 1.8rem;
                font-weight: 400;
                overflow: hidden;
                height: 1.8rem;
                font-size:1.3rem;
                display: block;
                display: -webkit-box;
                -webkit-box-orient: vertical;
                -webkit-line-clamp: 1;

            }


            .sanphambanchay tr:nth-child(even) {
                background-color: lightgrey;
            }
            .anhsanpham{
                width:50px;
                height:50px;
            }

    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="thongke">
        <div class="title-thongke">
            Top 10 Sản Phẩm Bán Chạy Nhất
        </div>
        <div class="noidung-thongke">
            <table class="sanphambanchay">
                <tr>
                    <th style="width:120px">Id Sản Phẩm</th>
                    <th >Tên Sản Phẩm</th>
                    <th style="width:120px">Ảnh</th>
                    <th style="width:120px">Trạng Thái</th>
                    <th style="width:120px">Số Lượng Bán Được</th>
                </tr>
                <asp:Repeater ID="rpt_ThongKe" OnItemDataBound="rpt_ThongKe_ItemDataBound" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%#Eval("IdSP")%></td>
                            <td>
                                <div class="td-tensannpham"><%#Eval("TenSP")%></div>
                            </td>
                            <td>
                                <image  class="anhsanpham" src="../../HinhAnh/Sprites_SP/<%#Eval("AnhSP")%>"/>
                            </td>
                            <td>
                                <asp:CheckBox Enabled="false" ID="cb_trangThai" runat="server" />
                            </td>
                            <td>
                                <%#Eval("SoLuongBanDuoc")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>
    </div>

</asp:Content>
