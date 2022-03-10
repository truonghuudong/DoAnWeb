<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_NguoiBan.master" AutoEventWireup="true" CodeFile="TatCaCacYeuCauDanhMuc.aspx.cs" Inherits="Form_NguoiBan_YeuCauDanhMuc_TatCaCacYeuCauDanhMuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Yêu Cầu Danh Mục</title>
    <style>
        
        .yeuCauDanhMuc{
            margin-left:10px;
            min-height:100%;
        }
        .yeuCau_title{
            padding:10px 0px 10px 5px;
            font-size:1.7rem;
            border-radius:3px;
            font-weight:500;
            box-shadow:rgba(0,0,0,0.1) 2px 2px;
            background-color:var(--while-color);
        }
        .table_YeuCau{
            margin:10px 0;
            border-collapse:collapse;
            width:100%;
            font-size:13px;
            box-shadow:rgba(0,0,0,0.3) 2px 2px;
        }
            .table_YeuCau th {
                border: 1px solid black;
                background-color: cornflowerblue;
                text-align: center;
                padding: 8px;
            }
            .table_YeuCau td {
                border: 1px solid black;
                background-color:var(--while-color);
                text-align: center;
                padding: 8px;
            }
            .table_YeuCau tr:nth-child(even) {
                /*background-color: lightgrey;*/
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="yeuCauDanhMuc">
        <div class="yeuCau_title">
            Tất cả yêu cầu
        </div>
        <div class="table">
            <table class="table_YeuCau">
            <tr>
                <th style="min-width:100px;">Id yêu cầu</th>
                <th style="min-width:100px;">Tên danh mục yêu cầu </th>
                <th style="min-width:130px;">Trạng thái</th>
                <%--<th style="min-width:130px;">Chức năng</th>--%>
            </tr>
    <asp:Repeater ID="rpt_ChiTietDanhMuc" OnItemDataBound="rpt_ChiTietDanhMuc_ItemDataBound" runat="server">
        <ItemTemplate>
            <tr>
                <td>
                    <asp:Label ID="lb_idChiTietDanhMuc" runat="server" Text='<%#Eval("IdLoaiSP")%>'></asp:Label>
                </td>
                <td>
                    <%#Eval("TenLoaiSP")%>
                </td>
                <td>
                    <asp:DropDownList OnSelectedIndexChanged="ddl_trangthai_SelectedIndexChanged" AutoPostBack="true" ID="ddl_trangthai" runat="server"></asp:DropDownList>
                </td>
                <%--<td>
                    <asp:Button ID="btn_YeuCau_Huy" runat="server" Text="Hủy" OnClick ="btn_YeuCau_Huy_Click"/>
                </td>--%>
             </tr>
                    
        </ItemTemplate>
    </asp:Repeater>
        </table>
        </div>

    </div>
    
</asp:Content>

