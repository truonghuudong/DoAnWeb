using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Form_NguoiBan_YeuCauDanhMuc_ThemYeuCauDanhMuc : System.Web.UI.Page
{
    //1 đã duyệt, 2 chờ duyệt, 3 đã hủy
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddl_DanhMuc.DataSource = GetDanhMuc();
            ddl_DanhMuc.DataValueField = "IdDanhMuc";
            ddl_DanhMuc.DataTextField = "TenDanhMuc";
            ddl_DanhMuc.DataBind();
        }
    }


    private DataTable GetDanhMuc()
    {
        SqlParameter[] p = { };
        return DB.ExecuteQuery("GetDanhMuc", p);
    }
    int GetIdTaiKhoanTuSession()
    {
        UserLogin user = new UserLogin();
        user = (UserLogin)Session["User"];
        return user.Id;
    }

    void SetChiTietDanhMuc(string idDanhMuc,string tenDanhMuc)
    {
        SqlParameter[] p =
        {
            new SqlParameter("@idTaiKhoan",SqlDbType.NVarChar,10),
            new SqlParameter("@iddanhmuc",SqlDbType.NVarChar,10),
            new SqlParameter("@tenctd",SqlDbType.NVarChar,100)
        };
        p[0].Value = GetIdTaiKhoanTuSession();
        p[1].Value = idDanhMuc;
        p[2].Value = tenDanhMuc;
        DB.ExecuteNonQuery("SetChiTietDanhMuc", p);
    }

    protected void btn_GuiYeuCau_Click(object sender, EventArgs e)
    {
        //try
        //{
            string idDanhMuc = ddl_DanhMuc.SelectedValue.ToString();
            string tenDanhMuc = txt_TenChiTietDanhMuc.Text;
            if (tenDanhMuc == "")
            {

            }
            else
            {
                SetChiTietDanhMuc(idDanhMuc, tenDanhMuc);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Thêm Yêu Cầu Danh Mục Thành Công')", true);
            }
        //}
        //catch
        //{

        //}
    }
}