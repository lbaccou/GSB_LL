<?php
include("vues/v_sommaire.php");
$action = $_REQUEST['action'];
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
		$pdo->creeNouveauCompteRendu($idVisiteur, $idProspect, $note, $libelle);
		break;
	}
	case 'ListeCompteRendu':
	{
		//$comptesRendus = $pdo->getComptesRendus($idVisiteur)
		break;
	}

}
?>