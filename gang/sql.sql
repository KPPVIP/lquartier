
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_gagarine', 'gagarine', 1),
('society_gagarine_black', 'gagarine black', 1),
('society_quartiersnord', 'gagarine', 1),
('society_quartiersnord_black', 'gagarine black', 1),
('society_castellane', 'castellane', 1),
('society_castellane_black', 'castellane black', 1),
('society_tarterets', 'tarterets', 1),
('society_tarterets_black', 'tarterets black', 1);

INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
('society_gagarine', 0, NULL),
('society_gagarine_black', 0, NULL),
('society_quartiersnord', 0, NULL),
('society_quartiersnord_black', 0, NULL),
('society_castellane', 0, NULL),
('society_castellane_black', 0, NULL),
('society_tarterets', 0, NULL),
('society_tarterets_black', 0, NULL);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_gagarine', 'gagarine', 1),
('society_quartiersnord', 'quartiernord', 1),
('society_castellane', 'castellane', 1),
('society_tarterets', 'tarterets', 1);

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('society_gagarine', 'gagarine', 1),
('society_quartiersnord', 'quartiernord', 1),
('society_castellane', 'castellane', 1),
('society_tarterets', 'tarterets', 1);


INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
('society_gagarine', NULL, '{}'),
('society_quartiersnord', NULL, '{}'),
('society_castellane', NULL, '{}'),
('society_tarterets', NULL, '{}');


INSERT INTO `jobs` (`name`, `label`, `SecondaryJob`) VALUES 
('gagarine', 'Gagarine', 1),
('quartiernord', 'Quartiers nord', 1),
('castellane', 'Castellane', 1),
('tarterets', 'Tarterets', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('gagarine', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('gagarine', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('gagarine', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('gagarine', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null'),
('quartiersnord', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('quartiersnord', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('quartiersnord', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('quartiersnord', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null'),
('castellane', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('castellane', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('castellane', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('castellane', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null'),
('tarterets', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('tarterets', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('tarterets', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('tarterets', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null');

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_zup', 'zup', 1),
('society_zup_black', 'zup black', 1);

INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
('society_zup', 0, NULL),
('society_zup_black', 0, NULL);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_zup', 'zup', 1);

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('society_zup', 'zup', 1);


INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
('society_zup', NULL, '{}');


INSERT INTO `jobs` (`name`, `label`, `SecondaryJob`) VALUES 
('zup', 'La Zup', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('zup', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('zup', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('zup', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('zup', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null');


INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_zac', 'zac', 1),
('society_zac_black', 'zac black', 1);

INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
('society_zac', 0, NULL),
('society_zac_black', 0, NULL);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_zac', 'zac', 1);

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('society_zac', 'zac', 1);


INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
('society_zac', NULL, '{}');


INSERT INTO `jobs` (`name`, `label`, `SecondaryJob`) VALUES 
('zac', 'La Zac', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('zac', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('zac', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('zac', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('zac', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null');



INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_sevran', 'sevran', 1),
('society_sevran_black', 'sevran black', 1);

INSERT INTO `addon_account_data` (`account_name`, `money`, `owner`) VALUES
('society_sevran', 0, NULL),
('society_sevran_black', 0, NULL);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('society_sevran', 'sevran', 1);

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('society_sevran', 'sevran', 1);


INSERT INTO `datastore_data` (`name`, `owner`, `data`) VALUES
('society_sevran', NULL, '{}');


INSERT INTO `jobs` (`name`, `label`, `SecondaryJob`) VALUES 
('sevran', 'La sevran', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('sevran', 0, 'soldato', 'Dealer', 200, 'null', 'null'),
('sevran', 1, 'capo', 'Braqueur', 400, 'null', 'null'),
('sevran', 2, 'consigliere', 'Bandit', 600, 'null', 'null'),
('sevran', 3, 'boss', 'Chef du Gang', 1000, 'null', 'null');

