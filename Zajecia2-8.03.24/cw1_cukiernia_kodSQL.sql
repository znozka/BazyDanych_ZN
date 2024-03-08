-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-03-08 15:30:19.384

-- tables
-- Table: Artykuly
CREATE TABLE Artykuly (
    IDPudelka char(4)  NOT NULL,
    IDZamowienia int  NOT NULL,
    Sztuk int  NOT NULL,
    CONSTRAINT Artykuly_pk PRIMARY KEY (IDPudelka)
);

-- Table: Czekoladki
CREATE TABLE Czekoladki (
    IDCzekoladki char(3)  NOT NULL,
    Nazwa varchar()  NOT NULL,
    RodzajCzekolady varchar()  NOT NULL,
    RodzajOrzechow varchar()  NOT NULL,
    RodzajNadzienia varchar()  NOT NULL,
    Opis varchar()  NOT NULL,
    Koszt money  NOT NULL,
    Masa int  NOT NULL,
    CONSTRAINT Czekoladki_pk PRIMARY KEY (IDCzekoladki)
);

-- Table: Klienci
CREATE TABLE Klienci (
    IDKlienta int  NOT NULL,
    Nazwa varchar()  NOT NULL,
    Ulica varchar()  NOT NULL,
    Miejscowosc varchar()  NOT NULL,
    Kod varchar()  NOT NULL,
    Telefon varchar()  NOT NULL,
    CONSTRAINT Klienci_pk PRIMARY KEY (IDKlienta)
);

-- Table: Pudelka
CREATE TABLE Pudelka (
    IDPudelka char(4)  NOT NULL,
    Nazwa varchar()  NOT NULL,
    Opis varchar()  NOT NULL,
    Cena money  NOT NULL,
    Stan int  NOT NULL,
    CONSTRAINT Pudelka_pk PRIMARY KEY (IDPudelka)
);

-- Table: Zamowienia
CREATE TABLE Zamowienia (
    IDZamowienia int  NOT NULL,
    IDKlienta int  NOT NULL,
    DataRealizacji date  NOT NULL,
    CONSTRAINT Zamowienia_pk PRIMARY KEY (IDZamowienia)
);

-- Table: Zawartosc
CREATE TABLE Zawartosc (
    IDPudelka char(4)  NOT NULL,
    IDCzekoladki char(3)  NOT NULL,
    Sztuk int  NOT NULL,
    CONSTRAINT Zawartosc_pk PRIMARY KEY (IDCzekoladki,IDPudelka)
);

-- foreign keys
-- Reference: Artykuly_Pudelka (table: Artykuly)
ALTER TABLE Artykuly ADD CONSTRAINT Artykuly_Pudelka
    FOREIGN KEY (IDPudelka)
    REFERENCES Pudelka (IDPudelka)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Artykuly_Zamowienia (table: Artykuly)
ALTER TABLE Artykuly ADD CONSTRAINT Artykuly_Zamowienia
    FOREIGN KEY (IDZamowienia)
    REFERENCES Zamowienia (IDZamowienia)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Zamowienia_Klienci (table: Zamowienia)
ALTER TABLE Zamowienia ADD CONSTRAINT Zamowienia_Klienci
    FOREIGN KEY (IDKlienta)
    REFERENCES Klienci (IDKlienta)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Zawartosc_Czekoladki (table: Zawartosc)
ALTER TABLE Zawartosc ADD CONSTRAINT Zawartosc_Czekoladki
    FOREIGN KEY (IDCzekoladki)
    REFERENCES Czekoladki (IDCzekoladki)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Zawartosc_Pudelka (table: Zawartosc)
ALTER TABLE Zawartosc ADD CONSTRAINT Zawartosc_Pudelka
    FOREIGN KEY (IDPudelka)
    REFERENCES Pudelka (IDPudelka)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

