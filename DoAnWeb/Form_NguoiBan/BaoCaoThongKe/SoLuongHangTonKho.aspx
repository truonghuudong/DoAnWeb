<%@ Page Title="" Language="C#" MasterPageFile="~/Form_NguoiBan/BaoCaoThongKe/MasterPage_BaoCaoThongKe.master" AutoEventWireup="true" CodeFile="SoLuongHangTonKho.aspx.cs" Inherits="Form_NguoiBan_BaoCaoThongKe_SoLuongHangTonKho" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Số Lượng Hàng Tồn Kho</title>
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
            display:flex;
        }
        .tatcahangtonkho{
            min-width:77%;
            max-width:77%;
            text-align:right;
        }


        .noidung-thongke{
            margin-top:5px;
        }

        .sanphamtonkho{
            border-radius:5px;
            border-collapse:collapse;
            width:100%;
            font-size:13px;
            box-shadow:rgba(0,0,0,0.3) 2px 2px;
            border-left:1px solid rgba(0,0,0,0.06);
        }

            .sanphamtonkho th:first-child{
                border-top-left-radius:5px;
            }
            .sanphamtonkho th:last-child{
                border-top-right-radius:5px;
            }
            .sanphamtonkho th {
                background-color: cornflowerblue;
                text-align: center;
                padding: 8px;
            }
            .sanphamtonkho td {
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


            .sanphamtonkho tr:nth-child(even) {
                background-color: lightgrey;
            }
            .anhsanpham{
                width:50px;
                height:50px;
            }
            /*phan trang*/
            .phantrang{
                    background-color:var(--ưhile-color);
                    display:flex;
                    text-align:center;
                    align-items:center;
                    align-content:center;
                    justify-content:center;
                    margin-top:15px;
                }
                .btn_page{
                    margin: 0 5px;
                    text-align:center;
                    min-width:45px;
                    min-height:25px;
                    max-height:25px;
                    font-weight:bold;
                    font-size:1.7rem;
                }
                .btn_page input[type=image]{
                    color:var(--text-color);
                }
                .btn_page:hover{
                    background-color:var(--primary-color);
                }
                .btn_page_nextprev{
                    margin: 0 5px;
                    align-items:center;
                    text-align:center;
                    min-width:45px;
                    min-height:25px;
                    font-size:1.7rem;
                    font-weight:bold;
                }
                .btn_page_nextprev:hover{
                    background-color:var(--primary-color);
                }
                .btn_page_numberpage{
                    width:50px;
                    text-align:center;
                    min-width:80px;
                    min-height:30px;
                    max-height:30px;
                    font-weight:bold
                }

                /*phan trang*/
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="thongke">
        <div class="title-thongke">
            Các Sản Phẩm Còn Trong Kho
            <div class="tatcahangtonkho">
                Tất cả sản phẩm còn:<asp:Label ID="lb_hangton" runat="server" Text="0"></asp:Label>
            </div>
        </div>
        <div class="noidung-thongke">
            <table class="sanphamtonkho">
                <tr>
                    <th style="width:120px">Id Sản Phẩm</th>
                    <th >Tên Sản Phẩm</th>
                    <th style="width:120px">Ảnh</th>
                    <th style="width:120px">Trạng Thái</th>
                    <th style="width:120px">Số Lượng</th>
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
                                <%#Eval("SoLuong")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>
        <div class="phantrang">
            <div>
                <asp:Button cssclass="btn_page" ID="btn_TrangDau" runat="server" Text="<<" OnClick="btn_TrangDau_Click"/>
            </div>
            <div>
                <asp:Button cssclass="btn_page_nextprev"  ID="btn_Prev" runat="server" Text="<" OnClick="btn_Prev_Click"/>
            </div>
            <div>
                <asp:TextBox cssclass="btn_page_numberpage" ID="txt_STTPage" runat="server" Enabled="false" ></asp:TextBox>
            </div>
            <div>
                <asp:Button cssclass="btn_page_nextprev"  ID="btn_Next" runat="server" Text=">"  OnClick="btn_Next_Click"/>
            </div>
            <div>
                <asp:Button cssclass="btn_page" ID="btn_TrangCuoi" runat="server" Text=">>" OnClick="btn_TrangCuoi_Click"/>
            </div>
        </div>
    
    </div>


</asp:Content>

