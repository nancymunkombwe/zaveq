-- Optional fictional catalogue. Run once after 001_schema.sql.
begin;
insert into public.stores(id,name,kind,city,description,status) values
('10000000-0000-4000-8000-000000000001','Studio North','retail','Lusaka','Contemporary essentials for everyday dressing.','active'),
('10000000-0000-4000-8000-000000000002','The Local Edit','local','Lusaka','Independent style, curated with care.','active'),
('10000000-0000-4000-8000-000000000003','Copper Atelier','local','Kitwe','Accessories inspired by craft and modern living.','active'),
('10000000-0000-4000-8000-000000000004','Form & Field','retail','Ndola','Modern wardrobe staples.','active');
insert into public.products(store_id,name,category,price,stock,sizes,color,image,description,active) values
('10000000-0000-4000-8000-000000000001','The city blazer','Women',480,12,array['S','M','L'],'Sand','/products/blazer.svg','A relaxed silhouette for workdays and evenings.',true),
('10000000-0000-4000-8000-000000000002','After hours dress','Women',320,9,array['S','M','L'],'Merlot','/products/dress.svg','A fluid midi dress.',true),
('10000000-0000-4000-8000-000000000004','Everyday runner','Shoes',550,15,array['36','37','38','39','40','41','42'],'Ivory','/products/sneaker.svg','Minimal sneakers for everyday looks.',true),
('10000000-0000-4000-8000-000000000003','Woven carryall','Accessories',240,7,array['One size'],'Honey','/products/bag.svg','A textured carryall.',true),
('10000000-0000-4000-8000-000000000004','Weekend Oxford','Men',290,11,array['S','M','L','XL'],'Blue','/products/shirt.svg','A versatile button-up.',true),
('10000000-0000-4000-8000-000000000002','Wide leg denim','Women',360,8,array['26','28','30','32'],'Indigo','/products/jeans.svg','High-rise wide-leg denim.',true),
('10000000-0000-4000-8000-000000000003','Golden hour hoops','Accessories',110,17,array['One size'],'Gold','/products/earrings.svg','Sculptural hoops.',true),
('10000000-0000-4000-8000-000000000001','Cloud knit','Men',260,10,array['S','M','L','XL'],'Oat','/products/knit.svg','A soft neutral knit.',true);
commit;
