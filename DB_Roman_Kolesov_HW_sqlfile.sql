-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.0.5
-- PostgreSQL version: 15.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: public.seller | type: TABLE --
-- DROP TABLE IF EXISTS public.seller CASCADE;
CREATE TABLE public.seller (
	s_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT BY 1 MINVALUE 0 MAXVALUE 2147483647 START WITH 1 CACHE 1 ),
	s_f_name varchar(150),
	s_l_name varchar(150),
	s_address varchar(250),
	s_email varchar(150),
	CONSTRAINT seller_pk PRIMARY KEY (s_id),
	CONSTRAINT unique_s_email UNIQUE (s_email)
);
-- ddl-end --
COMMENT ON COLUMN public.seller.s_id IS E'Seller ID';
-- ddl-end --
COMMENT ON COLUMN public.seller.s_f_name IS E'Seller first name';
-- ddl-end --
COMMENT ON COLUMN public.seller.s_l_name IS E'Seller last name';
-- ddl-end --
COMMENT ON COLUMN public.seller.s_address IS E'Seller address';
-- ddl-end --
COMMENT ON COLUMN public.seller.s_email IS E'Seller email';
-- ddl-end --
ALTER TABLE public.seller OWNER TO postgres;
-- ddl-end --

-- object: public.buyer | type: TABLE --
-- DROP TABLE IF EXISTS public.buyer CASCADE;
CREATE TABLE public.buyer (
	b_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT BY 1 MINVALUE 0 MAXVALUE 2147483647 START WITH 1 CACHE 1 ),
	b_f_name varchar(150),
	b_l_name varchar(150),
	b_address varchar(250),
	b_email varchar(150),
	CONSTRAINT buyer_pk PRIMARY KEY (b_id),
	CONSTRAINT unique_b_email UNIQUE (b_email)
);
-- ddl-end --
COMMENT ON COLUMN public.buyer.b_id IS E'Buyer ID';
-- ddl-end --
COMMENT ON COLUMN public.buyer.b_f_name IS E'Buyer name';
-- ddl-end --
COMMENT ON COLUMN public.buyer.b_l_name IS E'Buyer last name';
-- ddl-end --
COMMENT ON COLUMN public.buyer.b_address IS E'Buyer address';
-- ddl-end --
COMMENT ON COLUMN public.buyer.b_email IS E'Buyer email';
-- ddl-end --
ALTER TABLE public.buyer OWNER TO postgres;
-- ddl-end --

-- object: public."Item" | type: TABLE --
-- DROP TABLE IF EXISTS public."Item" CASCADE;
CREATE TABLE public."Item" (
	i_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	i_l_num integer,
	i_description varchar(3000),
	i_s_price money,
	s_id_seller integer,
	CONSTRAINT "Item_pk" PRIMARY KEY (i_id),
	CONSTRAINT unique_l_num UNIQUE (i_l_num)
);
-- ddl-end --
COMMENT ON TABLE public."Item" IS E'Item';
-- ddl-end --
COMMENT ON COLUMN public."Item".i_id IS E'Item ID';
-- ddl-end --
COMMENT ON COLUMN public."Item".i_l_num IS E'Item lot number';
-- ddl-end --
COMMENT ON COLUMN public."Item".i_s_price IS E'Item starting price';
-- ddl-end --
COMMENT ON CONSTRAINT unique_l_num ON public."Item" IS E'unique lot number';
-- ddl-end --
ALTER TABLE public."Item" OWNER TO postgres;
-- ddl-end --

-- object: public.auction | type: TABLE --
-- DROP TABLE IF EXISTS public.auction CASCADE;
CREATE TABLE public.auction (
	a_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT BY 1 MINVALUE 0 MAXVALUE 2147483647 START WITH 1 CACHE 1 ),
	a_date date,
	a_location varchar(250),
	a_type varchar(150),
	cp_id_company integer,
	CONSTRAINT auction_pk PRIMARY KEY (a_id)
);
-- ddl-end --
COMMENT ON COLUMN public.auction.a_id IS E'Auction ID';
-- ddl-end --
COMMENT ON COLUMN public.auction.a_date IS E'Auction date';
-- ddl-end --
COMMENT ON COLUMN public.auction.a_location IS E'Auction Location';
-- ddl-end --
COMMENT ON COLUMN public.auction.a_type IS E'Auction type';
-- ddl-end --
ALTER TABLE public.auction OWNER TO postgres;
-- ddl-end --

-- object: public.category | type: TABLE --
-- DROP TABLE IF EXISTS public.category CASCADE;
CREATE TABLE public.category (
	c_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT BY 1 MINVALUE 0 MAXVALUE 2147483647 START WITH 1 CACHE 1 ),
	c_name varchar(150),
	CONSTRAINT category_pk PRIMARY KEY (c_id)
);
-- ddl-end --
ALTER TABLE public.category OWNER TO postgres;
-- ddl-end --

-- object: public.employee | type: TABLE --
-- DROP TABLE IF EXISTS public.employee CASCADE;
CREATE TABLE public.employee (
	e_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT BY 1 MINVALUE 0 MAXVALUE 2147483647 START WITH 1 CACHE 1 ),
	e_name varchar(150),
	e_role varchar(150),
	e_j_date date,
	e_d_buyer varchar(250),
	e_p_item money,
	cp_id_company integer,
	CONSTRAINT employee_pk PRIMARY KEY (e_id)
);
-- ddl-end --
COMMENT ON COLUMN public.employee.e_name IS E'employee name';
-- ddl-end --
COMMENT ON COLUMN public.employee.e_role IS E'employee role';
-- ddl-end --
COMMENT ON COLUMN public.employee.e_j_date IS E'Employee join date';
-- ddl-end --
COMMENT ON COLUMN public.employee.e_d_buyer IS E'Buyers data';
-- ddl-end --
COMMENT ON COLUMN public.employee.e_p_item IS E'price paid for the item';
-- ddl-end --
ALTER TABLE public.employee OWNER TO postgres;
-- ddl-end --

