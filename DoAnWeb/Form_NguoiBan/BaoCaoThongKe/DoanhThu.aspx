<%@ Page Title="" Language="C#" MasterPageFile="~/Form_NguoiBan/BaoCaoThongKe/MasterPage_BaoCaoThongKe.master" AutoEventWireup="true" CodeFile="DoanhThu.aspx.cs" Inherits="Form_NguoiBan_BaoCaoThongKe_DoanhThu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Doanh Thu</title>
    <style>
        .ngay{
            margin-left:30px;
            padding-bottom:15px;
            margin-top:15px;
            display:flex;
            background-color:var(--while-color);
            box-shadow:rgba(0,0,0,0.1) 2px 2px;
        }
        .ngaybatdau{
            text-align:center;
            margin:auto;
        }
        .ngayketthuc{
            text-align:center;
            margin:auto;
        }
        .title{
            padding:10px;
            font-size:1.5rem;
            font-weight:bold;
        }
        /*css calendar*/

         .thongke_ngay{
            margin-top:15px;
            display:flex;
        }
        .txtngay:first-child{
            display:flex;
            margin-right:50px;
        }
        .txtngay:first-child input[type=text]{
            margin-left:63px;
        }



        .txtngay:last-child{
            margin-left:50px;
        }

        .input_text{
            margin-left:10px;
            max-width:100px;
            text-align:center;
        }


        .myCalendar{
            z-index: 1;
            margin-top:10px;
            position:absolute;
            background-color: #f2f2f2;  
            width: 250px;  
            box-shadow:rgba(0,0,0,0.1) 2px 2px;
            border:10px solid #4CCAEF !important;
            border-top:0px !important;}
        
            .myCalendar a {  
            text-decoration: none;  }
            
        .myCalendar .myCalendarTitle {  
            font-weight: bold;  
            height:35px;line-height:35px;
            background-color:#4CCAEF;
            color:#ffffff;
        }  
        .myCalendar th.myCalendarDayHeader  
        {
            height:25px;
            border-bottom: outset 2px #fbfbfb; 
            border-right: outset 2px #fbfbfb; 
        }
        .myCalendar td.myCalendarDay {  
            border: outset 2px #fbfbfb;
        }  
          .myCalendar td.myCalendarDay:nth-child(7) a{color:#c52e2e !important;}
        .myCalendar .myCalendarNextPrev {  
            text-align: center;  
        }  

        .myCalendar .myCalendarNextPrev a  {font-size:1px;}
        .myCalendar .myCalendarNextPrev:nth-child(1) a{color:#4CCAEF!important;background:url("prevMonth.png") no-repeat center center;}
        .myCalendar .myCalendarNextPrev:nth-child(1) a:hover,.myCalendar .myCalendarNextPrev:nth-child(3) a:hover{background-color:transparent;}
        .myCalendar .myCalendarNextPrev:nth-child(3) a{color:#4CCAEF!important;background:url("nextMonth.png") no-repeat center center;}
        .myCalendar td.myCalendarSelector a {  
            background-color: #25bae5;  
        }  

        .myCalendar .myCalendarDayHeader a,
        .myCalendar .myCalendarDay a,   
        .myCalendar .myCalendarSelector a,  
        .myCalendar .myCalendarNextPrev a {  
            display: block;  
            line-height: 20px;  
        }  
        .myCalendar .myCalendarToday{  background-color: #f2f2f2; -webkit-box-shadow: 0 0 7px 3px #e5e5e5;
        box-shadow: 0 0 7px 3px #e5e5e5;}
        .myCalendar .myCalendarToday a{color:#25bae5 !important;}
        .myCalendar .myCalendarDay a:hover,   
        .myCalendar .myCalendarSelector a:hover {  
            background-color: #25bae5;  
        }



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

            .doanhthu{
                border-radius:5px;
                border-collapse:collapse;
                width:100%;
                font-size:13px;
                box-shadow:rgba(0,0,0,0.3) 2px 2px;
                border-left:1px solid rgba(0,0,0,0.06);
            }

                .doanhthu th:first-child{
                    border-top-left-radius:5px;
                }
                .doanhthu th:last-child{
                    border-top-right-radius:5px;
                }
                .doanhthu th {
                    background-color: cornflowerblue;
                    text-align: center;
                    padding: 8px;
                }
                .doanhthu td {
                    /*border: 1px solid black;*/
                    text-align: center;
                    padding: 8px;
                    font-size:1.7rem;
                    font-weight:500;
                }
                .doanhthu tr:nth-child(even) {
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
      
    <script type="text/javascript">
        function txt_TuNgayClick() {
                document.getElementById("<%=ibtn_TuNgay.ClientID%>").click();
        }
        function txt_DenNgayClick() {
                document.getElementById("<%=ibtn_DenNgay.ClientID%>").click();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

       <div class="ngay">
            <div class="thongke_ngay">
                    <div class="txtngay">
                        Từ Ngày:
                        <div class="txtngay_input">
                            <asp:TextBox CssClass="input_text input_text_tungay" ID="txt_TuNgay"  runat="server">
                            </asp:TextBox>
                            <asp:Calendar ID="cl_TuNgay" OnSelectionChanged="cl_TuNgay_SelectionChanged"  runat="server" Visible="false" DayNameFormat="FirstLetter" Font-Names="Tahoma" Font-Size="15px" NextMonthText="." PrevMonthText="." SelectMonthText="»" SelectWeekText="›" class="myCalendar" >
                                <OtherMonthDayStyle ForeColor="#b0b0b0" />
                                <DayStyle CssClass="myCalendarDay" ForeColor="#2d3338" />
                                <DayHeaderStyle CssClass="myCalendarDayHeader" ForeColor="#2d3338" />
                                <SelectedDayStyle Font-Bold="True" Font-Size="12px" CssClass="myCalendarSelector" />
                                <TodayDayStyle CssClass="myCalendarToday" />
                                <SelectorStyle CssClass="myCalendarSelector" />
                                <NextPrevStyle CssClass="myCalendarNextPrev" />
                                <TitleStyle CssClass="myCalendarTitle" />
                            </asp:Calendar>
                            <asp:ImageButton ID="ibtn_TuNgay" hidden="hidden" runat="server" OnClick="ibtn_TuNgay_Click" ></asp:ImageButton>
                        </div>
                    </div>
                    <div class="txtngay">
                        Đến Ngày:
                        <asp:TextBox class="input_text" ID="txt_DenNgay"  runat="server"></asp:TextBox>
                        <asp:Calendar ID="cl_DenNgay" OnSelectionChanged="cl_DenNgay_SelectionChanged" runat="server" Visible="false" DayNameFormat="FirstLetter" Font-Names="Tahoma" Font-Size="15px" NextMonthText="." PrevMonthText="." SelectMonthText="»" SelectWeekText="›" CssClass="myCalendar" >
                            <OtherMonthDayStyle ForeColor="#b0b0b0" />
                            <DayStyle CssClass="myCalendarDay" ForeColor="#2d3338" />
                            <DayHeaderStyle CssClass="myCalendarDayHeader" ForeColor="#2d3338" />
                            <SelectedDayStyle Font-Bold="True" Font-Size="12px" CssClass="myCalendarSelector" />
                            <TodayDayStyle CssClass="myCalendarToday" />
                            <SelectorStyle CssClass="myCalendarSelector" />
                            <NextPrevStyle CssClass="myCalendarNextPrev" />
                            <TitleStyle CssClass="myCalendarTitle" />
                        </asp:Calendar>
                        <asp:ImageButton hidden="hidden" ID="ibtn_DenNgay" runat="server" OnClick="ibtn_DenNgay_Click" ></asp:ImageButton>
                    </div>

                    <div class="thongbao">
                        <asp:Label ID="lb_thongbao" runat="server" Text=""></asp:Label>
                    </div>
                </div>
       </div>

        <div class="thongke">
            <div class="noidung-thongke">
                <table class="doanhthu">
                    <tr>
                        <th>Đơn Hàng</th>
                        <th>Ngày</th>
                        <th>Trạng Thái</th>
                        <th>Doanh Thu</th>
                        <th>Thuế</th>
                        <th>Tiền</th>
                    </tr>
                    <asp:Repeater ID="rpt_ThongKe" OnItemDataBound="rpt_ThongKe_ItemDataBound" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td><%#Eval("IdHoaDon")%></td>
                                <td>
                                    <asp:Label ID="lb_Ngay" runat="server" ></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBox Enabled="false" ID="cb_trangThai" runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="lb_DoanhThu" runat="server" ></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lb_Thue" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lb_TienSauThue" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr>
                        <td style="text-align:right" colspan="3">Tổng Cộng</td>
                        <td>
                            <asp:Label ID="lb_TongDoanhThu" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lb_TongThue" runat="server" ></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lb_TongTienSauThue" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
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


</asp:Content>

