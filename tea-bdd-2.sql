
-- Participants : Vinet Brian, Kolo Mandossi Jason, Bidet Paul, Claeysens Henri
-- Responssable : Vinet Brian

-----------------------------------
-- Partie 1 : Créations des tables
-----------------------------------

set datestyle to 'european'; 

DROP TABLE IF EXISTS membres;
DROP TABLE IF EXISTS producteurs;
DROP TABLE IF EXISTS vins;
DROP TABLE IF EXISTS commandes;


-- création de la table membres, nous voulons que les numéro des membres soient référencés avec un nombre supérieur à 50 
-- ensuite, nous voulons remplir les attributs nom, prenom et adresse avec du texte, entre 30/50 charactères et ils doivent être obligatoirement saisi
-- nous avons ajouté un attribut pxabonnement, qui va correspondre donc au prix de l'abonnement que le membre à prit chez un producteur 
-- nous trouvons ça intérréssant d'ajouter cet attribut car on pourrait créer un sujet qui fonctionne comme le système du site lepetitballon.com 
-- des personnes qui s'inscrivent et prennent un abonnement pour recevoir un panier de vins
-- enfin, l'attribut numéro du membre est unique, nous lui attribuons la clé primaire 

CREATE TABLE membres (
  nomembre INTEGER
    CHECK (nomembre > 50), 
  nom VARCHAR(30) NOT NULL , 
  prenom VARCHAR(30) NOT NULL, 
  ville VARCHAR(50) NOT NULL,
  pxabonnement INTEGER NOT NULL ,
  PRIMARY KEY(nomembre)
);


-- création de la table producteurs, le numéro du producteur doit commencer par 'PDT' et se terminer par 2 chiffres que nous metterons lors de l'insertion 
-- ensuite, même chose que pour les membres, nous voulons remplir les attributs nom, prenom et adresse avec du texte, entre 30/50 charactères 
-- et ils doivent être obligatoirement saisi
-- enfin,  l'attribut numéro du producteur est unique, nous lui attribuons la clé primaire 

CREATE TABLE producteurs (
  noproducteur CHAR(5) NOT NULL
    CHECK (noproducteur LIKE 'PDT__'),
  nom VARCHAR(30) NOT NULL , 
  prenom VARCHAR(30), 
  ville VARCHAR(50) NOT NULL, 
  PRIMARY KEY(noproducteur)
    
);


-- création de la table des vins, même raisonnement que pour la table producteurs, le numéro du vin doit commencer par 'VIN' et se terminer par 2 chiffres que nous metterons lors de l'insertion 
-- ensuite, nous avons décisder de supprimer les attributs Cru et Région, et de les remplacer par les attributs pxvente, chargevariable, chargefixe 
-- Ces nouveaux attributs nous semble plus intérréssant, car nous pouvons construire un sujet du même type qu'un exercice de Contrôle de Gestion 
-- et ainsi nous pouvons avoir un sujet plus interréséssant qui, avec les requêtes, pourra répondre à des questions de Gestion, utiles à un producteur, par exemple
-- Pour les attributs millesime et chargevariable, nous les remplissons avec un nombre et ils doivent être obligatoirement saisi
-- Pour les attributs chargevariables et chargefixe, nous les remplissons avec un nombre qui pourra prendre un virgule et ils doivent être obligatoirement saisi
-- enfin, chaque vins est produit par un producteur donc le noproducteur revient comme une clé secondaire avec la même exception de saisi
-- puis, l'attribut novin est unique, nous lui attribuons le clé primaire 

CREATE TABLE vins (
  novin CHAR(5) NOT NULL
    CHECK (novin LIKE 'VIN__'),
  millesime INTEGER NOT NULL , 
  pxvente INTEGER NOT NULL ,
  chargevariable FLOAT NOT NULL,
  chargefixe FLOAT NOT NULL,
  noproducteur CHAR(5) NOT NULL
    CHECK (noproducteur LIKE 'PDT%'),
  PRIMARY KEY(novin),
  FOREIGN KEY(noproducteur) REFERENCES producteurs
    
);