-- object: public."m2m_Item_buyer" | type: TABLE --
-- DROP TABLE IF EXISTS public."m2m_Item_buyer" CASCADE;
CREATE TABLE public."m2m_Item_buyer" (
	"i_id_Item" integer NOT NULL,
	b_id_buyer integer NOT NULL,
	CONSTRAINT "m2m_Item_buyer_pk" PRIMARY KEY ("i_id_Item",b_id_buyer)
);
-- ddl-end --

-- object: "Item_fk" | type: CONSTRAINT --
-- ALTER TABLE public."m2m_Item_buyer" DROP CONSTRAINT IF EXISTS "Item_fk" CASCADE;
ALTER TABLE public."m2m_Item_buyer" ADD CONSTRAINT "Item_fk" FOREIGN KEY ("i_id_Item")
REFERENCES public."Item" (i_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: buyer_fk | type: CONSTRAINT --
-- ALTER TABLE public."m2m_Item_buyer" DROP CONSTRAINT IF EXISTS buyer_fk CASCADE;
ALTER TABLE public."m2m_Item_buyer" ADD CONSTRAINT buyer_fk FOREIGN KEY (b_id_buyer)
REFERENCES public.buyer (b_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public."m2m_Item_category" | type: TABLE --
-- DROP TABLE IF EXISTS public."m2m_Item_category" CASCADE;
CREATE TABLE public."m2m_Item_category" (
	"i_id_Item" integer NOT NULL,
	c_id_category integer NOT NULL,
	CONSTRAINT "m2m_Item_category_pk" PRIMARY KEY ("i_id_Item",c_id_category)
);
-- ddl-end --

-- object: "Item_fk" | type: CONSTRAINT --
-- ALTER TABLE public."m2m_Item_category" DROP CONSTRAINT IF EXISTS "Item_fk" CASCADE;
ALTER TABLE public."m2m_Item_category" ADD CONSTRAINT "Item_fk" FOREIGN KEY ("i_id_Item")
REFERENCES public."Item" (i_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: category_fk | type: CONSTRAINT --
-- ALTER TABLE public."m2m_Item_category" DROP CONSTRAINT IF EXISTS category_fk CASCADE;
ALTER TABLE public."m2m_Item_category" ADD CONSTRAINT category_fk FOREIGN KEY (c_id_category)
REFERENCES public.category (c_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: seller_fk | type: CONSTRAINT --
-- ALTER TABLE public."Item" DROP CONSTRAINT IF EXISTS seller_fk CASCADE;
ALTER TABLE public."Item" ADD CONSTRAINT seller_fk FOREIGN KEY (s_id_seller)
REFERENCES public.seller (s_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public."m2m_Item_auction" | type: TABLE --
-- DROP TABLE IF EXISTS public."m2m_Item_auction" CASCADE;
CREATE TABLE public."m2m_Item_auction" (
	"i_id_Item" integer NOT NULL,
	a_id_auction integer NOT NULL,
	CONSTRAINT "m2m_Item_auction_pk" PRIMARY KEY ("i_id_Item",a_id_auction)
);
-- ddl-end --

-- object: "Item_fk" | type: CONSTRAINT --
-- ALTER TABLE public."m2m_Item_auction" DROP CONSTRAINT IF EXISTS "Item_fk" CASCADE;
ALTER TABLE public."m2m_Item_auction" ADD CONSTRAINT "Item_fk" FOREIGN KEY ("i_id_Item")
REFERENCES public."Item" (i_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: auction_fk | type: CONSTRAINT --
-- ALTER TABLE public."m2m_Item_auction" DROP CONSTRAINT IF EXISTS auction_fk CASCADE;
ALTER TABLE public."m2m_Item_auction" ADD CONSTRAINT auction_fk FOREIGN KEY (a_id_auction)
REFERENCES public.auction (a_id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public.company | type: TABLE --
-- DROP TABLE IF EXISTS public.company CASCADE;
CREATE TABLE public.company (
	cp_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT BY 1 MINVALUE 0 MAXVALUE 2147483647 START WITH 1 CACHE 1 ),
	cp_a_info varchar(3000),
	cp_is_sold boolean,
	cp_seller_info varchar,
	CONSTRAINT company_pk PRIMARY KEY (cp_id)
);
-- ddl-end --
COMMENT ON COLUMN public.company.cp_id IS E'Company ID';
-- ddl-end --
COMMENT ON COLUMN public.company.cp_a_info IS E'Company auction information';
-- ddl-end --
COMMENT ON COLUMN public.company.cp_is_sold IS E'Company sold';
-- ddl-end --
COMMENT ON COLUMN public.company.cp_seller_info IS E'Company information about seller';
-- ddl-end --
ALTER TABLE public.company OWNER TO postgres;
-- ddl-end --

-- object: company_fk | type: CONSTRAINT --
-- ALTER TABLE public.employee DROP CONSTRAINT IF EXISTS company_fk CASCADE;
ALTER TABLE public.employee ADD CONSTRAINT company_fk FOREIGN KEY (cp_id_company)
REFERENCES public.company (cp_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: company_fk | type: CONSTRAINT --
-- ALTER TABLE public.auction DROP CONSTRAINT IF EXISTS company_fk CASCADE;
ALTER TABLE public.auction ADD CONSTRAINT company_fk FOREIGN KEY (cp_id_company)
REFERENCES public.company (cp_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --


