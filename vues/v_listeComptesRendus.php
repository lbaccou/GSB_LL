<table>
 <tr>
   <th>Date<th>
   <th>Nom Visiteur<th>
   <th>Prénom Visiteur<th>
   <th>Nom Prospect<th>
   <th>Prénom Prospect<th>
   <th>Note<th>
  <th>Consulter le compte-rendu<th>
 </tr>
   <?php foreach ($comptesRendus as $compteRendu)
   { ?>
 <tr>
   <td><?= $compteRendu['date']; ?><td>
   <td><?= $compteRendu['nomVisiteur']; ?><td>
   <td><?= $compteRendu['prenomVisiteur']; ?><td>
   <td><?= $compteRendu['nomProspect']; ?><td>
   <td><?= $compteRendu['prenomProspect']; ?><td>
   <td><?= $compteRendu['note']; ?><td>
   <td><a href="index.php?uc=compteRendu&action="
 </tr>
   <?php
    } ?>
</table>