--création de la table commandes, pas de suppression ou d'ajout d'attributs
-- l'attribut nocommande sera saisi obligatoirement avec un nombre et est unique, nous lui attribuons la clé primaire 
-- Les attributs datecommande et qtecommandee sont obligatoirement saisi 
-- Nous avons attribué à l'attribut datecommande un type DATE pour saisir une date et nous avons attribué un type SMALLINT à l'attribut qtecommandee 
-- ensuite, chaque commande est associée à un vins, donc l'attribut novin revient comme clé secondaire avec la même exception de saisi
-- puis dans chaque commande est également associée un membre, donc l'attribut nomembre revient comme clé secondaire avec, indirectement, la même exception de saisi

CREATE TABLE commandes (
  nocommande INTEGER NOT NULL,
  datecommande DATE NOT NULL ,
  qtecommandee SMALLINT NOT NULL,
  nomembre INTEGER NOT NULL,
  novin CHAR(5) NOT NULL
    CHECK (novin LIKE 'VIN%'),
  PRIMARY KEY(nocommande),
  FOREIGN KEY(nomembre) REFERENCES membres,
  FOREIGN KEY(novin) REFERENCES vins

    
);


-----------------------------------
-- Partie 2 : Insertions
-----------------------------------


INSERT INTO membres VALUES ( 51, 'Arnaud', 'Jean', 'Bordeaux', 20);
INSERT INTO membres VALUES ( 52, 'Elleau', 'Pierre', 'Bordeaux', 15);
INSERT INTO membres VALUES ( 53, 'Junior', 'Julien', 'Pau', 30);
INSERT INTO membres VALUES ( 54, 'Cassi', 'Amandine', 'Toulouse', 15);
INSERT INTO membres VALUES ( 55, 'François', 'Halle', 'Biarritz', 15);

INSERT INTO producteurs VALUES ('PDT01', 'Yann', NULL, 'Nice');
INSERT INTO producteurs VALUES ('PDT23', 'Jean', 'Corentin', 'Bordeaux');
INSERT INTO producteurs VALUES ('PDT65', 'Bidet', 'Paul', 'Marseille');
INSERT INTO producteurs VALUES ('PDT98', 'Vinet', 'Brian', 'Montpellier');
INSERT INTO producteurs VALUES ('PDT87', 'Kolo', NULL, 'Bordeaux');


INSERT INTO vins VALUES ( 'VIN45', 2006, 50, 6.76, 100, 'PDT01');
INSERT INTO vins VALUES ( 'VIN56', 2002, 42, 8.56, 100, 'PDT23');
INSERT INTO vins VALUES ( 'VIN76', 1999, 37, 9.30, 100, 'PDT87');
INSERT INTO vins VALUES ( 'VIN13', 2003, 41, 5.41, 100, 'PDT65');
INSERT INTO vins VALUES ( 'VIN35', 1999, 54, 7.80, 100, 'PDT98');
INSERT INTO vins VALUES ( 'VIN98', 1998, 65, 11.45, 100, 'PDT87');
INSERT INTO vins VALUES ( 'VIN41', 1998, 76, 10.60, 100, 'PDT23');
INSERT INTO vins VALUES ( 'VIN72', 2002, 45, 8.90, 100, 'PDT23');
INSERT INTO vins VALUES ( 'VIN49', 1999, 38, 7.48, 100, 'PDT98');
INSERT INTO vins VALUES ( 'VIN19', 1999, 61, 12.67, 100, 'PDT01');
INSERT INTO vins VALUES ( 'VIN37', 2003, 50, 9.10, 100, 'PDT23');


