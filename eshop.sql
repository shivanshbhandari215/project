-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------



	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------


--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Benagluru', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');



--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'Furniture', 0, '2022-07-09 23:03:26', '2022-07-09 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'Wall Accents', 1, '2022-07-09 23:03:26', '2022-07-09 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'Lighting', 2, '2022-07-09 23:03:26', '2022-07-09 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'Kitchen Alliances', 3, '2022-07-09 23:03:26', '2022-07-09 23:03:26');


--Product


INSERT INTO product_info VALUES ('F0001', 0, '2022-07-09 23:03:26', 'Fabric,SkyGreen Sofa,20Kg', 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZnVybml0dXJlfGVufDB8fDB8fA%3D%3D&w=1000&q=80', 'Wakefit Hawaii Sofa', 13185.00, 0, 200, '2022-07-11 13:03:26');
INSERT INTO product_info VALUES ('F0002', 0, '2022-07-09 23:03:26', 'Mintwud,78 Kg,Four Doors', 'https://ii1.pepperfry.com/media/catalog/product/r/e/800x880/ren-4-door-wardrobe-with-external-drawers-in-wenge-finish---mintwud-by-pepperfry-ren-4-door-wardrobe-zyxkdr.jpg', 'Ren 4 Door Wardrobe With External Drawers In Wenge Finish', 17999.00, 0, 100, '2022-07-11 13:03:26');
INSERT INTO product_info VALUES ('F0003', 0, '2022-07-09 23:03:26', 'Engineered Wood Bed with Storage (78*60inch)', 'https://wakefit-co.s3.ap-south-1.amazonaws.com/img/engineered-wood-bed/taurus/new/0.jpg', 'Wakefit Taurus Engineered Wood Bed', 15000.00, 0, 300, '2022-07-11 13:03:26');
INSERT INTO product_info VALUES ('F0004', 0, '2022-07-09 23:03:26', 'Cest la TV. With plenty of shelf and cabinet storage you can store all your books, curios, and media units in one space.', 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcS_MaUV-FLM7VDRFCoknIT9IM6lCWkWdxL-syQ7DfDJ5zXswE1TxZCqG3Br0YTWvGqhvX37HincGGBl_tP5StU8Dx54bd6c&usqp=CAE', 'Celestin XL TV Unit', 19000.00, 0, 300, '2022-07-11 13:03:26');
INSERT INTO product_info VALUES ('F0005', 0, '2022-07-09 23:03:26', 'Vintage model chair is one of its kind accent piece which defines the entire space.', 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTBI7Ly9ZpFen-gLgs0MWVqFax4hWAJlNlpD4LpnRhkBwLmByM5YmZ_ryQlpPpoOzondcdINnrMkk_O4-G7dixnjEVn3UmJ8hsN_qh3_IjH&usqp=CAE', 'Vintage model Chair', 9999.00, 1, 0, '2022-07-11 13:03:26');
INSERT INTO product_info VALUES ('F0006', 0, '2022-07-09 23:03:26', 'Stylish Escobar Coffe Table', 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQiRYDKYrtZGCQwxHYVOYddUWuFAaEWMcPVDsLRWrBznBtlrdjd962yASmkl8UrilMnq-WdlFI_XZJUolFeOGkGAaeOCdo2GtY3Eh9x1Eg&usqp=CAE', 'Escobar coffee table', 4999.00, 0, 300, '2022-07-11 13:03:26');


INSERT INTO "public"."product_info" VALUES ('WA001', 1, '2022-07-09 23:03:26', 'Showpieces Metal Table Top Gold Ornament for Showcase', 'https://m.media-amazon.com/images/I/719t6YQh9WL._SX679_.jpg', 'Space Gingko Leaf', 50.00, 0, 22, '2022-07-11 13:03:26');
INSERT INTO "public"."product_info" VALUES ('WA002', 1, '2022-07-09 23:03:26', 'Feng Shui Items for Positive Energy', 'https://m.media-amazon.com/images/I/91qV1v1Vh5S._SX679_.jpg', 'Seven Chakra Crystal Tree', 65.00, 0, 60, '2022-07-11 13:03:26');
INSERT INTO "public"."product_info" VALUES ('WA003', 1, '2022-07-09 23:03:26', 'Statue Showpiece for Home Decor Diwali Decoration and Gifting', 'https://m.media-amazon.com/images/I/91FwdCVfcJL._SX679_.jpg', 'Polyresin Sitting Buddha Idol', 45.00, 0, 40, '2022-07-11 13:03:26');
INSERT INTO "public"."product_info" VALUES ('WA004', 1, '2022-07-09 23:03:26', 'Handmade Hand-Painted Wall Hanging', 'https://m.media-amazon.com/images/I/614huT-aHoL._UX679_.jpg', 'Hanging Fish for Room Decoration', 53.00, 0,20, '2022-07-11 13:03:26');
INSERT INTO "public"."product_info" VALUES ('WA005', 1, '2022-07-09 23:03:26', 'Multi Color Wall Arts for Home', 'https://m.media-amazon.com/images/I/71VP2phVneL._SX679_.jpg', 'Metal Wall Decor Wall Hanging', 85.00, 0, 10, '2022-07-11 13:03:26');
INSERT INTO "public"."product_info" VALUES ('WA006', 1, '2022-07-09 23:03:26', 'Metal Lord Ganesha in Red Dhoti on Green Leaf Wall Hanging', 'https://m.media-amazon.com/images/I/71aXRJA2gEL._SX522_.jpg', 'Metal Lord Ganesha', 45.00, 0, 50, '2022-07-11 13:03:26');


INSERT INTO "public"."product_info" VALUES ('LT001', 2, '2022-07-09 23:03:26', 'Arstid Table Lamp, Brass/White', 'https://www.ikea.com/in/en/images/products/arstid-table-lamp-brass-white__0609329_pe684454_s5.jpg?f=xl','ARSTID Table Lamp', 1690.00, 0, 45, '2022-07-11 13:03:26');
INSERT INTO "public"."product_info" VALUES ('LT002', 2, '2022-07-09 23:03:26', 'Urbane and sophisticated, this ceiling light has a metal frame in the ageless combination of white and gold', 'https://www.whiteteak.com/media/fishpig/webp/catalog/product/cache/4f9684b790a78d2ad48602ec5021b7a8/c/l/cl18-10011_7a_.webp', 'Ceiling Light(Biult-In LED)', 999.00, 0, 53, '2022-07-11 13:03:26');
INSERT INTO "public"."product_info" VALUES ('LT003', 2, '2022-07-09 23:03:26', 'Creates shadow of size about 3 times bigger than the wood piece', 'https://cdn.shopify.com/s/files/1/1306/4195/products/wmshad013_1_1024x1024.jpg?v=1654760219', 'Lord Ganesa Creative Shadow lamp', 1499.00, 0, 70, '2022-07-11 13:03:26');
INSERT INTO "public"."product_info" VALUES ('LT004', 2, '2022-07-09 23:03:26', 'Clara 48 Brown Wooden Led Single Hanging Lamp', 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQU4qxCh3XWsK1xedfbB49GGOmJBIDtLqbe1bgfFskBRT9cF0R7WZBuYDenGF0mpanjKn2Y83SU8ceZRJWptmyIzbbpQSgqxPzChFaC7Pc&usqp=CAE', 'LED Ceiling Lights ', 199.00, 0, 45, '2022-07-11 13:03:26');
INSERT INTO "public"."product_info" VALUES ('LT005', 2, '2022-07-09 23:03:26', 'World Decor Led Couple Peacock Birds Metal Wall Art - Big, Multicolour', 'https://m.media-amazon.com/images/I/61LsEgD7uTL._SX679_.jpg', 'Led Couple Peacock Birds', 57.00, 0, 53, '2022-07-11 13:03:26');
INSERT INTO "public"."product_info" VALUES ('LT006', 2, '2022-07-09 23:03:26', 'series of space lamps including, Moon, Mars, and Jupiter', 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcSwJicEs0b6cOnZ2R6sCN_2FAoNYt94oMV9aFCq9E7MD_UKrL6QVZx4GbTLTSAaMIm6fslTi9qXjl9a30oGF04bEYB8-FkENrUeSZpPNsmU&usqp=CAE', 'Space Lamps ', 249.00, 1, 0, '2022-07-11 13:03:26');


INSERT INTO product_info VALUES ('K0001', 3, '2022-07-09 23:03:26', 'Sheesham Wood Square Dining Table with 4 Cushioned Chair', 'https://m.media-amazon.com/images/I/71qzkEpQAsL._AC_UL480_FMwebp_QL65_.jpg', 'Dining Table Set', 15000.00, 0, 200, '2022-07-11 13:03:26');
INSERT INTO product_info VALUES ('K0002', 3, '2022-07-09 23:03:26', 'Wolpin Kitchen Shelf Stainless Steel Wall Mount Knife Holder', 'https://m.media-amazon.com/images/I/71JlCH-OkAL._SX522_.jpg', 'Knife Holder', 719.00, 0, 100, '2022-07-11 13:03:26');
INSERT INTO product_info VALUES ('K0003', 3, '2022-07-09 23:03:26', 'Wooden Serving and Cooking Spoons Set Kitchen Organizer Items', 'https://m.media-amazon.com/images/I/41mVjCqQg6L.jpg', 'Wooden Spoons Set', 2000.00, 0, 300, '2022-07-11 13:03:26');
INSERT INTO product_info VALUES ('K0004', 3, '2022-07-09 23:03:26', 'Table: Length (145 cm), Width (90 cm), Height (76 cm) | Chair: Length(46 cm), Width(43 cm), Height(88 cm)', 'https://secureservercdn.net/160.153.138.217/mz6.a12.myftpupload.com/wp-content/uploads/2022/06/513k6RovPQL.jpg', 'Dining Table Set', 4999.00, 0, 200, '2022-07-11 13:03:26');
INSERT INTO product_info VALUES ('K0005', 3, '2022-07-09 23:03:26', 'Brand: LG,Colour: Black', 'https://secureservercdn.net/160.153.138.217/mz6.a12.myftpupload.com/wp-content/uploads/2022/03/Untitleddesign_31.jpg?time=1657535531', ' Convection Microwave Oven ', 1899.00, 1, 0, '2022-07-11 13:03:26');
INSERT INTO product_info VALUES ('K0006', 3, '2022-07-09 23:03:26', 'AquaSure from Aquaguard Delight RO+UV+MTDS water purifier', 'https://secureservercdn.net/160.153.138.217/mz6.a12.myftpupload.com/wp-content/uploads/2022/03/Untitleddesign_11_74926e5e-8d76-400f-be09-cc6753eab1f3.jpg?time=1657535726', 'Water Purifier', 2099.00, 0, 300, '2022-07-11 13:03:26');






------------------------------------------------------------------------------------------------------------------------


CREATE SEQUENCE IF NOT EXISTS public.hibernate_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.hibernate_sequence
    OWNER TO postgres;