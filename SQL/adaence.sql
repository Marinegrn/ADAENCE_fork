-- postGreSQL

-- Création de toutes les tables
CREATE TABLE "elders" (
    "id" serial NOT NULL PRIMARY KEY,
    "firstname" TEXT NOT NULL,
    "age" INT,
    "job" TEXT NOT NULL,
    "activity_id" INT, -- Nouvelle colonne pour la clé étrangère
    "city_id" INT, -- Nouvelle colonne pour la clé étrangère
    "created_at" timestamp NOT NULL DEFAULT(now()),
    "updated_at" timestamp NOT NULL 
);

CREATE TABLE "users" (
    "id" serial NOT NULL PRIMARY KEY,
    "firstname" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "availability" date,
    "created_at" timestamp NOT NULL DEFAULT(now()),
    "updated_at" timestamp NOT NULL 
);

CREATE TABLE "activities" (
    "id" serial NOT NULL PRIMARY KEY,
    "activity" TEXT NOT NULL,
    "created_at" timestamp NOT NULL DEFAULT(now()),
    "updated_at" timestamp NOT NULL 
);

CREATE TABLE "cities" (
    "id" serial NOT NULL PRIMARY KEY,
    "city" TEXT NOT NULL,
    "zipcode" INT,
    "created_at" timestamp NOT NULL DEFAULT(now()),
    "updated_at" timestamp NOT NULL 
);

CREATE TABLE "users_elders_connection" (
    "id" serial NOT NULL PRIMARY KEY,
    "users_id" INT,
    "elders_id" INT,
    "created_at" timestamp NOT NULL DEFAULT(now()),
    "updated_at" timestamp NOT NULL 
);

-- Table elders, insertion des données
INSERT INTO elders (id, firstname, age, job, activity_id, city_id, created_at, updated_at)
VALUES
    (1, 'Franco', 95, "Ouvrier d'usine", NULL, NULL, NOW(), NULL),
    (2, 'Soares', 84, 'Puéricultrice', NULL, NULL, NOW(), NULL),
    (3, 'Tim', 80, 'Facteur', NULL, NULL, NOW(), NULL),
    (4, 'Shimo', 94, 'Professeure', NULL, NULL, NOW(), NULL),
    (5, 'Zanon', 86, 'Journaliste', NULL, NULL, NOW(), NULL),
    (6, 'Matveev', 77, "Pilote d'avion", NULL, NULL, NOW(), NULL),
    (7, 'Mahe', 93, 'Mécanicienne', NULL, NULL, NOW(), NULL),
    (8, 'Samir', 82, 'Musicien', NULL, NULL, NOW(), NULL);

-- Table users, insertion de nouvelles données fictives, inspirées des sections de la page d'inscription
INSERT INTO users (id, firstname, name, email, availability, created_at, updated_at)
VALUES
    (1, 'Eline', 'Ndoye', 'ndoyeline@email.com', '2025-09-06', NOW(), NULL),
    (2, 'Lucas', 'Lefebvre', 'lucas.lefebvre@email.com', '2025-03-01', NOW(), NULL),
    (3, 'Chloé', 'Hoarau', 'hoarauc@testmail.com', '2025-04-15', NOW(), NULL),
    (4, 'Raphaël', 'Garin', 'raph_grn@email.com', '2025-08-24', NOW(), NULL),
    (5, 'Léana', 'Petit', 'petiteleana@gmail.com', '2025-02-08', NOW(), NULL),
    (6, 'Hugo', 'Lambert', 'hugo.lambert@email.com', '2025-05-09', NOW(), NULL),
    (7, 'Jade', 'Delbois', 'delbois_jade@gmail.com', '2025-04-03', NOW(), NULL),
    (8, 'Louis', 'Fontaine', 'louisfontaine@email.com', '2025-07-14', NOW(), NULL),
    (9, 'Irène', 'Zéta-Philippe', 'zetaIrene_972@emmail.com', '2025-03-01', NOW(), NULL),
    (10, 'Tom', 'Faure', 'tommy16@email.com', '2025-12-23', NOW(), NULL),
    (11, 'Camille', 'André', 'camandr@email.com', '2025-10-10', NOW(), NULL),
    (12, 'Arthur', 'Nguyen', 'nguyen261@email.com', '2025-05-08', NOW(), NULL),
    (13, 'Manon', 'Razafy', 'razafyleky@email.com', '2025-09-14', NOW(), NULL),
    (14, 'Enzo', 'Generès', 'enzo976_gen@email.com', '2025-11-18', NOW(), NULL);

-- Insérer les données d'activités
INSERT INTO activities (id, activity, created_at, updated_at)
VALUES
    (1, 'Un café/thé', NOW(), NULL),
    (2, 'Un repas', NOW(), NULL),
    (3, 'Conversation', NOW(), NULL),
    (4, 'Promenade', NOW(), NULL),
    (5, 'Une sortie culturelle', NOW(), NULL),
    (5, 'Jeux de société', NOW(), NULL),
    (6, 'Autre activité', NOW(), NULL);
    
