
alter proc GetThongTinTaiKhoan(@idTaiKhoan nvarchar(10))
as
	select * from TaiKhoan where IdTaiKhoan =  @idTaiKhoan

alter proc UpdateThongTinTaiKhoan(@idTaiKhoan nvarchar(10),@TenNguoiDung nvarchar(200),
				@Email nvarchar(200),@SDT nvarchar(200),@HinAnh nvarchar(200))
	as
		if(@HinAnh !='')
			begin
				update TaiKhoan set Anh = @HinAnh,TenNguoiDung=@TenNguoiDung,Email=@Email,SDT = @SDT WHERE IdTaiKhoan=@idTaiKhoan
			end
		else
			update TaiKhoan set TenNguoiDung=@TenNguoiDung,Email=@Email,SDT = @SDT WHERE IdTaiKhoan=@idTaiKhoan

alter proc UpdateMatKhauTaiKhoan(@idTaiKhoan nvarchar(10),@MatKhau nvarchar(35))
as 
	update TaiKhoan set MatKhau = @MatKhau where IdTaiKHoan = @idTaiKhoan


