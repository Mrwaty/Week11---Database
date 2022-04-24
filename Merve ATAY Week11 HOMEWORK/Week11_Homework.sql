(M:Manuel olarak, K:SQL komutlarıyla, C:Python kodlariyla)

2- 'class4' veritabanı olusturun (M). Veritabanı silindi (M). Ayni veri tabanı yine olusturun (K)

CREATE DATABASE class4
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'German_Germany.1252'
    LC_CTYPE = 'German_Germany.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

4- ER modeldeki tablolardan 3 tanesini M olusturun.
	(category , film_category, payment)

5- ER modeldeki tablolardan 3 tanesini K olusturun.
	(country, city, actor)

	CREATE TABLE country(
	country_id integer not null primary key,
	county varchar(20) not null,
	last_update varchar(20));

	CREATE TABLE city(
	city_id integer not null primary key,
	city varchar(20) not null,
	countr_id integer not null,
	last_update varchar(20));

	CREATE TABLE actor(
	actor_id integer not null primary key,
	first_name varchar(20) not null,
	last_name varchar(20) not null,
	last_update varchar(20));

6- ER modeldeki tablolardan 3 tanesini C olusturun.
	(store, language, inventory)

import psycopg2

conn= psycopg2.connect(database='class4', user='postgres', password='****')
cur= conn.cursor()
command_1= '''create table store
(
    store_id integer not null primary key,
    manager_staff_id integer not null,
    adress_id integer not null,
    last_update timestamp with time zone not null
)'''

command_2= '''create table inventory
(
    inventory_id integer not null primary key,
    film_id integer not null,
    store_id integer not null,
    last_update timestamp with time zone not null
)'''

command_3= '''create table language
(
    language_id integer not null primary key,
    name varchar(20) not null,
    last_update timestamp with time zone not null
)'''

cur.execute(command_1)
cur.execute(command_2)
cur.execute(command_3)

cur.close()
conn.commit()
conn.close()


8- Olusturdugunuz 3 tabloya K ile 5 veri girişi yapin.

INSERT INTO language(language_id,name,last_update)
VALUES (1,'English','2006-02-15 10:02:19' );

INSERT INTO language(language_id,name,last_update)
VALUES (2,'Italian','2006-02-15 10:02:19' );

INSERT INTO language(language_id,name,last_update)
VALUES (3,'Japanese','2006-02-15 10:02:19' );

INSERT INTO language(language_id,name,last_update)
VALUES (4,'Mandarin','2006-02-15 10:02:19' );

INSERT INTO language(language_id,name,last_update)
VALUES (5,'French','2006-02-15 10:02:19' );

9- Olusturdugunuz 3 tabloya C ile 5 veri girişi yapin.

import psycopg2

conn= psycopg2.connect(database='class4', user='postgres', password='****')
cur= conn.cursor()

cur.execute('INSERT INTO store values(%s,%s,%s,%s)',(1, 1, 1, '2006-02-15 09:57:12'))

cur.execute('INSERT INTO inventory values(%s,%s,%s,%s)',(1, 1, 1, '2006-02-15 10:09:17'))

cur.execute('INSERT INTO store values(%s,%s,%s,%s)',(2, 2, 2, '2006-02-15 09:57:12'))

cur.execute('INSERT INTO inventory values(%s,%s,%s,%s)',(2, 1, 1, '2006-02-15 09:57:12'))

cur.execute('INSERT INTO inventory values(%s,%s,%s,%s)',(3, 1, 1, '2006-02-15 09:57:12'))

cur.close()
conn.commit()
conn.close()

11- 3 tablodaki birer veriyi K ile degistirin.

UPDATE language
SET language_id=6 , name='German'
WHERE language_id=1;

UPDATE country
SET country_id=97 , country='Turkey'
WHERE country_id=1;

UPDATE city
SET city_id=589 , city='York'
WHERE city_id=1;

12- 3 tablodaki birer veriyi C ile degistirin.

import psycopg2

conn= psycopg2.connect(database='class4', user='postgres', password='****')
cur= conn.cursor()

cur.execute('UPDATE inventory SET inventory_id=%s where inventory_id=%s' , (5,1))
cur.execute('UPDATE language SET name=%s where language_id=%s' , ('German',1))
cur.execute('UPDATE category SET name=%s where category_id=%s' , ('Documentary',5))
cur.close()

conn.commit()
conn.close()


13- 3 tablonun son satirini M ile silin.
	(actor, category, country)  --last_update satiri silindi.

14- 3 tablonun son satirini K ile silin.

DELETE from city
WHERE city_id=589;

DELETE from language
WHERE name='German';

DELETE from actor
WHERE actor_id=5;

15- 3 tablonun son satirini C ile silin.

import psycopg2

conn= psycopg2.connect(database='class4', user='postgres', password='****')
cur= conn.cursor()

