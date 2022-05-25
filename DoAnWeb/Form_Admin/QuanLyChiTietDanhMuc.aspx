<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_Admin.master" AutoEventWireup="true" CodeFile="QuanLyChiTietDanhMuc.aspx.cs" Inherits="Form_Admin_QuanLyChiTietDanhMuc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Chi tiết danh mục</title>
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
        /*form*/
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
            background-color:var(--while-color);
            z-index:1;
            border-radius:5px;
            padding:10px;
        }
        .form__body-inner{
            text-align:center;
            width:210px;
        }

        .form__body-title{
            font-size:2rem;
            color:var(--primary-color);
        }
        .form__body-input{
            margin:10px 0px 5px 0px;
        }
        .txt_tenchitietdanhmuc{
            text-align:center;
        }
        .form__body-thongbao{
            margin:5px 0;
            font-size:1.3rem;
            color:red;
        }
        .form__body-button{
            margin-top:15px;
        }
        .btn{
            min-width: 100px;
            height: 25px;
            text-decoration: none;
            border: none;
            border-radius: 2px;
            font-size: 1.5rem;
            padding: 0 8px;
            cursor: pointer;
            /*background-color:var(--while-color);*/
            display: inline-flex;
            justify-content: center;
            align-items: center;
        }
        .btn:hover{
            background-color:var(--primary-color);
            border-radius:2px;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="chitietdanhmuc">
        <table class="chitietdanhmuc-danhsach">
                <tr>
                    <th>Tên Chi Tiết Danh Mục</th>
                    <th style="width:100px">Trạng Thái</th>
                    <th style="width:120px;text-align:center">Chức Năng</th>
                </tr>
            <asp:Repeater ID="rpt_chitietdanhmuc" runat="server" OnItemDataBound="rpt_chitietdanhmuc_ItemDataBound">
                <ItemTemplate>
                    <tr>
                        <asp:Label ID="lb_IdLoaiSP" runat="server" hidden="hidden" Text='<%#Eval("IdLoaiSP")%>'></asp:Label>
                        <td class="tenchitietdanhmuc">
                            <asp:Label ID="lb_tenLoaiSP" runat="server" Text='<%#Eval("TenLoaiSP")%>'></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList CssClass="DropDownList" ID="ddl_trangthai_ctdm" AutoPostBack="true" OnSelectedIndexChanged="ddl_trangthai_ctdm_SelectedIndexChanged" runat="server"></asp:DropDownList>
                        </td>
                        <td  style="text-align:center">
                            <%-- <%#Eval("IdLoaiSP")%> --%>
                            <asp:Button class="btn_repeater" CommandArgument='<%#Eval("IdLoaiSP")%>' ID="btn_sua_ctdm" runat="server" Text="Sửa" OnClick ="btn_sua_ctdm_Click"/>
                            <asp:Button class="btn_repeater" CommandArgument='<%#Eval("IdLoaiSP")%>' ID="btn_xoa_ctdm" runat="server" Text="Xóa" OnClick="btn_xoa_ctdm_Click"/>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
            </table>
    </div>
    <div class="themdanhmuc">
        <asp:ImageButton Visible="false" ImageUrl="~/HinhAnh/Icon/buttonAdd.png" CssClass="themdanhmuc__button" ID="ibtn_themdanhmuc" runat="server" OnClick="ibtn_themdanhmuc_Click"/>
    </div>

    <div class="form" runat="server" id="form_chitietdanhmuc_capnhat"> 
        <div class="form__overlay">
        </div> 
        <div class="form__body">
            <div class="form__body-inner">
                <div class="form__body-title">
                    <asp:Label ID="lb_title_form" runat="server" Text="Chi Tiết Danh Mục"></asp:Label>
                </div>
                <div class="form__body-input">
                    <asp:TextBox PlaceHolder="Tên Chi Tiết Danh Mục" CssClass="txt_tenchitietdanhmuc" ID="txt_TenChiTietDanhMuc" runat="server"></asp:TextBox>
                </div>
                <div class="form__body-thongbao">
                    <asp:Label ID="lb__form_thongbao" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="lb__form_idchitietdanhmuc" runat="server" hidden="hidden"></asp:Label>
                </div>
                <div class="form__body-button">
                    <asp:Button CssClass="btn" ID="btn_form_them" runat="server" Text="Thêm" OnClick="btn_form_them_Click"/>
                    <asp:Button CssClass="btn" ID="btn_form_thoat" runat="server" Text="Thoát"  OnClick="btn_form_thoat_Click"/>
                </div>
            </div>
        </div>
    </div>
</asp:Content>