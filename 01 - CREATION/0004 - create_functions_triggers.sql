-------------------------           -------------------------
------------------------- FUNCTIONS -------------------------
-------------------------           -------------------------

--
-- FUNC 01 - Nombre de taches que le salarie a réalisé
--
CREATE OR REPLACE FUNCTION FCT01(id INTEGER) RETURNS INTEGER AS $$
DECLARE
    nb_taches INTEGER;
BEGIN
    nb_taches := (SELECT COUNT(*)
                    FROM SALARIES_TACHES
                    WHERE id_salarie = id);
                    RETURN nb_taches;
END; $$
LANGUAGE PLPGSQL;

-- Test function SELECT FCT01(1);


--
-- FUNC 02 - TRIGRAMME
--
CREATE OR REPLACE FUNCTION FCT02(prenom VARCHAR, nom VARCHAR) RETURNS VARCHAR AS $$
DECLARE
    trigramme VARCHAR(3); -- trigramme à retrouner
    select_count INTEGER; -- test pour savoir si le trigramme est présent
    i INTEGER ; -- index pour décaler si trigramme présent
BEGIN
    -- je récup mon nbr d'occurence
    select_count := (SELECT COUNT(*) 
        FROM  SALARIES 
        WHERE salarie_trigramme = (SUBSTRING ( prenom,1 ,1 )||SUBSTRING ( nom,1 ,1 )||SUBSTRING ( nom ,2 ,1 ))) ;
    -- Si mon trigramme n'existe pas
    IF(select_count = 0 ) THEN
        trigramme := SUBSTRING ( prenom,1 ,1 )||SUBSTRING ( nom ,1 ,1 )||SUBSTRING ( nom ,2 ,1 );
    -- Sinon mon trigramme est déjà présent
    ELSE
        i := 3;
        LOOP
            EXIT WHEN select_count = 0 ;
            -- Sinon je décale ma derniere lettre
            trigramme := SUBSTRING ( prenom,1 ,1 )||SUBSTRING ( nom ,1 ,1 )||SUBSTRING ( nom ,i ,1 );
            -- Je vérifie à nouveau si mon trigramme est présent
            select_count := (SELECT COUNT(*) 
                            FROM  SALARIES 
                            WHERE salarie_trigramme = trigramme);
            -- J'incrémente mon i pour le prochain passage si le trigramme est présent
            i := i +1;
        END LOOP;
	END IF;
    RETURN trigramme;
END; $$
LANGUAGE PLPGSQL;

-- Test function SELECT FCT02(1);

--
-- FUNC 03 - TRIGRAMME
--
CREATE OR REPLACE FUNCTION FCT03(p_id_salarie INTEGER) RETURNS VARCHAR AS $$
DECLARE
    retour_id INTEGER;
BEGIN
    retour_id := (SELECT id_equipe
                    FROM salaries_equipes
                    WHERE date_fin = (SELECT MAX(date_fin) FROM salaries_equipes) AND id_salarie = p_id_salarie);
    RETURN retour_id;
END; $$
LANGUAGE PLPGSQL;

-- Test function SELECT FCT03(1);




-------------------------         -------------------------
------------------------- TRIGGER -------------------------
-------------------------         -------------------------

----------------------------------------------------------
--  TRG01 : Création d'une tache à la création d'un projet 
----------------------------------------------------------
CREATE OR REPLACE FUNCTION TRG01() RETURNS trigger AS $TRG01$
     BEGIN
        -- Verifie que mon projet existe
         IF NEW.id_projet IS NULL THEN
             RAISE EXCEPTION 'id_projet ne peut pas être NULL';
         END IF;
	
 		INSERT INTO taches (id_tache,tache_nom,tache_description,tache_numero,id_projet)
 		VALUES(DEFAULT, 'Initialisation', 'Démarrage du projet', '0', NEW.id_projet);
        RETURN NEW;
     END;
 $TRG01$ LANGUAGE plpgsql;

 CREATE TRIGGER TRG01 AFTER INSERT  ON projets
     FOR EACH ROW EXECUTE PROCEDURE TRG01();

-- TEST 
-- INSERT INTO salaries VALUES(DEFAULT,'fp256','pasquet','florent', '0615373596', '', 'florent@spinat.fr', 30000, DEFAULT, DEFAULT, DEFAULT );

---------------------------------------
-- TRG02 : Nom de la tache en majuscule
---------------------------------------
CREATE OR REPLACE FUNCTION TRG02() RETURNS trigger AS $TRG02$
     BEGIN
        -- Verifie que mon projet existe
         IF NEW.tache_nom IS NULL THEN
             RAISE EXCEPTION 'Désolé cooco pas de uppercase pour tache_nom, tache_nom is null ';
         END IF;
        NEW.tache_nom =  UPPER(NEW.tache_nom);
        RETURN NEW;
     END;
 $TRG02$ LANGUAGE plpgsql;

 CREATE TRIGGER TRG02 BEFORE INSERT OR UPDATE ON taches
     FOR EACH ROW EXECUTE PROCEDURE TRG02();


---------------------------------------
-- TRG03 : Création du Trigramme
---------------------------------------
CREATE OR REPLACE FUNCTION TRG03() RETURNS trigger AS $TRG03$
     BEGIN	
        NEW.salarie_trigramme = FCT02(NEW.salarie_prenom, NEW.salarie_nom);
        RETURN NEW;
     END;
 $TRG03$ LANGUAGE plpgsql;

 CREATE TRIGGER TRG03 BEFORE INSERT  ON salaries
     FOR EACH ROW EXECUTE PROCEDURE TRG03();


-- TEST INSERT
-- INSERT INTO salaries VALUES(DEFAULT,'didou24','largeron','didier', '06153735924', '', 'd.largeron@ideal-com.com', 30000, DEFAULT, DEFAULT, DEFAULT );INSERT INTO salaries VALUES(DEFAULT,'didou24','largeron','didier', '06153735924', '', 'd.largeron@ideal-com.com', 30000, DEFAULT, DEFAULT, DEFAULT );
