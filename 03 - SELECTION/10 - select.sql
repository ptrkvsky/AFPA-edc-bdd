---------------------------        -------------------------
--------------------------- SELECT -------------------------
---------------------------        -------------------------

-- REQ 01 
SELECT DISTINCT(tache_nom), projet_nom, salaries.salarie_nom
FROM taches
LEFT JOIN salaries_taches ON taches.id_tache = salaries_taches.id_tache
LEFT JOIN projets ON projets.id_projet = taches.id_projet
LEFT JOIN salaries ON salaries_taches.id_salarie = salaries.id_salarie
ORDER BY projet_nom
;

-- REQ 03 -- Hierarchie de l'entreprise
SELECT s2.salarie_nom, s2.id_salarie
FROM salaries AS s2
WHERE s2.id_salarie IN(
	SELECT DISTINCT(s1.salarie_chef)
	FROM salaries AS s1)
OR salarie_chef ISNULL;

-- REQ 04 -- Liste des clients pour lesquels chaque salarié a travaillé
SELECT DISTINCT(client_nom) 
FROM clients
LEFT JOIN projets ON projets.id_client = clients.id_client
LEFT JOIN taches ON taches.id_projet = projets.id_projet
LEFT JOIN salaries_taches ON salaries_taches.id_tache = taches.id_tache
LEFT JOIN salaries ON salaries_taches.id_salarie = salaries.id_salarie 
ORDER BY client_nom;