<form method="POST" action="index.php?uc=compteRendu&action=validerCompteRendu">
  <select>
  <?php foreach ($infosProspect as $infoProspect)
  { ?>
    <option id = "<?= $infoProspect['idProspect']; ?>"> <?= $infoProspect['nom']; ?> <?= $infoProspect['prenom']; ?> </option>
  <?php }
  ?>
  </select>
  <input type="submit" value="Valider" name="valider">
</form>
