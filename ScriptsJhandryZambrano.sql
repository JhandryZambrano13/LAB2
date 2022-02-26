--
-- File generated with SQLiteStudio v3.3.3 on vie. feb. 25 17:12:16 2022
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: dim_albums
CREATE TABLE dim_albums (
    AlbumId INTEGER        PRIMARY KEY AUTOINCREMENT
                           NOT NULL,
    Title   NVARCHAR (160) NOT NULL
);


-- Table: dim_artists
CREATE TABLE dim_artists (
    ArtistId INTEGER        PRIMARY KEY AUTOINCREMENT
                            NOT NULL,
    Name     NVARCHAR (120) 
);


-- Table: dim_customers
CREATE TABLE dim_customers (
    CustomerId   INTEGER       PRIMARY KEY AUTOINCREMENT
                               NOT NULL,
    FirstName    NVARCHAR (40) NOT NULL,
    LastName     NVARCHAR (20) NOT NULL,
    Company      NVARCHAR (80),
    Address      NVARCHAR (70),
    City         NVARCHAR (40),
    State        NVARCHAR (40),
    Country      NVARCHAR (40),
    PostalCode   NVARCHAR (10),
    Phone        NVARCHAR (24),
    Fax          NVARCHAR (24),
    Email        NVARCHAR (60) NOT NULL,
    SupportRepId INTEGER       NOT NULL
                               REFERENCES dim_employees (EmployeeId) 
);


-- Table: dim_employees
CREATE TABLE dim_employees (
    EmployeeId INTEGER       PRIMARY KEY AUTOINCREMENT
                             NOT NULL,
    LastName   NVARCHAR (20) NOT NULL,
    FirstName  NVARCHAR (20) NOT NULL,
    Title      NVARCHAR (30),
    ReportsTo  INTEGER       REFERENCES dim_employees (EmployeeId),
    BirthDate  DATETIME,
    HireDate   DATETIME,
    Address    NVARCHAR (70),
    City       NVARCHAR (40),
    State      NVARCHAR (40),
    Country    NVARCHAR (40),
    PostalCode NVARCHAR (10),
    Phone      NVARCHAR (24),
    Fax        NVARCHAR (24),
    Email      NVARCHAR (60) 
);


-- Table: dim_genres
CREATE TABLE dim_genres (
    GenreId INTEGER        PRIMARY KEY AUTOINCREMENT
                           NOT NULL,
    Name    NVARCHAR (120) 
);


-- Table: dim_invoice
CREATE TABLE dim_invoice (
    InvoiceID INTEGER         PRIMARY KEY AUTOINCREMENT,
    Total     NUMERIC (10, 2) NOT NULL
);


-- Table: dim_location
CREATE TABLE dim_location (
    LocationID        INTEGER      PRIMARY KEY AUTOINCREMENT
                                   NOT NULL,
    BillingAddress    VARCHAR (70),
    BillingCity       VARCHAR (40),
    BillingState      VARCHAR (40),
    BillingCountry    VARCHAR (40),
    BillingPostalCode VARCHAR (10) 
);


-- Table: dim_media_types
CREATE TABLE dim_media_types (
    MediaTypeId INTEGER        PRIMARY KEY AUTOINCREMENT
                               NOT NULL,
    Name        NVARCHAR (120) 
);


-- Table: dim_playlists
CREATE TABLE dim_playlists (
    PlaylistId INTEGER        PRIMARY KEY AUTOINCREMENT
                              NOT NULL,
    Name       NVARCHAR (120) 
);


-- Table: dim_time
CREATE TABLE dim_time (
    TimeID      INTEGER  PRIMARY KEY AUTOINCREMENT
                         NOT NULL,
    InvoiceDate DATETIME NOT NULL
);


-- Table: dim_tracks
CREATE TABLE dim_tracks (
    TrackId      INTEGER         PRIMARY KEY AUTOINCREMENT
                                 NOT NULL,
    Name         NVARCHAR (200)  NOT NULL,
    MediaTypeId  INTEGER         NOT NULL
                                 REFERENCES dim_media_types (MediaTypeId),
    GenreId      INTEGER         REFERENCES dim_genres (GenreId),
    Composer     NVARCHAR (220),
    Milliseconds INTEGER         NOT NULL,
    Bytes        INTEGER,
    UnitPrice    NUMERIC (10, 2) NOT NULL
);


-- Table: Fact_invoice_item
CREATE TABLE Fact_invoice_item (
    Id         INTEGER PRIMARY KEY AUTOINCREMENT
                       NOT NULL,
    InvoiceID  INTEGER REFERENCES dim_invoice (InvoiceID) 
                       NOT NULL,
    CustomerID INTEGER NOT NULL
                       REFERENCES dim_customers (CustomerId),
    TimeID     INT     REFERENCES dim_time (TimeID) 
                       NOT NULL,
    LocationID INTEGER REFERENCES dim_location (LocationID) 
                       NOT NULL,
    PlaylistID INTEGER REFERENCES dim_playlists (PlaylistId) 
                       NOT NULL,
    ArtistID   INTEGER REFERENCES dim_artists (ArtistId) 
                       NOT NULL,
    AlbumID    INTEGER REFERENCES dim_albums (AlbumId) 
                       NOT NULL,
    Quantity   INTEGER NOT NULL
);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
