// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:my_app_flutter/model/player.dart';
//
// class HomeAdapter {
//   final Player? players;
//   HomeAdapter(this.players);
//
//   @override
//   int get itemCount => 1;
//
//   @override
//   CustomViewHolder onCreateViewHolder(BuildContext context, int viewType) {
//     final v = SingleRowBinding.inflate(
//       LayoutInflater.from(context),
//       parent: false,
//     );
//     return CustomViewHolder(v);
//   }
//
//   @override
//   void onBindViewHolder(CustomViewHolder holder, int position) {
//     try {
//       if (isPlayerDataValid(players)) {
//         final v = holder.v;
//         final labelsArray = players?.labels;
//         final labelSmallUrls = extractSmallUrls(labelsArray);
//
//         v.tvBestTrophies.text = "Best Trophies: ${players?.bestTrophies}";
//         v.tvBestVersusTrophies.text = "Best Versus Trophies: ${players?.bestVersusTrophies}";
//         v.tvBuilderHallLevel.text = "Builder Hall Level: ${players?.builderHallLevel}";
//         v.tvClan.text = "Clan name: ${players?.clan?.name ?? ''}";
//         v.tvDonations.text = "Donations: ${players?.donations}";
//         v.tvDonationsReceived.text = "Donations Received: ${players?.donationsReceived}";
//         v.tvExpLevel.text = "Exp Level: ${players?.expLevel}";
//         v.tvLabel.text = "Labels: ${parseLabels(labelsArray)}";
//
//         for (var i = 0; i < 3; i++) {
//           if (i < labelSmallUrls.length) {
//             final labelIconUrl = labelSmallUrls[i];
//             // Usa il pacchetto corretto per il caricamento delle immagini (ad es. CachedNetworkImage)
//             // CachedNetworkImage è solo un esempio, puoi usare un altro pacchetto per il caching delle immagini.
//             // Assicurati di importare il pacchetto corretto.
//             // Es. 'import 'package:cached_network_image/cached_network_image.dart';'
//             // 'into' è un metodo fornito da CachedNetworkImage o pacchetti simili.
//             // Assicurati di aver importato il pacchetto corretto e averlo aggiunto alle dipendenze.
//             CachedNetworkImage(
//               imageUrl: labelIconUrl,
//               placeholder: (context, url) => CircularProgressIndicator(),
//               errorWidget: (context, url, error) => Icon(Icons.error),
//             );
//           }
//         }
//
//         v.tvLeague.text = "League Name: ${players?.league?.name ?? ''}";
//         // Caricamento dell'immagine della lega usando un pacchetto simile al precedente
//         // Assicurati di aver importato il pacchetto corretto e averlo aggiunto alle dipendenze.
//         CachedNetworkImage(
//           imageUrl: players?.league?.iconUrls?.small ?? '',
//           placeholder: (context, url) => CircularProgressIndicator(),
//           errorWidget: (context, url, error) => Icon(Icons.error),
//         );
//
//         v.tvName.text = "Player name: ${players?.name ?? ''}";
//         v.tvRole.text = "Role: ${players?.role ?? ''}";
//         v.tvTag.text = "Tag: ${players?.tag ?? ''}";
//         v.tvTownHallLevel.text = "Town Hall Level: ${players?.townHallLevel}";
//         v.tvTrophies.text = "Trophies: ${players?.trophies}";
//         v.tvWarStars.text = "War Stars: ${players?.warStars}";
//       } else {
//         holder.v.tvBestTrophies.text = "No player data available";
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   bool isPlayerDataValid(Player? players) {
//     return players != null &&
//         players.bestTrophies != null &&
//         players.bestVersusTrophies != null &&
//         players.builderHallLevel != null &&
//         players.donations != null &&
//         players.donationsReceived != null &&
//         players.expLevel != null &&
//         players.clan != null &&
//         players.labels != null &&
//         players.labels.length >= 3 &&
//         players.league != null &&
//         players.name != null &&
//         players.role != null &&
//         players.tag != null &&
//         players.townHallLevel != null &&
//         players.trophies != null;
//   }
//
//   String parseLabels(List<Label> labelsArray) {
//     return labelsArray.map((label) => label.name).join(', ');
//   }
//
//   List<String> extractSmallUrls(List<Label> labelsArray) {
//     return labelsArray.map((label) => label.iconUrls?.small ?? '').toList();
//   }
//
//   @override
//   CustomViewHolder onCreateViewHolder(parent, viewType) {
//     // TODO: implement onCreateViewHolder
//     throw UnimplementedError();
//   }
// }
//
// class CustomViewHolder {
//   // Puoi definire i membri della classe qui se necessario
// }
//
// class SingleRowBinding {
//   // Puoi definire i membri della classe qui se necessario
// }
//
// class CachedNetworkImage {
//   // Puoi definire i membri della classe qui se necessario
// }
//
// class Label {
//   final IconUrls? iconUrls;
//   final String? name;
//
//   Label({this.iconUrls, this.name});
// }
//
// class IconUrls {
//   final String? small;
//
//   IconUrls({this.small});
// }