-- Insérer les données de villes
INSERT INTO cities (id, city, zipcode, created_at, updated_at)
VALUES
    (1, 'Aurillac', 15000, NOW(), NULL),
    (2, 'Besançon', 25000, NOW(), NULL),
    (3, 'Toulouse', 31000, NOW(), NULL),
    (4, 'Saint-Etienne', 42000, NOW(), NULL),
    (5, 'Angers', 49000, NOW(), NULL),
    (6, 'Lyon', 69007, NOW(), NULL),
    (7, 'Le Mans', 72000, NOW(), NULL),
    (8, 'Paris', 75011, NOW(), NULL);

-- Insérer les données de users_elders_connection
INSERT INTO users_elders_connection (id, users_id, elders_id, created_at, updated_at)
VALUES
    (1, 1, 3, NOW(), NULL),
    (2, 9, 5, NOW(), NULL),
    (3, 2, 1, NOW(), NULL),
    (4, 4, 7, NOW(), NULL),
    (5, 11, 8 , NOW(), NULL),
    (6, 13, 5, NOW(), NULL);

-- Ajout Foreign Key
ALTER TABLE "elders"
ADD CONSTRAINT "fk_activity"
FOREIGN KEY ("activity_id") REFERENCES "activities"("id");

ALTER TABLE "elders"
ADD CONSTRAINT "fk_city"
FOREIGN KEY ("city_id") REFERENCES "cities"("id");

ALTER TABLE "users_elders_connection"
ADD CONSTRAINT "fk_users"
FOREIGN KEY ("users_id") REFERENCES "users"("id");

ALTER TABLE "users_elders_connection"
ADD CONSTRAINT "fk_elders"
FOREIGN KEY ("elders_id") REFERENCES "elders"("id");

-- Ajouter nouveaux aîné.e.s à la table elders
INSERT INTO elders (id, firstname, age, job, activity_id, city_id, created_at, updated_at)
VALUES
    (9, 'Marius', 88, 'Infirmier', 3, 2, NOW(), NULL),
    (10, 'Jeanne', 90, 'Agricultrice', 4, 5, NOW(), NULL),
    (11, 'Lucienne', 85, 'Commerçante', 1, 8, NOW(), NULL),
    (12, 'Paul', 92, 'Botaniste', 2, 6, NOW(), NULL);

-- Ajouter nouvelles villes en territoires ultramarins à la table cities
INSERT INTO cities (id, city, zipcode, created_at, updated_at)
VALUES
    (9, 'Fort-de-France', 97200, NOW(), NULL),
    (10, 'Saint-Denis', 97400, NOW(), NULL),
    (11, 'Cayenne', 97300, NOW(), NULL),
    (12, 'Punaauia', 98714, NOW(), NULL),
    (13, 'Mamoudzou', 97600, NOW(), NULL),
    (14, 'Les Abymes', 97100, NOW(), NULL);

-- BONUS: Exemple de requête avec JOIN pour afficher les aîné.e.s avec leur activité et leur ville
SELECT 
    elders.firstname AS elder_name,
    elders.age,
    elders.job,
    activities.activity AS activity_name,
    cities.city AS city_name
FROM 
    elders
LEFT JOIN activities ON elders.activity_id = activities.id
LEFT JOIN cities ON elders.city_id = cities.id;

-- BONUS: requête avec JOIN pour afficher les connexions entre utilisateur.ice.s et aîné.e.s
SELECT 
    users.firstname AS user_name,
    users.email,
    elders.firstname AS elder_name,
    elders.job
FROM 
    users_elders_connection
INNER JOIN users ON users_elders_connection.users_id = users.id
INNER JOIN elders ON users_elders_connection.elders_id = elders.id;

-- BONUS: requête pour compter le nombre d'aîné.e.s par ville
SELECT 
    cities.city AS city_name,
    COUNT(elders.id) AS elder_count
FROM 
    cities
LEFT JOIN elders ON cities.id = elders.city_id
GROUP BY cities.city
ORDER BY elder_count DESC;

-- BONUS: Requête pour afficher les utilisateurs avec le nombre d'aîné.e.s qu'ils accompagnent
SELECT 
    users.firstname AS user_name,
    users.email,
    COUNT(users_elders_connection.elders_id) AS elder_count
FROM 
    users
LEFT JOIN users_elders_connection ON users.id = users_elders_connection.users_id
GROUP BY users.id
ORDER BY elder_count DESC;

-- BONUS: Requête pour afficher les activités les plus populaires parmi les aîné.e.s
SELECT 
    activities.activity AS activity_name,
    COUNT(elders.id) AS elder_count
FROM 
    activities
LEFT JOIN elders ON activities.id = elders.activity_id
GROUP BY activities.activity
ORDER BY elder_count DESC;

-- BONUS: Requête pour afficher les aîné.e.s qui n'ont pas encore d'utilisateur.ice assigné.e
SELECT 
    elders.firstname AS elder_name,
    elders.age,
    elders.job,
    cities.city AS city_name
FROM 
    elders
LEFT JOIN users_elders_connection ON elders.id = users_elders_connection.elders_id
LEFT JOIN cities ON elders.city_id = cities.id
WHERE 
    users_elders_connection.users_id IS NULL;

-- BONUS: Requête pour afficher les utilisateurs disponibles après une certaine date
SELECT 
    users.firstname AS user_name,
    users.email,
    users.availability
FROM 
    users
WHERE 
    users.availability > '2025-06-01'
ORDER BY users.availability ASC;

-- wip MAJ table Elders avec les nouvelles valeurs de cities (territoires ultramarins)
