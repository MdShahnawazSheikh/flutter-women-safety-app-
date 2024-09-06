import 'dart:math';

class Criminal {
  final String name;
  final String gender;
  // final String dob;
  final String id;
  final String charge;
  // final String location;
  final String imageUrl;

  Criminal({
    required this.name,
    required this.gender,
    // required this.dob,
    required this.id,
    required this.charge,
    // required this.location,
    required this.imageUrl,
  });
}

List<Criminal> getCriminals() {
  return [
    Criminal(
      name: "Pruthvi",
      gender: "Male",
      charge: "Burglary",
      imageUrl: "lib/res/criminals/pruthvi.jpeg",
      id: "785947",
    ),
    Criminal(
      name: "Ateesh",
      gender: "Male",
      charge: "Drink & Drive",
      imageUrl: "lib/res/criminals/Ateesh.jpeg",
      id: "768598",
    ),
    Criminal(
      name: "Ranjita",
      gender: "Female",
      charge: "No History",
      imageUrl: "lib/res/criminals/Ranjita.jpeg",
      id: "938482",
    ),
    Criminal(
      name: "Gagn",
      gender: "Male",
      charge: "Arson",
      imageUrl: "lib/res/criminals/Gagn.jpeg",
      id: "927382",
    ),
    Criminal(
      name: "Prajwal",
      gender: "Male",
      charge: "BreakIn",
      imageUrl: "lib/res/criminals/Prajwal.jpeg",
      id: "674850",
    ),
    Criminal(
      name: "Manoj",
      gender: "Male",
      charge: "Burglary",
      imageUrl: "lib/res/criminals/Manoj.jpeg",
      id: "628378",
    ),
  ];
}
