
-- CREATE TABLE AVEC CONTRAINTES
CREATE TABLE ACTIVITES
(
    id_activite SERIAL NOT NULL PRIMARY KEY,
    activite_nom CHARACTER VARYING(50) NULL
);

CREATE TABLE COMPETENCES
(
    id_competence SERIAL NOT NULL PRIMARY KEY,
    nom_competence CHARACTER VARYING(250) NULL
);

CREATE TABLE CONTACT
(
    id_contact SERIAL NOT NULL PRIMARY KEY,
    contact_nom CHARACTER VARYING(50) NULL,
    contact_prenom CHARACTER VARYING(50) NULL,
    contact_telephone CHARACTER VARYING(50) NULL,
    contact_email CHARACTER VARYING(250) NULL,
    contact_role CHARACTER VARYING(50) NULL
);

CREATE TABLE CLIENTS
(
    id_client SERIAL NOT NULL PRIMARY KEY,
    client_nom CHARACTER VARYING(50) NULL,
    client_rs CHARACTER VARYING(50) NULL,
    client_adresse TEXT NULL,
    id_activite BIGINT REFERENCES ACTIVITES(id_activite),
    id_contact BIGINT REFERENCES CONTACT(id_contact)
);

CREATE TABLE DIVISIONS
(
    id_division SERIAL NOT NULL PRIMARY KEY,
    division_numero CHARACTER VARYING(250) NULL,
    division_nom CHARACTER VARYING(250) NULL,
    division_adresse TEXT NULL,
    division_localite CHARACTER VARYING(50) NULL
);

CREATE TABLE FONCTIONS
(
    id_fonction SERIAL NOT NULL PRIMARY KEY,
    nom_fonction CHARACTER VARYING(50) NULL
);

CREATE TABLE TYPES
(
    id_type SERIAL NOT NULL PRIMARY KEY,
    type_nom CHARACTER VARYING(250) NULL
);

CREATE TABLE MATERIELS
(
    id_materiel SERIAL NOT NULL PRIMARY KEY,
    materiel_nom CHARACTER VARYING(250) NULL,
    materiel_numero CHARACTER VARYING(10) NULL,
    materiel_reference CHARACTER VARYING(250) NULL,
    id_type BIGINT REFERENCES TYPES(id_type)
);

CREATE TABLE MATERIEL_COMPOSE
(
    id_materiel1 BIGINT NOT NULL,
    id_materiel2 BIGINT NOT NULL,
    PRIMARY KEY(id_materiel1,id_materiel2),
    FOREIGN KEY(id_materiel1) REFERENCES MATERIELS(id_materiel),
    FOREIGN KEY(id_materiel2) REFERENCES MATERIELS(id_materiel)
);

CREATE TABLE SALARIES
(
    id_salarie SERIAL NOT NULL PRIMARY KEY,
    salarie_matricule CHARACTER VARYING(10) NULL,
    salarie_nom CHARACTER VARYING(50) NULL,
    salarie_prenom CHARACTER VARYING(50) NULL,
    salarie_num_telephone CHARACTER VARYING(50) NULL,
    salarie_trigramme CHAR(3) UNIQUE,
    salarie_email CHARACTER VARYING(250) NULL,
    salarie_salaire BIGINT NULL,
    salarie_chef BIGINT REFERENCES salaries(id_salarie),
    id_division BIGINT REFERENCES DIVISIONS(id_division),
    id_fonction BIGINT REFERENCES FONCTIONS(id_fonction),
    id_materiel BIGINT REFERENCES MATERIELS(id_materiel)
);

CREATE TABLE EQUIPES
(
    id_equipe SERIAL NOT NULL PRIMARY KEY,
    equipe_nom CHARACTER VARYING(250) NULL,
    id_salarie BIGINT REFERENCES SALARIES(id_salarie),
    id_competence BIGINT REFERENCES COMPETENCES(id_competence)
);

CREATE TABLE SALARIES_EQUIPES
(
    id_salarie BIGINT NOT NULL,
    id_equipe BIGINT NOT NULL,
    date_debut DATE NULL,
    date_fin DATE NULL,
    PRIMARY KEY(id_salarie,id_equipe),
    FOREIGN KEY(id_salarie) REFERENCES SALARIES(id_salarie),
    FOREIGN KEY(id_equipe) REFERENCES EQUIPES(id_equipe)
);

CREATE TABLE THEMES
(
    id_theme SERIAL NOT NULL PRIMARY KEY,
    nom_theme CHARACTER VARYING(50) NULL
);

CREATE TABLE PROJETS
(
    id_projet SERIAL NOT NULL PRIMARY KEY,
    projet_nom CHARACTER VARYING(250) NULL,
    projet_numero CHARACTER VARYING(50) NULL,
    projet_description TEXT NULL,
    projet_date_debut DATE NULL,
    projet_date_fin DATE NULL,
    id_salarie BIGINT REFERENCES SALARIES(id_salarie),
    id_theme BIGINT REFERENCES THEMES(id_theme),
    id_client BIGINT REFERENCES CLIENTS(id_client)
);

CREATE TABLE TACHES
(
    id_tache SERIAL NOT NULL PRIMARY KEY,
    tache_nom CHARACTER VARYING(50) NULL,
    tache_description TEXT NULL,
    tache_numero CHARACTER VARYING(10) NULL,
    id_projet BIGINT REFERENCES PROJETS(id_projet)
);

CREATE TABLE SALARIES_TACHES
(
    id_salarie BIGINT NOT NULL,
    id_tache BIGINT NOT NULL,
    date_debut DATE NULL,
    date_fin DATE NULL,
    PRIMARY KEY(id_salarie,id_tache),
    FOREIGN KEY(id_salarie) REFERENCES SALARIES(id_salarie),
    FOREIGN KEY(id_tache) REFERENCES TACHES(id_tache)
);

--
     