cur.execute('DELETE from actor where actor_id=4')
cur.execute('DELETE from language where language_id=5')
cur.execute('DELETE from film_category where film_id=5')

cur.close()
conn.commit()
conn.close()

16- 1 tabloyu M ile silin.
	(actor)

17- 1 tabloyu K ile silin.

DROP TABLE city;

18- 1 tabloyu C ile silin.

import psycopg2

conn= psycopg2.connect(database='class4', user='postgres', password='****')
cur= conn.cursor()
cur.execute('DROP TABLE language')
cur.close()
conn.commit()
conn.close()

19- Kalan tablolardan 1 tanesinin 2 veya 3 sutununu K ile baska bir tablo olarak olusturun.

CREATE TABLE actor_name 
(
	first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL
)

INSERT INTO actor_name
SELECT first_name,last_name from actor;

20- Kalan tablolardan 1 tanesinin 2 veya 3 sutununu C ile baska bir tablo olarak olusturun.

import psycopg2

conn=psycopg2.connect("dbname=class4 user=postgres password=***")
cur=conn.cursor()
command='''CREATE TABLE customer_name 
(
	first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL
)

INSERT INTO customer_name
SELECT first_name,last_name from customer;'''

cur.execute(command)

cur.close()
conn.commit()
conn.close()

21- Tablolardan 1 tanesini M ile truncate edin.
	(category)

22- Tablolardan 1 tanesini K ile truncate edin.
	TRUNCATE TABLE country;

23- Tablolardan 1 tanesini C ile truncate edin.
import psycopg2

conn= psycopg2.connect(database='class4', user='postgres', password='****')
cur= conn.cursor()

command = '''TRUNCATE TABLE film_category;'''
cur.execute(command)

cur.close()
conn.commit()
conn.close()

24- Truncate edilmis tablolari M ile silin.
	(category,country,film_category)

25- 2 tabloyu K ile silin.

DROP TABLE inventory;
DROP TABLE store;

26- 2 tabloyu C ile silin.

import psycopg2

conn= psycopg2.connect(database='class4', user='postgres', password='****')
cur= conn.cursor()

command = '''DROP TABLE language;
DROP TABLE city;'''
cur.execute(command)

cur.close()
conn.commit()
conn.close()

30- Import ettiginiz bu tabloyu C ile silin.

import psycopg2
conn=psycopg2.connect("dbname=class4 user=postgres password=***")
cur=conn.cursor()
command="""DROP TABLE staff;"""
cur.execute(command)

cur.close()
conn.commit()
conn.close()

32- DB nizde 15 adet tablo olmasi lazim. Her tabloyu teker teker goruntuleyin ve kolon isimlerine bakarak, 5 tablodaki hangi kolonun PK ve FK olduğunu yazin.

actor = actor_id(PK) , first_name(FK) , last_name(FK) 
category = category_id(PK) , name(FK) 
city = city_id(PK) , city(FK) , country_id (PK)
film_category = film_id(PK) , category_id(PK) 
film_actor = actor_id(PK) , film_id (PK) 

Sorgular? (Asagidaki sorularin cevaplarini ve bu cevabi bulurken kullandiginiz kodlari yazin)

33- Action filmlerinin ortalama suresi ne kadar?

SELECT AVG(length) FROM film 
WHERE film_id IN ( SELECT film_id FROM film_category WHERE category_id=1);

34- En cok staff olan store hangisidir?

SELECT COUNT(*),manager_staff_id FROM store 
GROUP BY manager_staff_id 
ORDER BY COUNT(*) DESC 
LIMIT 1;

35- 'Gene Willis' adli actorun oynadigi filmlerin ratingi nedir?

SELECT film.film_id, rating FROM film 
INNER JOIN film_actor ON film.film_id=film_actor.film_id
WHERE film_actor.actor_id=96

36- Aktif customer sayisi nedir?

SELECT active,count(*) FROM customer 
GROUP BY active 
HAVING active=1

37- 'C' harfiyle baslayan filmler hangileridir?
SELECT * FROM film WHERE title LIKE 'C%'

38- 4$ den az odeme yapan musterilerin e-mail edresleri nedir?

SELECT customer.email FROM customer 
INNER JOIN payment ON customer.customer_id=payment.customer_id
WHERE payment.amount<4

39- Moscowda ikamet eden staff ve customer tablosu? (sadece isim/soyisim sutunu olsun)

SELECT first_name, last_name FROM customer 
wHERE address_id=(SELECT address_id FROM address WHERE city_id=(SELECT city_id FROM city WHERE city='Moscow'))

40- En az kiralanan 5 film hangisidir?

SELECT COUNT(*),film_id, title FROM film
GROUP BY film_id
ORDER BY COUNT(*) ASC LIMIT 5;

41- 2006 yilinda yayinlanan ingilizce filmler hangileridir?

SELECT title FROM film 
WHERE release_year=2006 AND language_id=(SELECT language_id FROM language WHERE name='English' )