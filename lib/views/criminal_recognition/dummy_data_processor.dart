import 'dart:math';

class Criminal {
  final String name;
  final String gender;
  final String dob;
  final String charge;
  final String location;
  final String imageUrl;

  Criminal({
    required this.name,
    required this.gender,
    required this.dob,
    required this.charge,
    required this.location,
    required this.imageUrl,
  });
}

List<String> maleNames = [
  "John Doe",
  "James Smith",
  "Robert Johnson",
  "Michael Williams",
  "David Brown",
];

List<String> femaleNames = [
  "Jane Doe",
  "Emily Davis",
  "Mary Wilson",
  "Patricia Martinez",
  "Linda Anderson",
];

List<String> charges = [
  "Robbery",
  "Assault",
  "Drug Trafficking",
  "Fraud",
  "Burglary",
];

List<String> locations = [
  "New York, NY",
  "Los Angeles, CA",
  "Chicago, IL",
  "Houston, TX",
  "Miami, FL",
];

List<String> maleImages = [
  "https://randomuser.me/api/portraits/men/1.jpg",
  "https://randomuser.me/api/portraits/men/2.jpg",
  "https://randomuser.me/api/portraits/men/3.jpg",
  "https://randomuser.me/api/portraits/men/4.jpg",
  "https://randomuser.me/api/portraits/men/5.jpg",
];

List<String> femaleImages = [
  "https://randomuser.me/api/portraits/women/1.jpg",
  "https://randomuser.me/api/portraits/women/2.jpg",
  "https://randomuser.me/api/portraits/women/3.jpg",
  "https://randomuser.me/api/portraits/women/4.jpg",
  "https://randomuser.me/api/portraits/women/5.jpg",
];

String generateRandomDateOfBirth(int minAge) {
  final random = Random();
  final currentYear = 2024;
  final year = currentYear -
      (minAge +
          random.nextInt(
              50)); // Generates age between minAge and up to 50 years older
  final month = 1 + random.nextInt(12);
  final day = 1 + random.nextInt(28); // Simplified to ensure valid dates

  return '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
}

List<Criminal> generateDummyCriminals(int count) {
  final random = Random();
  List<Criminal> criminals = [];

  for (int i = 0; i < count; i++) {
    bool isMale = random.nextBool();
    String name = isMale
        ? maleNames[random.nextInt(maleNames.length)]
        : femaleNames[random.nextInt(femaleNames.length)];
    String gender = isMale ? 'Male' : 'Female';
    String dob = generateRandomDateOfBirth(18);
    String charge = charges[random.nextInt(charges.length)];
    String location = locations[random.nextInt(locations.length)];
    String imageUrl = isMale
        ? maleImages[random.nextInt(maleImages.length)]
        : femaleImages[random.nextInt(femaleImages.length)];

    criminals.add(Criminal(
      name: name,
      gender: gender,
      dob: dob,
      charge: charge,
      location: location,
      imageUrl: imageUrl,
    ));
  }

  return criminals;
}

Criminal getRandomCriminal() {
  return generateDummyCriminals(1)[0];
}
