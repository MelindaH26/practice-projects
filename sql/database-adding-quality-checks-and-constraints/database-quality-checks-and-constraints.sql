-- Set constraints for parts.code
ALTER TABLE parts
ALTER COLUMN code
SET NOT NULL;

ALTER TABLE parts
ADD UNIQUE(code);

-- Backfill parts.description
UPDATE parts
SET description = 'None Available'
WHERE description IS NULL;

-- Set parts.description to always take a value
ALTER TABLE parts
ALTER COLUMN description
SET NOT NULL;

-- Set reorder_options.price_usd and reorder_options.quantity to NOT NULL
ALTER TABLE reorder_options
ALTER COLUMN price_usd
SET NOT NULL;

ALTER TABLE reorder_options
ALTER COLUMN quantity
SET NOT NULL;

-- Add constraints to reorder_options
ALTER TABLE reorder_options
ADD CHECK(price_usd > 0 AND quantity > 0);

-- Set custom price limits per unit
-- Per unit price is price_usd/quantity
ALTER TABLE reorder_options
ADD CHECK(price_usd/quantity > 0.02 AND price_usd/quantity < 25.00);

-- ADD PRIMARY KEY to parts
ALTER TABLE parts
ADD PRIMARY KEY(id);

-- ADD FOREIGN KEY for reorder_options
ALTER TABLE reorder_options
ADD FOREIGN KEY(part_id) REFERENCES parts(id);

-- Add constraint to locations.qty
ALTER TABLE locations
ADD CHECK(qty > 0);

-- ADD composite key got locations to avoid duplicate listings of the same part in a single location
ALTER TABLE locations
ADD UNIQUE(part_id, location);

-- Set FOREIGN KEY in locations
ALTER TABLE locations
ADD FOREIGN KEY(part_id) REFERENCES parts(id);

-- Set FOREIGN KEY so parts.manufacturers matches a manufacturers id
ALTER TABLE parts
ADD FOREIGN KEY(manufacturer_id) REFERENCES manufacturers(id);

-- Add new record to manufacturers as two companies "Pip Industrial" (id = 1) and "NNC Manufacturing" (id=2) have merged into "Pip-NNC Industrial"
INSERT INTO manufacturers
VALUES (11,
  'Pip-NNC Industrial'
);

-- Update the old manufacturers’ parts in 'parts' to reference "Pip-NNC Industrial"
UPDATE parts
SET manufacturer_id = 11
WHERE manufacturer_id = 1 OR manufacturer_id = 2;