INSERT INTO  commandes VALUES ( 1042, '16/02/2020', 5, 51, 'VIN56');
INSERT INTO  commandes VALUES ( 1043, '19/02/2020', 4, 53, 'VIN49');
INSERT INTO  commandes VALUES ( 1044, '24/03/2020', 4, 51, 'VIN45');
INSERT INTO  commandes VALUES ( 1045, '27/05/2020', 7, 52, 'VIN72');
INSERT INTO  commandes VALUES ( 1046, '21/05/2020', 4, 55, 'VIN19');
INSERT INTO  commandes VALUES ( 1047, '14/06/2020', 8, 54, 'VIN56');
INSERT INTO  commandes VALUES ( 1048, '11/06/2020', 12, 53, 'VIN13');
INSERT INTO  commandes VALUES ( 1049, '26/07/2020', 3, 51, 'VIN45');
INSERT INTO  commandes VALUES ( 1050, '17/12/2020', 5, 55, 'VIN13');
INSERT INTO  commandes VALUES ( 1051, '15/12/2020', 8, 51, 'VIN35');
INSERT INTO  commandes VALUES ( 1052, '29/12/2020', 9, 53, 'VIN56');



-----------------------------------
-- Partie 3 : Requêtes
-----------------------------------


-- Cette requête à pour objectif de renvoyer la moyenne des commandes, le minimum de commande, le maximum de commande et la moyenne des âges des vins--
select 
  ROUND(AVG(qtecommandee)) as moyenne_commande, 
  MIN(qtecommandee) as minimum_de_commande, 
  MAX(qtecommandee) as maximum_de_commande, 
  ROUND(AVG(millesime)) as moyenne_age_vin 
from commandes
join vins on vins.novin = commandes.novin


-- Cette requête à pour objectif de renvoyer le vin le plus commandé --
select novin, COUNT(novin) as nb 
from commandes
GROUP BY novin
HAVING COUNT(novin) >= ALL(select COUNT(novin) as nb from commandes
GROUP BY novin)


-- Cette requête à pour objectif de renvoyer les novin les moins commandés--
select novin, COUNT(novin) as nb from commandes
GROUP BY novin 
HAVING COUNT(novin) < ANY (select COUNT(novin) as nb from commandes
GROUP BY novin)


-- Cette requête à pour objectif de renvoyer combien il y a eu de bouteilles commandées, entre février/mai et décembre--
select SUM(qtecommandee) from commandes where datecommande BETWEEN '16/02/2020' AND '27/05/2020'
UNION 
select SUM(qtecommandee) from commandes where datecommande BETWEEN '15/12/2020' AND '29/12/2020'


--Cette requête à pour objectif de renvoyer le nombre de commande par vins et même les vins qui n'ont pas été encore commandés--
select vins.novin, SUM(qtecommandee) AS nb_commande from vins
LEFT JOIN commandes on commandes.novin = vins.novin
GROUP BY vins.novin 
ORDER BY nb_commande DESC


--Cette requête à pour objectif de renvoyer le nom du membre chez qui il exite une bouteille de vins n°35 --
SELECT nom
FROM membres
WHERE EXISTS (
	SELECT novin
	FROM commandes
	WHERE membres.nomembre = commandes.nomembre
	  AND novin ='VIN35'
);


--Cette requête à pour objectif de renvoyer les vins qui ne sont pas produit à Bordeaux et Marseille--
SELECT novin, producteurs.ville FROM vins
join producteurs ON producteurs.noproducteur = vins.noproducteur 
WHERE  producteurs.ville NOT IN('Bordeaux', 'Marseille')
ORDER BY producteurs.ville


--Cette requête à pour objectif de renvoyer toutes les commandes et le prenom des membres associés, sauf les commandes passées par le membre Julien--
SELECT nocommande, membres.prenom FROM commandes
join membres ON membres.nomembre = commandes.nomembre 
EXCEPT  
SELECT nocommande, membres.prenom FROM commandes 
join membres ON membres.nomembre = commandes.nomembre 
WHERE membres.prenom = 'Julien'


