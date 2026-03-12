--FLO_CUSTOMERS tablosu — 19.945 müşteri
--├── MASTER_ID                         → Eşsiz müşteri numarası
--├── ORDER_CHANNEL                     → Alışveriş yapılan platforma ait hangi kanalın kullanıldığı (Android, ios, Desktop, Mobile)
--├── LAST_ORDER_CHANNEL                → En son alışverişin yapıldığı kanal
--├── FIRST_ORDER_DATE                  → Müşterinin yaptığı ilk alışveriş tarihi
--├── LAST_ORDER_DATE                   → Müşterinin yaptığı son alışveriş tarihi
--├── ORDER_NUM_TOTAL_EVER_ONLINE       → Müşterinin online platformda yaptığı toplam alışveriş sayısı
--├── ORDER_NUM_TOTAL_EVER_OFFLINE      → Müşterinin offline da yaptığı toplam alışveriş sayısı
--├── CUSTOMER_VALUE_TOTAL_EVER_ONLINE  → Müşterinin online alışverişlerinde ödediği toplam ücret
--├── CUSTOMER_VALUE_TOTAL_EVER_OFFLINE → Müşterinin offline alışverişlerinde ödediği toplam ücret
--├── INTERESTED_IN_CATEGORIES_12       → Müşterinin son 12 ayda alışveriş yaptığı kategorilerin listesi
--└── STORE_TYPE                        → 3 farklı companyi ifade eder. A company'sinden alışveriş yapan kişi B'dende yaptı ise A,B şeklinde yazılmıştır.
----------------------------------------------------------------------------------------------------------------------------------------------
-- GÖREVLER:
-- 1. Customers isimli bir veritabanı ve verilen veri setindeki değişkenleri içerecek FLO isimli bir tablo oluşturunuz.
-- 2. Kaç farklı müşterinin alışveriş yaptığını gösterecek sorguyu yazınız.
-- 3. Toplam yapılan alışveriş sayısı ve ciroyu getirecek sorguyu yazınız.
-- 4. Alışveriş başına ortalama ciroyu getirecek sorguyu yazınız.
-- 5. En son alışveriş yapılan kanal (last_order_channel) üzerinden yapılan alışverişlerin toplam ciro ve alışveriş sayılarını
-- getirecek sorguyu yazınız.
-- 6. Store type kırılımında elde edilen toplam ciroyu getiren sorguyu yazınız.
-- 7. Yıl kırılımında alışveriş sayılarını getirecek sorguyu yazınız (Yıl olarak müşterinin ilk alışveriş tarihi (first_order_date) yılını
-- baz alınız)
-- 8. En son alışveriş yapılan kanal kırılımında alışveriş başına ortalama ciroyu hesaplayacak sorguyu yazınız.
-- 9. Son 12 ayda en çok ilgi gören kategoriyi getiren sorguyu yazınız.
-- 10. En çok tercih edilen store_type bilgisini getiren sorguyu yazınız.
-- 11. En son alışveriş yapılan kanal (last_order_channel) bazında, en çok ilgi gören kategoriyi ve bu kategoriden ne kadarlık
--alışveriş yapıldığını getiren sorguyu yazınız.
-- 12. En çok alışveriş yapan kişinin ID’ sini getiren sorguyu yazınız.
-- 13. En çok alışveriş yapan kişinin alışveriş başına ortalama cirosunu ve alışveriş yapma gün ortalamasını (alışveriş sıklığını)
--getiren sorguyu yazınız.
-- 14. En çok alışveriş yapan (ciro bazında) ilk 100 kişinin alışveriş yapma gün ortalamasını (alışveriş sıklığını) getiren sorguyu
--yazınız.
-- 15. En son alışveriş yapılan kanal (last_order_channel) kırılımında en çok alışveriş yapan müşteriyi getiren sorguyu yazınız.
-- 16. En son alışveriş yapan kişinin ID’ sini getiren sorguyu yazınız. (Max son tarihte birden fazla alışveriş yapan ID bulunmakta.
--Bunları da getiriniz.)
--------------------------------------------------------------------------------------------------------------------------------------------------

