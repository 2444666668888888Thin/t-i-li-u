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
INSERT INTO hocsinh VALUES (2, n'Lê Thị B', N'Nữ', N'Cà Mau', 2001, 8);
INSERT INTO hocsinh VALUES (3, n'Đỗ Văn C', N'Nam', N'An Giang', 2004, 7);
INSERT INTO hocsinh VALUES (4, n'Nguyễn Văn E', N'Nữ', N'Tiền Giang', 2003, 6);
INSERT INTO hocsinh VALUES (5, n'Lê Hồng H', N'Nam', N'Hậu Giang', 2003, 5);
INSERT INTO hocsinh VALUES (6, n'Nguyễn Văn G', N'Nữ', N'Vĩnh Long', 2001, 3);
INSERT INTO hocsinh VALUES (7, n' Hoài Hoài H', N'Nam', N'Tp.HCM', 2000, 2);
INSERT INTO hocsinh VALUES (8, n'Trần Thị I', N'Nữ', N'Hà Nội', 2002, 5);
INSERT INTO hocsinh VALUES (9, n'Nguyễn Văn K', N'Nam', N'Gia Lai', 2000, 10);
INSERT INTO hocsinh VALUES (10, n'Nguyễn Văn L', N'Nữ', N'Kon Tum', 2002, 7);
INSERT INTO hocsinh VALUES (11, n'Nguyễn Văn M', N'Nam', N'Tiền Giang', 2004, 2);
INSERT INTO hocsinh VALUES (12, n'Lê Thị N', N'Nữ', N'Long An', 2000, 3 );

---KIỂM TRA DỮ LIỆU BẢNG
SELECT * FROM hocsinh

---Thêm một cột diemtk vào bảng hocsinh
ALTER TABLE hocsinh ADD PRIMARY KEY (mahs);

---Chèn dữ liệu vào cột mới thêm

UPDATE hocsinh
SET tenhs = N'Lê Thị B'
WHERE mahs = 2;

UPDATE hocsinh
SET tenhs = N'Đỗ Văn B'
WHERE mahs = 3;

UPDATE hocsinh
SET tenhs = N'Lê Hoài H'
WHERE mahs = 7;

UPDATE hocsinh
SET tenhs = N'Lê Thị N'
WHERE mahs = 12;

UPDATE hocsinh
SET tenhs = N'Trần Thị I'
WHERE mahs = 8;

UPDATE hocsinh
SET tenhs = N'Lê Hồng H'
WHERE mahs = 5;

UPDATE hocsinh
SET diemtk = 6
WHERE mahs = 7;

UPDATE hocsinh
SET diemtk = 4
WHERE mahs = 8;

UPDATE hocsinh
SET diemtk = 7
WHERE mahs = 9;

UPDATE hocsinh
SET diemtk = 5
WHERE mahs = 10;

UPDATE hocsinh
SET diemtk = 1
WHERE mahs = 11;

UPDATE hocsinh
SET diemtk = 2
WHERE mahs = 12;

---FUNCTION ĐẾM TỔNG SỐ HỌC SINH
create OR REPLACE function total_hocsinh()
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
create or REPLACE function get_hocsinh_count_diem(diem_from int, diem_to int)
returns int
language plpgsql
as
$$
declare
   hocsinh_count integer;
begin
   select count(*) 
   into hocsinh_count
   from hocsinh
   where diem between diem_from and diem_to;
   return hocsinh_count;
end;
$$;

---KIỂM TRA FUNCTION VỪA VIẾT
SELECT get_hocsinh_count_diem(6,9);


---Hàm CAST dùng để chuyển đổi một biểu thức thuộc bất kỳ kiểu dữ liệu nào thành kiểu dữ liệu được chỉ định.



---FUNCTION TRẢ VỀ TABLE (TABLE CÓ 2 CỘT)
CREATE or REPLACE FUNCTION get_hocsinh_2_column (p_pattern VARCHAR) 
RETURNS TABLE 
	(
        hocsinh_tenhs VARCHAR,
        hocsinh_diem INT
	) 
LANGUAGE plpgsql  
AS $$
BEGIN
    RETURN QUERY SELECT
        tenhs, diem
    FROM
        hocsinh
    WHERE
        --diem > 5 AND
        tenhs ILIKE p_pattern ;
END; 
$$;

---KIỂM TRA FUNCTION VỪA VIẾT
SELECT * FROM get_hocsinh_2_column('L%');

---FUNCTION TRẢ VỀ TABLE (TABLE CÓ 3 CỘT)
CREATE or REPLACE FUNCTION get_hocsinh_3_column (p_pattern VARCHAR) 
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
        tenhs, diachi, diem
    FROM
        hocsinh
    WHERE
        tenhs ILIKE p_pattern;
END; 
$$;

---KIỂM TRA FUNCTION VỪA VIẾT
SELECT * FROM get_hocsinh_3_column('Ng%');


---FUNCTION THỬ
CREATE OR REPLACE FUNCTION get_hocsinh_ten_gioitinh_diem(p_pattern VARCHAR)
RETURNS TABLE 
	(
    	hocsinh_tenhs VARCHAR,
      	hocsinh_gioitinh VARCHAR,
      	hocsinh_diem INT
    )
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY SELECT
        tenhs, gioitinh,
        cast( diem as integer)
    FROM
 		hocsinh
    WHERE
        tenhs ILIKE p_pattern AND
        diem > 5 and gioitinh = N'Nữ';
END; 
$$;

---Kiểm tra
SELECT * FROM get_hocsinh_ten_gioitinh_diem('Ng%');

---FUNCTION TÍNH ĐIỂM TRUNG BÌNH CỦA HOC SINH

CREATE or REPLACE FUNCTION get_diemtrungbinh()
returns TABLE
	(
		hocsinh_tenhs VARCHAR,
      	hocsinh_diemtrungbinh INT
	)
language plpgsql
AS $$
BEGIN
	RETURN QUERY SELECT
        tenhs,
        cast( diemtrungbinh as integer)
    FROM
 		hocsinh
    WHERE
        diemtrungbinh = diemtk + diem;
END; 
$$;

SELECT * FROM get_diemtrungbinh