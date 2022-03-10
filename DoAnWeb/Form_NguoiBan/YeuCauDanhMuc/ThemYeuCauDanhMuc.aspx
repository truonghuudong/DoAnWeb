<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_NguoiBan.master" AutoEventWireup="true" CodeFile="ThemYeuCauDanhMuc.aspx.cs" Inherits="Form_NguoiBan_YeuCauDanhMuc_ThemYeuCauDanhMuc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Thêm Danh Mục</title>
    <style>
        .themYeuCauDanhMuc{
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
        .btn{
            background-color:var(--primary-color);
        }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="themYeuCauDanhMuc">
        <div class="yeuCau_title">
            Thêm yêu cầu
        </div>
        <div style="margin-top:10px">
            <asp:DropDownList ID="ddl_DanhMuc" runat="server"></asp:DropDownList>
        </div>
        <div style="margin-top:10px">
            <asp:TextBox ID="txt_TenChiTietDanhMuc" runat="server"></asp:TextBox>
        </div>
        <div style="margin-top:10px">
            <asp:Button CssClass="btn" ID="btn_GuiYeuCau" runat="server" Text="Gửi yêu cầu" OnClick="btn_GuiYeuCau_Click" />
        </div>

    </div>
</asp:Content>