--ÇÖZÜMLER

-- 1. Customers isimli bir veritabanı ve verilen veri setindeki değişkenleri içerecek FLO isimli bir tablo oluşturunuz.
SELECT * FROM FLO_CUSTOMERS
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Kaç farklı müşterinin alışveriş yaptığını gösterecek sorguyu yazınız.
SELECT COUNT(MASTER_ID) 
FROM FLO_CUSTOMERS
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Toplam yapılan alışveriş sayısı ve ciroyu getirecek sorguyu yazınız.
SELECT 
SUM(ORDER_NUM_TOTAL_EVER_OFFLINE + ORDER_NUM_TOTAL_EVER_ONLINE) AS TOPLAM_ALISVERIS_SAYISI,
SUM(CUSTOMER_VALUE_TOTAL_EVER_OFFLINE + CUSTOMER_VALUE_TOTAL_EVER_ONLINE) AS CIRO
FROM FLO_CUSTOMERS
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Alışveriş başına ortalama ciroyu getirecek sorguyu yazınız.
SELECT 
SUM(CUSTOMER_VALUE_TOTAL_EVER_OFFLINE + CUSTOMER_VALUE_TOTAL_EVER_ONLINE) /
SUM(ORDER_NUM_TOTAL_EVER_OFFLINE + ORDER_NUM_TOTAL_EVER_ONLINE)
AS ALISVERIS_BASI_ORTALAMA_CIRO
FROM FLO_CUSTOMERS
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. En son alışveriş yapılan kanal (last_order_channel) üzerinden yapılan alışverişlerin toplam ciro ve alışveriş sayılarını
-- getirecek sorguyu yazınız.

SELECT LAST_ORDER_CHANNEL,  
SUM(CUSTOMER_VALUE_TOTAL_EVER_OFFLINE + CUSTOMER_VALUE_TOTAL_EVER_ONLINE) AS TOPLAM_CIRO,
SUM(ORDER_NUM_TOTAL_EVER_OFFLINE + ORDER_NUM_TOTAL_EVER_ONLINE) AS ALISVERIS_SAYISI
FROM FLO_CUSTOMERS
GROUP BY LAST_ORDER_CHANNEL
ORDER BY TOPLAM_CIRO
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 6. Store type kırılımında elde edilen toplam ciroyu getiren sorguyu yazınız.
SELECT STORE_TYPE,
SUM(CUSTOMER_VALUE_TOTAL_EVER_OFFLINE + CUSTOMER_VALUE_TOTAL_EVER_ONLINE) AS TOPLAM_CIRO
FROM FLO_CUSTOMERS
GROUP BY STORE_TYPE
ORDER BY TOPLAM_CIRO DESC
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 7. Yıl kırılımında alışveriş sayılarını getirecek sorguyu yazınız (Yıl olarak müşterinin ilk alışveriş tarihi (first_order_date) yılını
-- baz alınız)

SELECT
YEAR(CAST(FIRST_ORDER_DATE AS DATE)) AS YIL,
SUM(ORDER_NUM_TOTAL_EVER_OFFLINE + ORDER_NUM_TOTAL_EVER_ONLINE) AS TOPLAM_ALISVERIS_SAYISI
FROM FLO_CUSTOMERS
GROUP BY YEAR(CAST(FIRST_ORDER_DATE AS DATE))
ORDER BY TOPLAM_ALISVERIS_SAYISI DESC
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 8. En son alışveriş yapılan kanal kırılımında alışveriş başına ortalama ciroyu hesaplayacak sorguyu yazınız.
SELECT LAST_ORDER_CHANNEL,
SUM(CUSTOMER_VALUE_TOTAL_EVER_OFFLINE + CUSTOMER_VALUE_TOTAL_EVER_ONLINE) /
SUM(ORDER_NUM_TOTAL_EVER_OFFLINE+ ORDER_NUM_TOTAL_EVER_ONLINE) ORTALAMA_CIRO
FROM FLO_CUSTOMERS
GROUP BY LAST_ORDER_CHANNEL
ORDER BY ORTALAMA_CIRO DESC
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 9. Son 12 ayda en çok ilgi gören kategoriyi getiren sorguyu yazınız.
SELECT 
    'KADIN'      AS KATEGORI, COUNT(*) AS MUSTERI_SAYISI FROM FLO_CUSTOMERS WHERE INTERESTED_IN_CATEGORIES_12 LIKE '%KADIN%'
