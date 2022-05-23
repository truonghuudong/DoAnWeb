<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_NguoiBan.master" AutoEventWireup="true" CodeFile="QuanLyShip.aspx.cs" Inherits="Form_NguoiBan_QuanLyShip_QuanLyShip" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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

        /*The*/
        .themthue{
            position: fixed;
            bottom: 10%;
            right: 20%;
        }
        .themthue__button{
            width:40px;
            height:40px;
            border-radius:20px;
            background-color:green;
            padding:8px 5px;
            color:var(--while-color);
        }


        /*Form*/
        .form__modal{
            position:fixed;
            top:0;
            bottom:0;
            left:0;
            right:0;
            /*min-height:100%;
            min-width:100%;*/
            display:flex;
        }
        .modal-overlay{
            position:absolute;
            width:100%;
            height:100%;
            background-color:rgba(0,0,0,0.4);
        }
        .modal-body{
            padding:5px;
            margin:auto;
            background-color:var(--while-color);
            z-index:1;
            border-radius:5px;
        }
        .modal-inner{
            align-items:center;
            width:290px;
        }
        .themmoithue_title{
            font-size:2rem;
            padding:15px 0px 10px 0px;
            color:var(--primary-color);
            text-align:center;
        }

        .danhmuc_ibtn{
            text-align:center;
        }
        .ibtn_DanhMuc{
            width:200px;
            height:200px;
        }
        .danhmuc_txt{
            margin-top:15px;
            text-align:center;
        }
        .txt_DanhMuc{
            width:100%;
            text-align:center;
            font-size:1.5rem;
        }
        .danhmuc_btn{
            margin-top:15px;
            text-align:center;
        }
        .btn_danhmuc:hover{
            background-color:var(--primary-color);
        }
        .danhmuc_thongbao{
            margin-top:5px;
            text-align:center;
            font-size:1.5rem;
            color:red;
        }
         /*Form*/
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="margin-left:20px;">  
        <table class="chitietdanhmuc-danhsach">
            <tr>
                <th>Khu Vực</th>
                <th >Giá</th>
                <th style="width:120px;text-align:center">Chức Năng</th>
            </tr>
            <asp:Repeater ID="rpt_phiShip" runat="server" OnItemDataBound="rpt_phiShip_ItemDataBound">
                <ItemTemplate>
                    <tr>
                        <asp:Label ID="lb_IdPhiShip" runat="server" hidden="hidden" Text='<%#Eval("IdPhiShip")%>'></asp:Label>
                        <td class="tenchitietdanhmuc">
                            <asp:Label ID="lb_KhuVuc" runat="server" Text='<%#Eval("KhuVuc")%>' ></asp:Label>
                        </td>
                        <td class="tenchitietdanhmuc">
                            <asp:Label ID="lb_Gia" runat="server" Text='<%#Eval("Gia")%>'></asp:Label>
                        </td>
                        
                        <td  style="text-align:center">
                            <%-- <%#Eval("IdLoaiSP")%> --%>
                            <asp:Button class="btn_repeater" CommandArgument='<%#Eval("IdPhiShip")%>' ID="btn_sua_ctphiship" runat="server" Text="Sửa" OnClick="btn_sua_ctphiship_Click" />
                            <asp:Button class="btn_repeater" CommandArgument='<%#Eval("IdPhiShip")%>' ID="btn_xoa_ctphiship" runat="server" Text="Xóa" OnClick="btn_xoa_ctphiship_Click"/>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </div>  

    <!--button them -->
    <div class="themthue">
        <asp:ImageButton ImageUrl="~/HinhAnh/Icon/buttonAdd.png" CssClass="themthue__button" ID="ibtn_themPhiShip" runat="server" OnClick="ibtn_themPhiShip_Click"/>
    </div>
    <!--button them -->

    <!--form them sua -->
    <div class="form__modal" runat="server" visible="false" id="form_thue">
        <div class="modal-overlay">
        </div> 
        <div class="modal-body">
            <div class="modal-inner">
                <div class="themmoithue_title">
                    <asp:Label ID="lb_title" runat="server" Text="Thêm Mới Thuế"></asp:Label>
                    <asp:Label ID="lb_IdThue" runat="server" hidden="hidden"></asp:Label>
                </div> 
                <div class="danhmuc_txt">
                    <asp:TextBox CssClass="txt_DanhMuc" ID="txt_TenThue" placeholder="Tên Phí Ship" runat="server"></asp:TextBox>
                </div>
                <div class="danhmuc_txt">
                    <asp:TextBox CssClass="txt_DanhMuc" ID="txt_TyLeThue" placeholder="Giá" runat="server"></asp:TextBox>
                </div>
                <div class="danhmuc_thongbao">
                    <asp:Label ID="lb_thongbao_form" Visible ="false" runat="server" Text="Thêm Thành Công"></asp:Label>
                </div>
                <div class="danhmuc_btn">
                    <asp:Button class="btn btn_danhmuc" ID="btn_thue_Them_form" runat="server" Text="Thêm" OnClick="btn_thue_Them_form_Click"/>
                    <asp:Button class="btn btn_danhmuc" ID="btn_thue_Thoat" runat="server" Text="Thoát" OnClick="btn_thue_Thoat_Click"/>
                </div>
            </div>
        </div>
    </div>
    <!--form them sua -->


</asp:Content>

