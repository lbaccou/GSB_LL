  <!-- Division pour le sommaire -->
  <div id="menuGauche">
  <div id="infosUtil">

  <h2>

  </h2>

  </div>
    <ul id="menuList">
      <li >
      Visiteur :
      <br>
        <?php echo $_SESSION['prenom']."  ".$_SESSION['nom']  ?>
      </li>
      <li class="smenu">
        <a href="index.php?uc=gererFrais&action=saisirFrais" title="Saisie fiche de frais ">Saisie fiche de frais</a>
      </li>
      <li class="smenu">
        <a href="index.php?uc=etatFrais&action=selectionnerMois" title="Consultation de mes fiches de frais">Mes fiches de frais</a>
      </li>
      <li class="smenu">
        <a href="index.php?uc=compteRendu&action=saisirCompteRendu" title="Saisie d'un compte-rendu">Saisie d'un Compte-rendu</a>
      </li>
      <li class="smenu">
        <a href="index.php?uc=compteRendu&action=listeComptesRendus" title="Liste des comptes-rendus">Liste des Comptes-rendus</a>
      </li>
      <li class="smenu">
        <a href="index.php?uc=connexion&action=deconnexion" title="Se déconnecter">Déconnexion</a>
      </li>
    </ul>

  </div>