UNION ALL
SELECT 
    'ERKEK'      AS KATEGORI, COUNT(*) FROM FLO_CUSTOMERS WHERE INTERESTED_IN_CATEGORIES_12 LIKE '%ERKEK%'
UNION ALL
SELECT 
    'COCUK'      AS KATEGORI, COUNT(*) FROM FLO_CUSTOMERS WHERE INTERESTED_IN_CATEGORIES_12 LIKE '%COCUK%'
UNION ALL
SELECT 
    'AKTIFSPOR'  AS KATEGORI, COUNT(*) FROM FLO_CUSTOMERS WHERE INTERESTED_IN_CATEGORIES_12 LIKE '%AKTIFSPOR%'
UNION ALL
SELECT 
    'AKTIFCOCUK' AS KATEGORI, COUNT(*) FROM FLO_CUSTOMERS WHERE INTERESTED_IN_CATEGORIES_12 LIKE '%AKTIFCOCUK%'
ORDER BY MUSTERI_SAYISI DESC;
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 10. En çok tercih edilen store_type bilgisini getiren sorguyu yazınız.

SELECT
    STORE_TYPE,
    COUNT(*) AS MUSTERI_SAYISI
FROM FLO_CUSTOMERS
GROUP BY STORE_TYPE
ORDER BY MUSTERI_SAYISI DESC;

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 11. En son alışveriş yapılan kanal (last_order_channel) bazında, en çok ilgi gören kategoriyi ve bu kategoriden ne kadarlık
--alışveriş yapıldığını getiren sorguyu yazınız.

SELECT
LAST_ORDER_CHANNEL, SUM(CUSTOMER_VALUE_TOTAL_EVER_OFFLINE + CUSTOMER_VALUE_TOTAL_EVER_ONLINE) TOPLAM_ALIVERIS_TUTARI,
COUNT(INTERESTED_IN_CATEGORIES_12) AS MUSTER_SAYISI
FROM FLO_CUSTOMERS
GROUP BY LAST_ORDER_CHANNEL
ORDER BY TOPLAM_ALIVERIS_TUTARI DESC

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 12. En çok alışveriş yapan kişinin ID’ sini getiren sorguyu yazınız.
SELECT TOP 1
MASTER_ID,
MAX(CUSTOMER_VALUE_TOTAL_EVER_OFFLINE + CUSTOMER_VALUE_TOTAL_EVER_ONLINE) AS TOPLAM_ALISVERIS_TUTARI

FROM FLO_CUSTOMERS
GROUP BY MASTER_ID
ORDER BY TOPLAM_ALISVERIS_TUTARI DESC

--------------------------------------------------------------------------------------------------------------------------------------------------
-- 13. En çok alışveriş yapan kişinin alışveriş başına ortalama cirosunu ve alışveriş yapma gün ortalamasını (alışveriş sıklığını)
--getiren sorguyu yazınız.
SELECT
    MASTER_ID,
    ORDER_NUM_TOTAL_EVER_ONLINE + ORDER_NUM_TOTAL_EVER_OFFLINE AS TOPLAM_SIPARIS,

    (CUSTOMER_VALUE_TOTAL_EVER_ONLINE + CUSTOMER_VALUE_TOTAL_EVER_OFFLINE) 
    / (ORDER_NUM_TOTAL_EVER_ONLINE + ORDER_NUM_TOTAL_EVER_OFFLINE) AS ALISVERIS_BASI_ORTALAMA_CIRO,

    DATEDIFF(DAY, FIRST_ORDER_DATE, LAST_ORDER_DATE) 
    / (ORDER_NUM_TOTAL_EVER_ONLINE + ORDER_NUM_TOTAL_EVER_OFFLINE) AS ALISVERIS_SIKLIGI_GUN
