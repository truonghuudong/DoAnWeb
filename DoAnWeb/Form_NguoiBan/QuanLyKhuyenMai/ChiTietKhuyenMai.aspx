<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage_NguoiBan.master" AutoEventWireup="true" CodeFile="ChiTietKhuyenMai.aspx.cs" Inherits="Form_NguoiBan_QuanLyKhuyenMai_ChiTietKhuyenMai" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Chi Tiết Khuyến Mãi</title>
    <style>
        .main_chitietKM{
            padding:15PX;
        }
        .tiede_KM{
            text-align:center;
            font-size:25px;
            color:blue;
            padding-bottom:20px;
        }
        .conten_tyle{
            display:flex;
            margin-top:15px;
            /*justify-content:center;*/
            align-items:center;
        }
        .label_tyle{
            font-size:15px;
            padding-right:25px;
            padding-left:25px
        }
        .chitietdanhmuc-danhsach{
            border-collapse:collapse;
            width:100%;
            font-size:13px;
            box-shadow:rgba(0,0,0,0.3) 2px 2px;
            margin-top:30px;
        }
            .chitietdanhmuc-danhsach th {
                border: 1px solid black;
                background-color: cornflowerblue;
                text-align: center;
                padding: 8px;
            }
            .chitietdanhmuc-danhsach td {
                border: 1px solid black;
                text-align: center;
                padding: 8px;
            }
            .chitietdanhmuc-danhsach tr:nth-child(even) {
                background-color: lightgrey;
            }
            .image_SP{
                width:50px;
                height:50px;
            }
            .tylekhuyenmai{
                max-width:100px;
                text-align:center;
            }
            .widthlonhon{
                 max-width:300px;
            }

            .btn_them{
                margin-left:10px;
            }
            .btn_them:hover{
                background-color:var(--primary-color);
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
    <div class="main_chitietKM">
        <div class="tiede_KM">
            CHI TIẾT KHUYẾN MÃI
        </div>
        
        <div class="bang_KM">
            <table class="chitietdanhmuc-danhsach">
                    <tr>
                       
                        <th>
                            Tất cả
                            <asp:CheckBox ID="cb_TatCa_Chung" AutoPostBack="true" OnCheckedChanged="cb_TatCa_Chung_CheckedChanged"  runat="server" />
                        </th>

                        <th>
                            ID sản phẩm
                        </th>
                        <th>
                            Tên sản phẩm
                        </th>
                        <th>
                            Hình ảnh
                        </th>
                        <th>
                           Tỷ lệ 
                        </th>
                        
                    </tr>
                   
                <asp:Repeater ID="rpt_ChiTietKhuyenMai" OnItemDataBound="rpt_ChiTietKhuyenMai_ItemDataBound" runat="server">
                    <ItemTemplate>

                         <tr>
                                <td>
                                    <asp:CheckBox AutoPostBack="true" ID="cb_TrangThai" OnCheckedChanged="cb_TrangThai_CheckedChanged" runat="server" /> 
                                </td>
                                <td>
                                    
                                    <asp:Label ID="lb_idSp" runat="server" Text='<%#Eval("IdSP")%>'></asp:Label>
                                </td>
                                <td>
              
                                    <asp:Label ID="lb_NgayKetThuc_rpt" runat="server" Text='<%#Eval("TenSP")%>'></asp:Label>
                                </td>
                                <td>
                                    <img class="image_SP" src="../../HinhAnh/Sprites_SP/<%#Eval("AnhSP")%>"/>
                                </td>
                                <td>
                                    <asp:TextBox AutoPostBack="true" Enabled="false" CssClass="tylekhuyenmai" ID="txt_TyLeKhuyenMai" runat="server" OnTextChanged="txt_TyLeKhuyenMai_TextChanged"></asp:TextBox>
                                </td>
                               
                            </tr>

                    </ItemTemplate>
                </asp:Repeater>        

                </table>

            <div class="conten_tyle">
                <div class="label_tyle">
                    Tỷ lệ
                </div>
                <div>
                    <asp:TextBox CssClass="tylekhuyenmai widthlonhon" ID="txt_tyleKM_chung" runat="server"></asp:TextBox>
                </div>
                <div>
                    <asp:Button CssClass="btn_them" ID="btn_Them" runat="server" Text="Thêm" OnClick="btn_Them_Click"/>
                </div>
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
         <%-- Phan trang --%>
        </div>
    </div>
   



</asp:Content>

