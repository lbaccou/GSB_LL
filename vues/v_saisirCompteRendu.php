<form method="POST" action="index.php?uc=compteRendu&action=validerCompteRendu">
  <select name = "prospect">
  <?php foreach ($infosProspect as $infoProspect)
  { ?>
    <option value = "<?= $infoProspect['idProspect']; ?>"> <?= $infoProspect['nom']; ?> <?= $infoProspect['prenom']; ?> </option>
  <?php }
  ?>
  </select>
  <input type="submit" value="Valider" name="valider">
</form>