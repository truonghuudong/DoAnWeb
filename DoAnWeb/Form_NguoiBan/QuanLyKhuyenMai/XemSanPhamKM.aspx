<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_NguoiBan.master" AutoEventWireup="true" CodeFile="XemSanPhamKM.aspx.cs" Inherits="Form_NguoiBan_QuanLyKhuyenMai_XemSanPhamKM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Các Sant Phẩm Đang Khuyến Mãi</title>
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

            .sanphamkhuyenmai{
                border-radius:5px;
                border-collapse:collapse;
                width:100%;
                font-size:13px;
                box-shadow:rgba(0,0,0,0.3) 2px 2px;
                border-left:1px solid rgba(0,0,0,0.06);
            }

                .sanphamkhuyenmai th:first-child{
                    border-top-left-radius:5px;
                }
                .sanphamkhuyenmai th:last-child{
                    border-top-right-radius:5px;
                }
                .sanphamkhuyenmai th {
                    background-color: cornflowerblue;
                    text-align: center;
                    padding: 8px;
                }
                .sanphamkhuyenmai td {
                    /*border: 1px solid black;*/
                    text-align: center;
                    padding: 8px;
                    font-size:1.7rem;
                    font-weight:500;
                }
                .sanphamkhuyenmai tr:nth-child(even) {
                    background-color: lightgrey;
                }


                .td-tensannpham{
                    line-height: 1.8rem;
                    font-weight: 400;
                    overflow: hidden;
                    height: 1.7rem;
                    font-size:1.3rem;
                    display: block;
                    display: -webkit-box;
                    -webkit-box-orient: vertical;
                    -webkit-line-clamp: 1;
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
            Các Sản Phầm Được Khuyến Mãi
        </div>
        <div class="noidung-thongke">
            <table class="sanphamkhuyenmai">
                <tr>
                    <th style="width:120px">Id Sản Phẩm</th>
                    <th >Tên Sản Phẩm</th>
                    <th style="width:120px">Ảnh</th>
                    <th style="width:120px">Ngày Bắt Đầu</th>
                    <th style="width:120px">Ngày Kết Thúc</th>
                    <th style="width:150px">Tỷ Lệ Khuyến Mãi</th>
                </tr>
                <asp:Repeater ID="rpt_ThongKe"  runat="server">
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
                                <%#Eval("NgayBatDau")%>
                            </td>
                            <td>
                                <%#Eval("NgayKetThuc")%>
                            </td>
                            <td>
                                 <%#Eval("TiLeKhuyenMai")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
        </div>



        <%-- Phan trang --%>

        <div class="phantrang">
            <div>
                <asp:Button cssclass="btn_page" ID="btn_TrangDau" runat="server" Text="<<" OnClick="btn_TrangDau_Click"/>
            </div>
            <div>
                <asp:Button cssclass="btn_page_nextprev"  ID="btn_Prev" runat="server" Text="<" OnClick="btn_Prev_Click"/>
            </div>
            <div>
                <asp:TextBox cssclass="btn_page_numberpage" ID="txt_STTPage" runat="server" Enabled="false"></asp:TextBox>
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

