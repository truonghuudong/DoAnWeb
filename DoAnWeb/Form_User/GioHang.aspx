<%@ Page Title="" Language="C#" MasterPageFile="~/Form_User/MasterPage.master" AutoEventWireup="true" CodeFile="GioHang.aspx.cs" Inherits="Form_User_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .Title_GioHang{
            background-color:var(--while-color);
            padding:10px;
            font-size:1.7rem;
            font-weight:600;
            border-radius:2px 2px;
        }
        .phanthan{
            margin-top:10px;
            /*background-color:var(--while-color);*/
            border-radius:3px 3px;
        }

        


            .table-giohang{
                border-radius:5px;
                border-collapse:collapse;
                width:100%;
                font-size:13px;
                /*box-shadow:rgba(0,0,0,0.3) 2px 2px;*/
                border-left:1px solid rgba(0,0,0,0.06);
            }
                .table-giohang tr{
                    margin-bottom:10px;
                    
                }
                .table-giohang th:first-child{
                    border-top-left-radius:5px;
                }
                .table-giohang th:last-child{
                    border-top-right-radius:5px;
                }
                .table-giohang th {
                    background-color:var(--while-color);
                    /*background-color: cornflowerblue;*/
                    font-weight:500;
                    font-size:1.5rem;
                    text-align: center;
                    padding: 8px;
                    color:rgba(0,0,0,0.5);
                }
                .table-giohang td {
                    background-color:var(--while-color);
                    /*border: 1px solid black;*/
                    text-align: center;
                    padding: 8px;
                    font-size:1.5rem;
                    font-weight:400;
                }
                .table-giohang tr:nth-child(even) {
                    background-color: lightgrey;
                }


                .label_trong_rpt{
                    margin:0 10px;
                }

                .btn_trong_rpt{
                    min-width:40px;
                    background-color:var(--while-color);
                    border:1px solid rgba(0,0,0,0.3);
                }

                .btn_trong_rpt:hover{
                    background-color:var(--primary-color);
                }

                .tongcong{
                    padding:10px 0 10px 10px;
                    background-color:var(--while-color);
                    margin-top:15px;
                    display:flex;
                    align-items:center;
                    font-size:1.7rem;
                }

                .btnMuaHang{
                    background-color:var(--primary-color);
                    border:none;
                    border-radius:3px;
                    color:var(--while-color);
                }
                .btnMuaHang:hover{
                    background-color:#f05d40;
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
                    background-color:var(--while-color);
                    z-index:1;
                    border-radius:5px;
                    width:400px;
                    height:360px;
                    box-shadow:rgba(0,0,0,0.2) 2px 2px;
                }
                .form__body-inner{
                    margin:auto;
                    text-align:center;
                }

                    .inner-title{
                        font-size:1.7rem;
                        font-weight:600;
                        color:var(--primary-color);
                    }
                    .inner-items{
                        margin:5px 0;
                    }
                    .inner-items:first-child{
                        margin:15px;
                    }
                    .inner-items input[type=text]{
                        padding-left:10px;
                        font-size:1.5rem;
                        width:250px;
                        height:40px;
                    }

                    .btn{
                        margin-top:10px;
                        background-color:var(--primary-color);
                        color:var(--while-color);
                    }

                    .btn:hover{
                        background-color:#f05d40;
                    }

                    .thongbao{
                        padding: 0 20px;
                        margin:5px 0 10px 0;
                        font-size:1.5rem;
                        color:var(--primary-color);
                    }

                    .btn_thoat{
                        text-align:right;
                        font-size:1.7rem;
                        border-top-right-radius:3px;
                    }
                    .btn_thoat input[type=submit]{
                        border-top-right-radius:3px;
                        background-color:var(--while-color);
                        border:none;
                    }
                    .btn_thoat input[type=submit]:hover{
                        background-color:var(--primary-color);
                        color:var(--while-color);
                    }
                /*from*/
    </style>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="grid">
        <div class="Title_GioHang">
            Giỏ Hàng
        </div>
        <div class="phanthan" runat="server" id="phanthan">
            <table class="table-giohang"">
                <tr>
                    <th style="width:625px">
                        <div style="display:flex;align-items:center;width:320px">
                            <div style="margin-right:10px;">Sản Phẩm</div>
                        </div>
                    </th>

                    <th>
                        Đơn Giá
                    </th>

                    <th>
                        Số Lượng
                    </th>
                    <th>
                        Số Tiền
                    </th>
                    <th>
                        Thao Tác
                    </th>
                </tr>
            </table>

                
            <asp:Repeater ID="rpt_Shop" OnItemDataBound="rpt_Shop_ItemDataBound" runat="server">
                    <ItemTemplate>
                        <table class="table-giohang" style="margin-top:10px;"> 
                            <tr style="border-bottom:1px solid rgba(0,0,0,0.3)">
                                <td colspan="5" >
                                    <div style="display:flex;align-items:center;margin-top:10px;">
                                        <%--<asp:CheckBox AutoPostBack="true" ID="cb_TatCaSanPhamTrongShop" OnCheckedChanged="cb_TatCaSanPhamTrongShop_CheckedChanged" runat="server" />--%>
                                        <div style="margin-left:5px;"><%#Eval("tenNguoiBan")%></div>
                                        <asp:Label ID="lb_IdNguoiBan" hidden="hidden" runat="server" Text='<%#Eval("idNguoiBan")%>'></asp:Label>
                                    </div>
                                </td>
                            </tr>

                            <asp:Repeater ID="rpt_SanPhamTrongGioHang" runat="server" OnItemDataBound="rpt_SanPhamTrongGioHang_ItemDataBound">
                                <ItemTemplate>
                                    <tr >
                                        <td colspan="1" style="width:625px">
                                            <div style="display:flex;align-items:center;width:450px">
                                                <div style="margin-left:30px;">
                                                </div>
                                                <%--<asp:CheckBox AutoPostBack="true" ID="cb_sp_rpt" OnCheckedChanged="cb_sp_rpt_CheckedChanged" runat="server" />--%>
                                               
                                                <img style="width:50px;height:50px;margin-left:5px" src='../HinhAnh/Sprites_SP/<%#Eval("anhSP")%>'/>
                                 
                                                <div style="margin-left:5px"><%#Eval("tenSP")%></div>
                                                <asp:Label ID="lb_idSP_rpt" runat="server" hidden="hidden" Text='<%#Eval("idSP")%>'></asp:Label>
                                            </div>
                                        </td>
                                        <td colspan="1" style="width:133px">
                                            <asp:Label ID="lb_giasp_rpt" runat="server" Text='<%#Eval("GiaSP")%>'></asp:Label>
                                        </td>
                                        <td colspan="1" style="width:155px">
                                            <div style="display:flex;justify-content:center;align-items:center">
                                                <asp:Button CssClass="btn_trong_rpt" ID="btn_tru_rpt" OnClick="btn_tru_rpt_Click" runat="server" Text="-" />
                                                <asp:Label CssClass="label_trong_rpt" ID="lb_soluong_rpt" runat="server" Text='<%#Eval("SoLuong")%>'></asp:Label>
                                                <asp:Button CssClass="btn_trong_rpt" ID="btn_cong_rpt" OnClick="btn_cong_rpt_Click" runat="server" Text="+" />
                                            </div>
                                        </td>
                                        <td colspan="1" style="width:128px">
                                            <asp:Label ID="lb_TongTien_rpt" runat="server" Text="1000"></asp:Label>
                                        </td>
                                        <td colspan="1" style="width:149px">
                                            <asp:Button CommandArgument='<%#Eval("idSP")%>' CssClass="btn_trong_rpt" ID="btn_Xoa_rpt" runat="server" Text="Xóa" OnClick="btn_Xoa_rpt_Click"/>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        
                        </table>
                    </ItemTemplate>
                </asp:Repeater>
        
            <div class="tongcong">
                <div style="display:flex;align-items:center;width:200px">
                    <%--<asp:CheckBox AutoPostBack="true" ID="cb_ChonTatCa" OnCheckedChanged="cb_ChonTatCa_CheckedChanged" runat="server" />--%>
                    <%--<div style="margin-left:5px">Chọn Tất Cả</div>--%>
                </div>

                <div style="width:100%;text-align:right;margin-right:10px">
                    Tổng Thanh Toán(<asp:Label ID="lb_SLSanPham" runat="server" Text="0"></asp:Label> Sản Phẩm):
                    <span style="color:var(--primary-color);text-decoration:underline">
                        đ
                    </span >
                    <span style="color:var(--primary-color)">
                        <asp:Label ID="lb_ThongTienCanThanhToan" runat="server" Text="000"></asp:Label>
                    </span>
                </div>

                <div style="width:150px">
                    <asp:Button CssClass="btnMuaHang" ID="btn_MuaHang" OnClick="btn_MuaHang_Click" runat="server" Text="Mua Hàng" />
                </div>

            </div>

        </div>


    </div>
    

    <div class="form" runat="server" visible ="false" id="form_muahang"> 
        <div class="form__overlay">
        </div> 
        <div class="form__body">
            <div class="btn_thoat">
                <asp:Button ID="btn_thoat_form" runat="server" Text="X" OnClick="btn_thoat_form_Click"/>
            </div>
            <div style="display:flex;height:300px">
                <div class="form__body-inner">
                    <div class="inner-title">
                        Thanh Toán
                    </div>
                    <div class="inner-items" style="margin-top:20px;">
                        <asp:TextBox ID="txt_TenNguoiNhan"  PlaceHolder="Tên Người Nhận" runat="server"></asp:TextBox>
                    </div>
                    <div class="inner-items">
                        <asp:TextBox ID="txt_SDT" runat="server" PlaceHolder="Số Điện Thoại"></asp:TextBox>
                    </div>
                    <div class="inner-items"> 
                        <asp:TextBox ID="txt_DiaChi" PlaceHolder="Địa Chỉ" runat="server"></asp:TextBox>
                    </div>
                    <div class="inner-items">
                        <asp:Label ID="lb_thongbao_form" CssClass="thongbao" Visible="false" runat="server" Text="Vui lòng nhập đầy đủ thông tin"></asp:Label>
                    </div>
                    <div class="inner-items"> 
                        <asp:Button CssClass="btn" ID="btn_ThanhToan_form" OnClick="btn_ThanhToan_form_Click" runat="server" Text="Thanh Toán" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

