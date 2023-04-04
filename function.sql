---TẠO BẢNG
CREATE TABLE hocsinh
(
	mahs int,
  	tenhs varchar(50),
  	gioitinh varchar(10),
  	diachi varchar(50),
  	namsinh int,
  	diem int
)

---THÊM DỮ LIỆU CHO BẢNG
INSERT INTO hocsinh VALUES (1, n'Nguyễn Văn A', N'Nam', N'Tp.HCM', 2002, 9);
INSERT INTO hocsinh VALUES (2, n'Nguyễn Văn B', N'Nữ', N'Cà Mau', 2001, 8);
INSERT INTO hocsinh VALUES (3, n'Nguyễn Văn D', N'Nam', N'An Giang', 2004, 7);
INSERT INTO hocsinh VALUES (4, n'Nguyễn Văn E', N'Nữ', N'Tiền Giang', 2003, 6);
INSERT INTO hocsinh VALUES (5, n'Nguyễn Văn F', N'Nam', N'Hậu Giang', 2003, 5);
INSERT INTO hocsinh VALUES (6, n'Nguyễn Văn G', N'Nữ', N'Vĩnh Long', 2001, 3);
INSERT INTO hocsinh VALUES (7, n'Nguyễn Văn H', N'Nam', N'Tp.HCM', 2000, 2);
INSERT INTO hocsinh VALUES (8, n'Nguyễn Văn I', N'Nữ', N'Hà Nội', 2002, 5);
INSERT INTO hocsinh VALUES (9, n'Nguyễn Văn K', N'Nam', N'Gia Lai', 2000, 10);
INSERT INTO hocsinh VALUES (10, n'Nguyễn Văn L', N'Nữ', N'Kon Tum', 2002, 7);
INSERT INTO hocsinh VALUES (11, n'Nguyễn Văn M', N'Nam', N'Tiền Giang', 2004, 2);
INSERT INTO hocsinh VALUES (12, n'Nguyễn Văn N', N'Nữ', N'Long An', 2000, 3 );

---KIỂM TRA DỮ LIỆU BẢNG
SELECT * FROM hocsinh

---FUNCTION TÍNH TỔNG SỐ HỌC SINH
create function total_hocsinh()
returns int
language plpgsql
as
$$
declare
   total integer;
begin
   select count(*) 
   into total
   from hocsinh;
   return total;
end;
$$;

---KIỂM TRA FUNCTION VỪA VIẾT
select total_hocsinh();

---VIẾT FUNCTION ĐẾM SỐ HỌC SINH CÓ SỐ ĐIỂM NẰM TRONG KHOẢNG MONG MUỐN
create function gethocsinhCountBydiem(diem_from int, diem_to int)
returns int
language plpgsql
as
$$
declare
   total_diem integer;
begin
   select count(*) 
   into total_diem
   from hocsinh
   where diem between diem_from and diem_to;
   return total_diem;
end;
$$;

---KIỂM TRA FUNCTION VỪA VIẾT
SELECT gethocsinhCountBydiem(5,9);


---FUNCTION TRẢ VỀ TABLE (TABLE CÓ 2 CỘT)
CREATE FUNCTION get_hocsinh (p_pattern VARCHAR) 
RETURNS TABLE 
	(
        hocsinh_tenhs VARCHAR,
        hocsinh_diem INT
	) 
LANGUAGE plpgsql  
AS $$
BEGIN
    RETURN QUERY SELECT
        tenhs,
        cast( diem as integer)
    FROM
        hocsinh
    WHERE
        tenhs ILIKE p_pattern ;
END; 
$$;

---KIỂM TRA FUNCTION VỪA VIÉT
SELECT * FROM get_hocsinh('Ng%');

---FUNCTION TRẢ VỀ TABLE (TABLE CÓ 3 CỘT)
CREATE FUNCTION get_hocsinh1 (p_pattern VARCHAR) 
RETURNS TABLE 
	(
        hocsinh_tenhs VARCHAR,
      	hocsinh_diachi VARCHAR,
        hocsinh_diem INT
	) 
LANGUAGE plpgsql  
AS $$
BEGIN
    RETURN QUERY SELECT
        tenhs, diachi,
        cast( diem as integer)
    FROM
        hocsinh
    WHERE
        tenhs ILIKE p_pattern;
END; 
$$;

---KIỂM TRA FUNCTION VỪA VIẾT
SELECT * FROM get_hocsinh1('%A');


