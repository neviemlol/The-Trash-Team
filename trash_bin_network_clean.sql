PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "bins" (
	"bin_id"	INTEGER NOT NULL,
	"location_name"	TEXT NOT NULL,
	"latitude"	REAL NOT NULL,
	"longitude"	REAL NOT NULL,
	"capacity"	INTEGER NOT NULL,
	"status"	TEXT NOT NULL DEFAULT 'active',
	PRIMARY KEY("bin_id")
);
CREATE TABLE measurements (
    measurement_id INTEGER PRIMARY KEY,
    bin_id         INTEGER NOT NULL,
    fill_level     REAL NOT NULL CHECK (fill_level BETWEEN 0 AND 100),
    measured_at    TEXT NOT NULL,
    FOREIGN KEY (bin_id) REFERENCES bins (bin_id)
);
CREATE TABLE collections (
    collection_id INTEGER PRIMARY KEY,
    bin_id INTEGER NOT NULL,
    collected_at TEXT NOT NULL,
    fill_before REAL CHECK (fill_before BETWEEN 0 AND 100),
    fill_after REAL NOT NULL CHECK (fill_after BETWEEN 0 AND 100),
    FOREIGN KEY (bin_id) REFERENCES bins (bin_id)
);
COMMIT;
