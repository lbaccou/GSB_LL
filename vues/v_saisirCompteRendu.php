<form method="POST" action="index.php?uc=compteRendu&action=validerCompteRendu">
  <select name = "prospect">
  <?php foreach ($infosProspect as $infoProspect)
  { ?>
    <option value = "<?= $infoProspect['IdProspect']; ?>"> <?= $infoProspect['nom']; ?> <?= $infoProspect['prenom']; ?> </option>
  <?php }
  ?>
  </select>
  <select name = "note">
    <option value = "1"> 1 </option>
    <option value = "2"> 2 </option>
    <option value = "3"> 3 </option>
    <option value = "4"> 4 </option>
    <option value = "5"> 5 </option>
  </select>
  <textarea name="libelle"></textarea>
  <input type="submit" value="Valider" name="valider">
</form>
