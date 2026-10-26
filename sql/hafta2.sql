-- =====================================================
-- HAFTA 2 - SQL: GROUP BY, HAVING, CTE, Window Function
-- Veritabani: dvdrental
-- =====================================================


-- 1) HER KATEGORIDE KAC FILM VAR?
-- category tablosunda kategori adlari, film_category tablosunda
-- hangi filmin hangi kategoride oldugu var. Ikisini category_id
-- uzerinden birlestirip (JOIN) kategoriye gore grupluyoruz.
-- Kural: "her ... icin" sayiyorsan GROUP BY'a o gelir.
SELECT category.name, COUNT(film_category.film_id) AS film_sayisi
FROM category
JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name
ORDER BY film_sayisi DESC;


-- 2) EN AZ 65 FILMI OLAN KATEGORILER (HAVING)
-- WHERE satirlari filtreler, gruplamadan ONCE calisir.
-- HAVING gruplari filtreler, gruplamadan SONRA calisir.
-- Film sayisi grup olustuktan sonra belli oldugu icin HAVING lazim.
-- PostgreSQL'de HAVING icinde AS ile verilen isim (film_sayisi)
-- kullanilamaz, COUNT(...) tekrar yazilir.
SELECT category.name, COUNT(film_category.film_id) AS film_sayisi
FROM category
JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name
HAVING COUNT(film_category.film_id) >= 65
ORDER BY film_sayisi DESC;


-- 3) AYNI SORU, CTE ILE
-- WITH isim AS (...) bir sorgunun sonucuna isim verip
-- gecici bir tablo gibi kullanmamizi saglar.
-- Once kategori sayilarini hesapla, sonra onun uzerinden filtrele.
-- CTE'nin icinde film_sayisi gercek bir sutun oldugu icin
-- disarida HAVING yerine duz WHERE yazabiliyoruz.
-- Dikkat: noktali virgul sadece EN SONDA, parantezin icinde degil.
WITH kategori_sayilari AS (
    SELECT category.name, COUNT(film_category.film_id) AS film_sayisi
    FROM category
    JOIN film_category ON category.category_id = film_category.category_id
    GROUP BY category.name
)
SELECT * FROM kategori_sayilari
WHERE film_sayisi >= 65
ORDER BY film_sayisi DESC;


-- 4) HER RATING'IN EN UZUN 3 FILMI (WINDOW FUNCTION)
-- GROUP BY her grubu TEK satira indirir; biz her gruptan 3 film istiyoruz.
-- Window function satirlari silmez, her satirin yanina
-- "kendi grubundaki sirasini" yazar (okulda her subenin kendi siralamasi gibi).
--   PARTITION BY rating      -> filmleri rating'e gore gruplara ayir
--   ORDER BY length DESC     -> her grubun icini en uzundan kisaya sirala
--   RANK()                   -> her grupta 1, 2, 3 diye sira ver
-- Sonra CTE ile sadece sirasi 3 ve alti olanlari aliyoruz.
--
-- ROW_NUMBER / RANK / DENSE_RANK farki (notlar: 95, 95, 90):
--   ROW_NUMBER -> 1, 2, 3  (esitligi yok sayar, tam 3 tane verir)
--   RANK       -> 1, 1, 3  (esitlere ayni sira, sonra atlar)
--   DENSE_RANK -> 1, 1, 2  (esitlere ayni sira, atlamaz)
-- Burada RANK kullandik; ayni uzunluktaki filmler disarida kalmasin diye.
WITH sirali AS (
    SELECT title, rating, length,
           RANK() OVER (PARTITION BY rating ORDER BY length DESC) AS sira
    FROM film
)
SELECT * FROM sirali
WHERE sira <= 3;
