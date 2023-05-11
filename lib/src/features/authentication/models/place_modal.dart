class PlaceInfo {
  final String location, image, name, desc;
  final int distance, days;

  PlaceInfo({
    required this.location,
    required this.image,
    required this.name,
    required this.desc,
    required this.distance,
    required this.days,
  });
}

List places = [
  PlaceInfo(
      location: 'India',
      image: 'images/Cinque-Terre-Italy.jpeg',
      name: 'Cinque Terre ',
      desc:
          "Cinque Terre's easternmost village, Riomaggiore is the largest of the five and acts as its unofficial headquarters. Its peeling pastel buildings march down a steep ravine to a tiny harbor - the region's favorite postcard view - and glow romantically at sunset, which is best appreciated from the sea. A botanical garden and bird watching center sits on a rocky promontory up the hill from the pebbly Fossola Beach.",
      distance: 22500,
      days: 7),
  PlaceInfo(
      location: 'Japan',
      image: 'images/Kyoto-Japan.jpeg',
      name: 'Kyoto ',
      desc:
          "Kyoto is one of the oldest municipalities in Japan, having been chosen in 794 as the new seat of Japan's imperial court by Emperor Kanmu. The original city, named Heian-kyō, was arranged in accordance with traditional Chinese feng shui following the model of the ancient Chinese capital of Chang'an / Luoyang.",
      distance: 55000,
      days: 12),
  PlaceInfo(
      location: 'India',
      image: 'images/Galapagos-Islands.jpeg',
      name: 'Galapagos Islands',
      desc:
          "The Galápagos Islands are an archipelago, or group of islands, that have been created by volcanoes. They are found in the Pacific Ocean, almost 1,000 km west from the coast of Ecuador in South America. The islands are at either side of the Equator, which means they are in both the Southern and the Northern Hemisphere.",
      distance: 12500,
      days: 17),
  PlaceInfo(
      location: 'Mexico',
      image: 'images/sea.webp',
      name: 'Sea ',
      desc:
          "The Red Sea contains some of the world’s hottest and saltiest seawater. With its connection to the Mediterranean Sea via the Suez Canal, it is one of the most heavily traveled waterways in the world, carrying maritime traffic between Europe and Asia. Its name is derived from the colour changes observed in its waters.",
      distance: 77500,
      days: 27),
];
