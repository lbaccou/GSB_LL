-- Adminer 4.4.0 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `CompteRendu`;
CREATE TABLE `CompteRendu` (
  `RefVisiteur` char(4) NOT NULL,
  `NumeroOrdre` int(11) NOT NULL,
  `RefProspect` int(11) NOT NULL,
  `Note` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Libelle` char(255) NOT NULL,
  PRIMARY KEY (`NumeroOrdre`,`RefVisiteur`),
  KEY `RefVisiteur` (`RefVisiteur`),
  KEY `RefProspect` (`RefProspect`),
  CONSTRAINT `CompteRendu_ibfk_1` FOREIGN KEY (`RefVisiteur`) REFERENCES `Visiteur` (`id`),
  CONSTRAINT `CompteRendu_ibfk_2` FOREIGN KEY (`RefProspect`) REFERENCES `Prospect` (`IdProspect`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `CompteRendu` (`RefVisiteur`, `NumeroOrdre`, `RefProspect`, `Note`, `Date`, `Libelle`) VALUES
('v1',	1,	1,	1,	'2018-02-07',	'Très mauvais'),
('v2',	1,	1,	2,	'2018-02-08',	'ivliyf'),
('v3',	1,	2,	3,	'2018-01-08',	'igyiguy');

DROP TABLE IF EXISTS `Etat`;
CREATE TABLE `Etat` (
  `id` char(2) NOT NULL,
  `libelle` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `Etat` (`id`, `libelle`) VALUES
('CL',	'Saisie clôturée'),
('CR',	'Fiche créée, saisie en cours'),
('RB',	'Remboursée'),
('VA',	'Validée et mise en paiement');

DROP TABLE IF EXISTS `FicheFrais`;
CREATE TABLE `FicheFrais` (
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `nbJustificatifs` int(11) DEFAULT NULL,
  `montantValide` decimal(10,2) DEFAULT NULL,
  `dateModif` date DEFAULT NULL,
  `idEtat` char(2) DEFAULT 'CR',
  PRIMARY KEY (`idVisiteur`,`mois`),
  KEY `idEtat` (`idEtat`),
  CONSTRAINT `FicheFrais_ibfk_1` FOREIGN KEY (`idEtat`) REFERENCES `Etat` (`id`),
  CONSTRAINT `FicheFrais_ibfk_2` FOREIGN KEY (`idVisiteur`) REFERENCES `Visiteur` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `FicheFrais` (`idVisiteur`, `mois`, `nbJustificatifs`, `montantValide`, `dateModif`, `idEtat`) VALUES
('f4',	'01',	0,	0.00,	'2018-02-07',	'CL'),
('f4',	'02',	0,	0.00,	'2018-02-07',	'CR'),
('v1',	'02',	0,	0.00,	'2018-02-07',	'CR');

DROP TABLE IF EXISTS `FraisForfait`;
CREATE TABLE `FraisForfait` (
  `id` char(3) NOT NULL,
  `libelle` char(20) DEFAULT NULL,
  `montant` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `FraisForfait` (`id`, `libelle`, `montant`) VALUES
('ETP',	'Forfait Etape',	110.00),
('KM',	'Frais Kilométrique',	0.62),
('NUI',	'Nuitée Hôtel',	80.00),
('REP',	'Repas Restaurant',	25.00);

DROP TABLE IF EXISTS `LigneFraisForfait`;
CREATE TABLE `LigneFraisForfait` (
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `idFraisForfait` char(3) NOT NULL,
  `quantite` int(11) DEFAULT NULL,
  PRIMARY KEY (`idVisiteur`,`mois`,`idFraisForfait`),
  KEY `idFraisForfait` (`idFraisForfait`),
  CONSTRAINT `LigneFraisForfait_ibfk_1` FOREIGN KEY (`idVisiteur`, `mois`) REFERENCES `FicheFrais` (`idVisiteur`, `mois`),
  CONSTRAINT `LigneFraisForfait_ibfk_2` FOREIGN KEY (`idFraisForfait`) REFERENCES `FraisForfait` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `LigneFraisForfait` (`idVisiteur`, `mois`, `idFraisForfait`, `quantite`) VALUES
('f4',	'01',	'ETP',	0),
('f4',	'01',	'KM',	0),
('f4',	'01',	'NUI',	0),
('f4',	'01',	'REP',	0),
('f4',	'02',	'ETP',	0),
('f4',	'02',	'KM',	0),
('f4',	'02',	'NUI',	0),
('f4',	'02',	'REP',	0),
('v1',	'02',	'ETP',	0),
('v1',	'02',	'KM',	0),
('v1',	'02',	'NUI',	0),
('v1',	'02',	'REP',	0);

DROP TABLE IF EXISTS `LigneFraisHorsForfait`;
CREATE TABLE `LigneFraisHorsForfait` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `libelle` char(100) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `montant` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idVisiteur` (`idVisiteur`,`mois`),
  CONSTRAINT `LigneFraisHorsForfait_ibfk_1` FOREIGN KEY (`idVisiteur`, `mois`) REFERENCES `FicheFrais` (`idVisiteur`, `mois`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `MetierProspect`;
CREATE TABLE `MetierProspect` (
  `TypeMetier` int(11) NOT NULL AUTO_INCREMENT,
  `Libelle` char(30) NOT NULL,
  PRIMARY KEY (`TypeMetier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `MetierProspect` (`TypeMetier`, `Libelle`) VALUES
(1,	'Médecin'),
(2,	'Chirurgien'),
(3,	'Pharmacien');

DROP TABLE IF EXISTS `Prospect`;
CREATE TABLE `Prospect` (
  `IdProspect` int(11) NOT NULL,
  `prenom` char(30) NOT NULL,
  `nom` char(30) NOT NULL,
  `ville` char(30) NOT NULL,
  `numTelephone` char(11) NOT NULL,
  `adresseMail` char(30) NOT NULL,
  `IdMetier` int(11) NOT NULL,
  PRIMARY KEY (`IdProspect`),
  KEY `IdMetier` (`IdMetier`),
  CONSTRAINT `Prospect_ibfk_1` FOREIGN KEY (`IdMetier`) REFERENCES `MetierProspect` (`TypeMetier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `Prospect` (`IdProspect`, `prenom`, `nom`, `ville`, `numTelephone`, `adresseMail`, `IdMetier`) VALUES
(1,	'test1',	'test1',	'test1',	'0652147839',	'test@gmail.com',	2),
(2,	'test2',	'test2',	'test2',	'0745896321',	'test2@gmail.com',	1),
(3,	'test3',	'test3',	'test3',	'0647892136',	'test3@gmail.com',	3),
(4,	'test4',	'test4',	'test4',	'0654213987',	'test4@gmail.com',	1),
(5,	'test5',	'test5',	'test5',	'0645123897',	'test5@gmail.com',	3);

DROP TABLE IF EXISTS `Visiteur`;
CREATE TABLE `Visiteur` (
  `id` char(4) NOT NULL,
  `nom` char(30) DEFAULT NULL,
  `prenom` char(30) DEFAULT NULL,
  `login` char(20) DEFAULT NULL,
  `mdp` char(20) DEFAULT NULL,
  `adresse` char(30) DEFAULT NULL,
  `cp` char(5) DEFAULT NULL,
  `ville` char(30) DEFAULT NULL,
  `dateEmbauche` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `Visiteur` (`id`, `nom`, `prenom`, `login`, `mdp`, `adresse`, `cp`, `ville`, `dateEmbauche`) VALUES
('b16',	'Bioret',	'Luc',	'lbioret',	'hrjfs',	'1 Avenue gambetta',	'46000',	'Cahors',	'1998-05-11'),
('b19',	'Bunisset',	'Francis',	'fbunisset',	'4vbnd',	'10 rue des Perles',	'93100',	'Montreuil',	'1987-10-21'),
('b25',	'Bunisset',	'Denise',	'dbunisset',	's1y1r',	'23 rue Manin',	'75019',	'paris',	'2010-12-05'),
('b28',	'Cacheux',	'Bernard',	'bcacheux',	'uf7r3',	'114 rue Blanche',	'75017',	'Paris',	'2009-11-12'),
('b34',	'Cadic',	'Eric',	'ecadic',	'6u8dc',	'123 avenue de la République',	'75011',	'Paris',	'2008-09-23'),
('b4',	'Charoze',	'Catherine',	'ccharoze',	'u817o',	'100 rue Petit',	'75019',	'Paris',	'2005-11-12'),
('b50',	'Clepkens',	'Christophe',	'cclepkens',	'bw1us',	'12 allée des Anges',	'93230',	'Romainville',	'2003-08-11'),
('b59',	'Cottin',	'Vincenne',	'vcottin',	'2hoh9',	'36 rue Des Roches',	'93100',	'Monteuil',	'2001-11-18'),
('c14',	'Daburon',	'François',	'fdaburon',	'7oqpv',	'13 rue de Chanzy',	'94000',	'Créteil',	'2002-02-11'),
('c3',	'De',	'Philippe',	'pde',	'gk9kx',	'13 rue Barthes',	'94000',	'Créteil',	'2010-12-14'),
('c54',	'Debelle',	'Michel',	'mdebelle',	'od5rt',	'181 avenue Barbusse',	'93210',	'Rosny',	'2006-11-23'),
('d13',	'Debelle',	'Jeanne',	'jdebelle',	'nvwqq',	'134 allée des Joncs',	'44000',	'Nantes',	'2000-05-11'),
('d51',	'Debroise',	'Michel',	'mdebroise',	'sghkb',	'2 Bld Jourdain',	'44000',	'Nantes',	'2001-04-17'),
('e22',	'Desmarquest',	'Nathalie',	'ndesmarquest',	'f1fob',	'14 Place d Arc',	'45000',	'Orléans',	'2005-11-12'),
('e24',	'Desnost',	'Pierre',	'pdesnost',	'4k2o5',	'16 avenue des Cèdres',	'23200',	'Guéret',	'2001-02-05'),
('e39',	'Dudouit',	'Frédéric',	'fdudouit',	'44im8',	'18 rue de l église',	'23120',	'GrandBourg',	'2000-08-01'),
('e49',	'Duncombe',	'Claude',	'cduncombe',	'qf77j',	'19 rue de la tour',	'23100',	'La souteraine',	'1987-10-10'),
('e5',	'Enault-Pascreau',	'Céline',	'cenault',	'y2qdu',	'25 place de la gare',	'23200',	'Gueret',	'1995-09-01'),
('e52',	'Eynde',	'Valérie',	'veynde',	'i7sn3',	'3 Grand Place',	'13015',	'Marseille',	'1999-11-01'),
('f21',	'Finck',	'Jacques',	'jfinck',	'mpb3t',	'10 avenue du Prado',	'13002',	'Marseille',	'2001-11-10'),
('f39',	'Frémont',	'Fernande',	'ffremont',	'xs5tq',	'4 route de la mer',	'13012',	'Allauh',	'1998-10-01'),
('f4',	'Gest',	'Alain',	'agest',	'dywvt',	'30 avenue de la mer',	'13025',	'Berre',	'1985-11-01'),
('v1',	'test1',	'test1',	'test1',	'test1',	'8 rue des Charmes',	'46000',	'Cahors',	'2005-12-21'),
('v2',	'test2',	'test2',	'test2',	'test2',	'1 rue Petit',	'46200',	'Lalbenque',	'1998-11-23'),
('v3',	'test3',	'test3',	'test3',	'test3',	'1 rue Peranud',	'46250',	'Montcuq',	'1995-01-12'),
('v4',	'test4',	'test4',	'test4',	'test4',	'22 rue des Ternes',	'46123',	'Gramat',	'2000-05-01'),
('v5',	'test5',	'test5',	'test5',	'test5',	'11 allée des Cerises',	'46512',	'Bessines',	'1992-07-09');

-- 2018-02-16 13:58:07