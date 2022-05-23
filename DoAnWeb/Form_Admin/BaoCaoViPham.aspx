<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_Admin.master" AutoEventWireup="true" CodeFile="BaoCaoViPham.aspx.cs" Inherits="Form_Admin_BaoCaoViPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Báo Cáo Vi Phạm</title>
    <style>
         .chitietdanhmuc-danhsach{
            border-collapse:collapse;
            width:100%;
            font-size:13px;
            box-shadow:rgba(0,0,0,0.3) 2px 2px;
        }
            .chitietdanhmuc-danhsach th {
                border: 1px solid black;
                background-color: cornflowerblue;
                text-align: left;
                padding: 8px;
            }
            .chitietdanhmuc-danhsach td {
                border: 1px solid black;
                text-align: left;
                padding: 8px;
            }
            .chitietdanhmuc-danhsach tr:nth-child(even) {
                background-color: lightgrey;
            }
            .tenchitietdanhmuc{
                font-size:1.5rem;
            }
            .DropDownList{
                border:none;
                background-color:rgba(0,0,0,0.0);
            }
        .btn_repeater{
            font-size:1.5rem;
            border:none;
            border-radius:5px;
            background-color:rgba(0,0,0,0.0);
        }
        .btn_repeater:hover{
            background-color:var(--primary-color);
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>  
        <table class="chitietdanhmuc-danhsach">
            <tr>
                <th>IdTaiKhoan</th>
                <th >Tên Tài Khoản</th>
                <th >Số Lần Vi Phạm</th>
                <th >Khóa Tài Khoản</th>
                <th>Chức Năng</th>
            </tr>
            <asp:Repeater ID="rpt_BaoCaoViPham" runat="server" OnItemDataBound="rpt_BaoCaoViPham_ItemDataBound">
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="lb_IdIdTaiKhoan" runat="server" Text='<%#Eval("IdTaiKhoan")%>'></asp:Label>
                        </td>
                        <td class="tenchitietdanhmuc">
                            <asp:Label ID="lb_TenTaiKhoan" runat="server" Text='<%#Eval("TenTaiKhoan")%>' ></asp:Label>
                        </td>
                        <td class="tenchitietdanhmuc">
                            <asp:Label ID="lb_SoLanViPham" runat="server" Text='<%#Eval("SoLanViPham")%>'></asp:Label>
                        </td>
                        <td class="tenchitietdanhmuc">
                            <asp:CheckBox ID="cb_trangThai" AutoPostBack="true" OnCheckedChanged="cb_trangThai_CheckedChanged" runat="server" />
                        </td>
                        <td>
                            <asp:Button ID="btn_Xoa" runat="server" Text="Xóa" CommandArgument='<%#Eval("IdTaiKhoan")%>' OnClick="btn_Xoa_Click"/>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>  


</asp:Content>

