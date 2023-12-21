CREATE TABLE postac (
	id_postaci INT AUTO_INCREMENT PRIMARY KEY, nazwa VARCHAR(40), rodzaj ENUM('wiking', 'ptak', 'kobieta'), data_ur DATE, wiek INT UNSIGNED);
INSERT INTO postac (nazwa, rodzaj, data_ur, wiek) VALUES ('Bjorn', 'wiking', '925-05-15', 33), ('Drozd', 'ptak', '958-01-02', 0), ('Teściowa', 'kobieta', '890-05-11', 68);
UPDATE postac SET wiek = 88 WHERE nazwa = 'Teściowa';

CREATE TABLE walizka (
	id_walizki INT AUTO_INCREMENT PRIMARY KEY, pojemnosc INT UNSIGNED, kolor ENUM('różowy', 'czerwony', 'tęczowy', 'żółty'), id_wlasciciela INT REFERENCES postac(id_postaci) ON DELETE CASCADE);
ALTER TABLE walizka
ALTER COLUMN kolor SET DEFAULT 'różowy';

INSERT INTO walizka (pojemnosc, kolor, id_wlasciciela) 
VALUES 
    (50, 'czerwony', (SELECT id_postaci FROM postac WHERE nazwa = 'Bjorn')),
    (90, 'różowy', (SELECT id_postaci FROM postac WHERE nazwa = 'Teściowa'));
    
CREATE TABLE izba (
    adres_budynku VARCHAR(100),
    nazwa_izby VARCHAR(50),
    metraz DECIMAL(10, 2) UNSIGNED,
    wlasciciel INT,
    PRIMARY KEY (adres_budynku, nazwa_izby),
    FOREIGN KEY (wlasciciel) REFERENCES postac(id_postaci) ON DELETE SET NULL);
    
ALTER TABLE izba
ADD COLUMN kolor VARCHAR(20) DEFAULT 'czarny' AFTER metraz;

INSERT INTO izba (adres_budynku, nazwa_izby, metraz, kolor, wlasciciel)
VALUES ('adres_budynku_value', 'spiżarnia', 20.5, 'czarny', 1);

CREATE TABLE przetwory (
    id_przetworu INT AUTO_INCREMENT PRIMARY KEY,
    rok_produkcji YEAR,
    id_wykonawcy INT,
    zawartosc VARCHAR(255),
    dodatek VARCHAR(255) DEFAULT 'papryczka chilli',
    id_konsumenta INT,
    FOREIGN KEY (id_wykonawcy) REFERENCES postac(id_postaci),
    FOREIGN KEY (id_konsumenta) REFERENCES postac(id_postaci));
    
INSERT INTO przetwory (rok_produkcji, id_wykonawcy, zawartosc, dodatek, id_konsumenta)
VALUES ('2023', 1, 'bigos', 'papryczka chilli', 3);

INSERT INTO postac (nazwa, rodzaj, data_ur, wiek) VALUES
	('Korn', 'wiking' ,'930-01-01', 28),
	('Born', 'wiking' ,'930-01-01', 28),
	('Vorn', 'wiking' ,'930-01-01', 28),
	('Porn', 'wiking' ,'930-01-01', 28),
	('Dorn', 'wiking' ,'930-01-01', 28);
    
CREATE TABLE statek (
	nazwa_statku VARCHAR(255) PRIMARY KEY,
    rodzaj_statku ENUM('zajebisty', 'niezajebisty'),
    data_wodowania DATE,
    max_ladownosc INT UNSIGNED);
    
INSERT INTO statek (nazwa_statku, rodzaj_statku, data_wodowania, max_ladownosc) VALUES
	('Śledż', 'zajebisty', '920-01-1', '500'),
	('Karaś', 'niezajebisty', '921-01-01', '240');

ALTER TABLE postac
ADD COLUMN funkcja VARCHAR(255);
    
UPDATE postac SET funkcja = 'kapitan' WHERE nazwa = 'Bjorn';
    
ALTER TABLE postac
ADD COLUMN statek varchar(255),
ADD FOREIGN KEY (statek) REFERENCES statek(nazwa_statku);

UPDATE postac SET statek = 'Śledż' WHERE rodzaj = 'wiking';

DELETE from izba where nazwa_izby = 'spiżarnia';

DROP table izba;


### PDF 5

#1
DELETE from postac WHERE wiek IN (select wiek from tabela order by wiek desc limit 2);
### usuwanie klucza głównego - brak

#2
ALTER TABLE postac
ADD COLUMN pesel INT(11),
ADD PRIMARY KEY (pesel);

ALTER TABLE postac MODIFY COLUMN rodzaj ENUM('wiking', 'ptak', 'kobieta', 'syrena');
INSERT INTO postac (nazwa, rodzaj, data_ur, wiek) VALUES
	('Gertruda Nieszczera', 'syrena', '930-01-01', 28);
































#5
#select datediff(now(), '2023-12-01');
#select datediff('2023-12-01', now());












#select count(*) from kreatura;
#select count(distinct id_uczestnika) from uczestnicy;
