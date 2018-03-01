<?php
include("vues/v_sommaire.php");
$action = $_REQUEST['action'];
$idVisiteur = $_SESSION['idVisiteur'];
switch($action)
{
	case 'saisirCompteRendu' :
	{
		$infosProspect = $pdo->getInfosProspect();
		include("vues/v_saisirCompteRendu.php");
		break;
	}
	case 'validerCompteRendu':
	{
		$idProspect = $_REQUEST['idProspect'];
		$note = $_REQUEST['note'];
		$libelle = $_REQUEST['libelle'];
		$numeroOrdre = $pdo->getNouveauNumeroOrdre($idVisiteur);
		$pdo->creeNouveauCompteRendu($idVisiteur, $numeroOrdre[0], $idProspect, $note, $libelle);
		break;
	}
	case 'ListeCompteRendu':
	{
		//$comptesRendus = $pdo->getComptesRendus($idVisiteur)
		break;
	}

}
?>