FROM FLO_CUSTOMERS
WHERE MASTER_ID = '5d1c466a-9cfd-11e9-9897-000d3a38a36f'
ORDER BY TOPLAM_SIPARIS DESC;

------------------------------

SELECT
    MASTER_ID,
    ORDER_NUM_TOTAL_EVER_ONLINE + ORDER_NUM_TOTAL_EVER_OFFLINE AS TOPLAM_SIPARIS,
    (CUSTOMER_VALUE_TOTAL_EVER_ONLINE + CUSTOMER_VALUE_TOTAL_EVER_OFFLINE)
    / (ORDER_NUM_TOTAL_EVER_ONLINE + ORDER_NUM_TOTAL_EVER_OFFLINE) AS ALISVERIS_BASI_ORTALAMA_CIRO,
    DATEDIFF(DAY, FIRST_ORDER_DATE, LAST_ORDER_DATE)
    / (ORDER_NUM_TOTAL_EVER_ONLINE + ORDER_NUM_TOTAL_EVER_OFFLINE) AS ALISVERIS_SIKLIGI_GUN
FROM FLO_CUSTOMERS
WHERE MASTER_ID = (
    SELECT TOP 1 MASTER_ID
    FROM FLO_CUSTOMERS
    ORDER BY (ORDER_NUM_TOTAL_EVER_ONLINE + ORDER_NUM_TOTAL_EVER_OFFLINE) DESC
);



--------------------------------------------------------------------------------------------------------------------------------------------------
-- 14. En çok alışveriş yapan (ciro bazında) ilk 100 kişinin alışveriş yapma gün ortalamasını (alışveriş sıklığını) getiren sorguyu
--yazınız.

SELECT TOP 100
    MASTER_ID,
    CUSTOMER_VALUE_TOTAL_EVER_ONLINE + CUSTOMER_VALUE_TOTAL_EVER_OFFLINE AS TOPLAM_CIRO,
    ORDER_NUM_TOTAL_EVER_ONLINE + ORDER_NUM_TOTAL_EVER_OFFLINE AS TOPLAM_SIPARIS,
    DATEDIFF(DAY, FIRST_ORDER_DATE, LAST_ORDER_DATE)
    / (ORDER_NUM_TOTAL_EVER_ONLINE + ORDER_NUM_TOTAL_EVER_OFFLINE) AS ALISVERIS_SIKLIGI_GUN
FROM FLO_CUSTOMERS
ORDER BY TOPLAM_CIRO DESC;
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 15. En son alışveriş yapılan kanal (last_order_channel) kırılımında en çok alışveriş yapan müşteriyi getiren sorguyu yazınız.

SELECT
    LAST_ORDER_CHANNEL,
    MASTER_ID,
    TOPLAM_SIPARIS
FROM (
    SELECT
        LAST_ORDER_CHANNEL,
        MASTER_ID,
        ORDER_NUM_TOTAL_EVER_ONLINE + ORDER_NUM_TOTAL_EVER_OFFLINE AS TOPLAM_SIPARIS,
        ROW_NUMBER() OVER (PARTITION BY LAST_ORDER_CHANNEL 
                           ORDER BY ORDER_NUM_TOTAL_EVER_ONLINE + ORDER_NUM_TOTAL_EVER_OFFLINE DESC) AS SIRA
    FROM FLO_CUSTOMERS
) AS ALT_SORGU
WHERE SIRA = 1
ORDER BY TOPLAM_SIPARIS DESC;



--------------------------------------------------------------------------------------------------------------------------------------------------
-- 16. En son alışveriş yapan kişinin ID’ sini getiren sorguyu yazınız. (Max son tarihte birden fazla alışveriş yapan ID bulunmakta.
--Bunları da getiriniz.)
SELECT
    MASTER_ID,
    LAST_ORDER_DATE
FROM FLO_CUSTOMERS
WHERE LAST_ORDER_DATE = (
    SELECT MAX(LAST_ORDER_DATE)
    FROM FLO_CUSTOMERS
);