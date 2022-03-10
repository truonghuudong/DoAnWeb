
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


declare cursor_sp cursor
	for select IdSP from SanPham
declare @idsp int
open cursor_sp
fetch next from cursor_sp into @idsp
while(@@FETCH_STATUS=0)
	begin
		update SanPham set TyLeThue = 5  where IdSP=@idsp
		fetch next from cursor_sp into @idsp
	end
close cursor_sp
deallocate cursor_sp