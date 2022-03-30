
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



create proc GetSanPhamTheoGia(@timKiem int)
as
	begin
		select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,sp.SoLuong,sp.MoTa,(sp.GiaSP-sp.GiaSP*ctkm.TiLeKhuyenMai/100) as GiaKhuyenMai,
			ctkm.TiLeKhuyenMai,tk.TenTaiKhoan,tk.IdTaiKhoan
			from dbo.SanPham sp,dbo.KhuyenMai km,dbo.ChiTietKhuyenMai ctkm,TaiKhoan tk
			where sp.IdSP = ctkm.IdSP and ctkm.IdKhuyenMai=km.IdKhuyenMai and sp.IdTaiKhoan = tk.IdTaiKhoan
					and km.TrangThai=1 and sp.GiaSP <= @timKiem
			union
			select sp.IdSP,sp.TenSP,sp.AnhSP,sp.GiaSP,sp.SoLuong,sp.MoTa,sp.GiaSP as GiaKhuyenMai,
				0 as TiLeKhuyenMai,tk.TenTaiKhoan,tk.IdTaiKhoan
			from dbo.SanPham sp,TaiKhoan tk
			where sp.GiaSP <= @timKiem and sp.IdSP not in (select IdSP from ChiTietKhuyenMai) and sp.IdTaiKhoan = tk.IdTaiKhoan
	end



DECLARE cursor_sp cursor
	for select IdSP from SanPham
declare @idsp int
open cursor_sp
fetch next from cursor_sp into @idsp
while (@@FETCH_STATUS = 0)
	begin
		if(@idsp>=197)
			begin
				insert into Size values(@idsp,'S')
				insert into Size values(@idsp,'M')
				insert into Size values(@idsp,'L')
			end
		fetch next from cursor_sp into @idsp
	end
close cursor_sp
deallocate cursor_sp