--Cette requête à pour objectif de renvoyer la denière commande du membre qui a fait le plus de commande--
SELECT nocommande,datecommande
FROM commandes
WHERE nomembre =(
  SELECT nomembre
  FROM commandes
  GROUP BY nomembre
  HAVING COUNT(nocommande) =(
    SELECT MAX(nb) FROM
      (SELECT COUNT(nocommande) as nb
      FROM commandes
      GROUP BY nomembre) as req_sub
  )
)
ORDER BY datecommande DESC


--Cette requête à pour objectif de renvoyer les vins qui ont le même prix que le vin VIN37 et moins de chargevariable que le vin VIN49  --
SELECT * from vins
WHERE pxvente = ( SELECT pxvente from vins WHERE novin='VIN37')
  AND chargevariable < ( SELECT chargevariable FROM vins WHERE novin='VIN49')


--Cette requête à pour objectif de renvoyer le résultat de chaque vin et son taux de profit --
select noproducteur, 
  novin, 
  nb_commande, 
  pxvente, 
  CA, 
  cv, 
  chargefixe,
  resultat, 
  (resultat/CA)*100 as txprofit 
from (
      select producteurs.noproducteur, vins.novin,
        SUM(commandes.qtecommandee) as nb_commande, 
        pxvente,
        pxvente*SUM(commandes.qtecommandee) as CA, 
        ROUND(chargevariable*SUM(commandes.qtecommandee)) as cv, 
        chargefixe, 
        pxvente*SUM(commandes.qtecommandee)-chargevariable*SUM(commandes.qtecommandee)-chargefixe as resultat
      from producteurs
      join vins on vins.noproducteur = producteurs.noproducteur
      join commandes on commandes.novin = vins.novin
      GROUP BY producteurs.noproducteur, vins.novin, pxvente
      ORDER BY producteurs.nom
    ) as req_sub

GROUP BY noproducteur, novin, nb_commande, pxvente, CA, cv, chargefixe, resultat, txprofit
ORDER BY noproducteur


--Cette requête à pour objectif de renvoyer le prix de vente de base et le prix minimal de vente 
--Les PDT01 et PDT98 souhaitent conserver le même nb de vente pour leur vins 
--et ils aimeraient savoir à quel prix minimal doivent-ils vendre leur vins pour qu'ils ne degagent pas de perte
select 
noproducteur,
pxvente, 
(cv+chargefixe)/qtecommandee as minimal_px_vente
from(
      select 
        producteurs.noproducteur,
        pxvente, 
        SUM(commandes.qtecommandee) as qtecommandee,
        ROUND(chargevariable*SUM(commandes.qtecommandee)) as cv, 
        chargefixe
      from producteurs
      join vins on vins.noproducteur = producteurs.noproducteur
      join commandes on commandes.novin = vins.novin
      GROUP BY producteurs.noproducteur, pxvente, chargevariable, chargefixe

) as req_sub

WHERE noproducteur = 'PDT01' OR noproducteur = 'PDT98'
GROUP BY
noproducteur,
pxvente, 
minimal_px_vente


--Cette requête à pour objectif de renvoyer le total qu'a dépensé chaque membre --
select  
  membres.nomembre, 
  membres.nom, 
  SUM(pxvente*commandes.qtecommandee) as total_depense,
  pxabonnement,
  SUM(pxvente*commandes.qtecommandee)+pxabonnement as total_depence_avec_abo
from membres
join commandes on commandes.nomembre = membres.nomembre
join vins on vins.novin = commandes.novin
GROUP BY membres.nomembre, membres.nom
ORDER BY membres.nomembre 


--V2 vue détaillée sans abonnement--
--select  
  --membres.nomembre, 
  --membres.nom, 
  --novin,
  --SUM(pxvente*commandes.qtecommandee) as total_depense,
--from membres
--join commandes on commandes.nomembre = membres.nomembre
--join vins on vins.novin = commandes.novin
--GROUP BY novin, membres.nomembre, membres.nom
--ORDER BY membres.nomembre 















