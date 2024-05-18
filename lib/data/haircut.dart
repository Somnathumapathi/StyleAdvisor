// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Gender { male, female }

class Haircut {
  final String shape;
  final String haircutName;
  final String imgUrl;
  final Gender gen;
  final String description;
  Haircut(
      {required this.shape,
      required this.haircutName,
      required this.imgUrl,
      required this.gen,
      required this.description});
}

// Map<String, dynamic> toMap() {
//   return <String, dynamic>{
//     'shape': shape,
//     'haircutName': haircutName,
//     'imgUrl': imgUrl,
//   };
// }

// factory Haircut.fromMap(Map<String, dynamic> map) {
//   return Haircut(
//     shape: map['shape'] as String,
//     haircutName: map['haircutName'] as String,
//     imgUrl: map['imgUrl'] as String,
//     gen: ma
//   );
// }

// String toJson() => json.encode(toMap());

// factory Haircut.fromJson(String source) =>
//     Haircut.fromMap(json.decode(source) as Map<String, dynamic>);
// }

List<Haircut> maleHaircutsSquare = [
  Haircut(
    shape: 'Square',
    haircutName: 'Crew Cut',
    imgUrl: 'https://example.com/crew-cut-square.jpg',
    gen: Gender.male,
    description: 'A classic crew cut for a sharp look.',
  ),
  Haircut(
    shape: 'Square',
    haircutName: 'Buzz Cut',
    imgUrl: 'https://example.com/buzz-cut-square.jpg',
    gen: Gender.male,
    description: 'A simple and clean buzz cut.',
  ),
  Haircut(
    shape: 'Square',
    haircutName: 'Pompadour',
    imgUrl: 'https://example.com/pompadour-square.jpg',
    gen: Gender.male,
    description: 'A stylish pompadour for a modern look.',
  ),
];

List<Haircut> femaleHaircutsSquare = [
  Haircut(
    shape: 'Square',
    haircutName: 'Layered Bob',
    imgUrl: 'https://example.com/layered-bob-square.jpg',
    gen: Gender.female,
    description: 'A layered bob for a sophisticated look.',
  ),
  Haircut(
    shape: 'Square',
    haircutName: 'Blunt Cut',
    imgUrl: 'https://example.com/blunt-cut-square.jpg',
    gen: Gender.female,
    description: 'A blunt cut for a bold statement.',
  ),
  Haircut(
    shape: 'Square',
    haircutName: 'Asymmetrical Lob',
    imgUrl: 'https://example.com/asymmetrical-lob-square.jpg',
    gen: Gender.female,
    description: 'An asymmetrical lob for a trendy look.',
  ),
];

List<Haircut> maleHaircutsRound = [
  Haircut(
    shape: 'Round',
    haircutName: 'Faux Hawk',
    imgUrl: 'https://example.com/faux-hawk-round.jpg',
    gen: Gender.male,
    description: 'A faux hawk for a daring style.',
  ),
  Haircut(
    shape: 'Round',
    haircutName: 'High and Tight',
    imgUrl: 'https://example.com/high-tight-round.jpg',
    gen: Gender.male,
    description: 'A high and tight cut for a clean look.',
  ),
  Haircut(
    shape: 'Round',
    haircutName: 'Side Part',
    imgUrl: 'https://example.com/side-part-round.jpg',
    gen: Gender.male,
    description: 'A classic side part for a polished appearance.',
  ),
];

List<Haircut> femaleHaircutsRound = [
  Haircut(
    shape: 'Round',
    haircutName: 'Pixie Cut',
    imgUrl: 'https://example.com/pixie-cut-round.jpg',
    gen: Gender.female,
    description: 'A chic pixie cut for a modern look.',
  ),
  Haircut(
    shape: 'Round',
    haircutName: 'Layered Shag',
    imgUrl: 'https://example.com/layered-shag-round.jpg',
    gen: Gender.female,
    description: 'A layered shag for a playful style.',
  ),
  Haircut(
    shape: 'Round',
    haircutName: 'Angular Bob',
    imgUrl: 'https://example.com/angular-bob-round.jpg',
    gen: Gender.female,
    description: 'An angular bob for a contemporary look.',
  ),
];

List<Haircut> maleHaircutsOval = [
  Haircut(
    shape: 'Oval',
    haircutName: 'Quiff',
    imgUrl: 'https://example.com/quiff-oval.jpg',
    gen: Gender.male,
    description: 'A quiff for a stylish and modern look.',
  ),
  Haircut(
    shape: 'Oval',
    haircutName: 'Undercut',
    imgUrl: 'https://example.com/undercut-oval.jpg',
    gen: Gender.male,
    description: 'An undercut for a bold and edgy style.',
  ),
  Haircut(
    shape: 'Oval',
    haircutName: 'Slick Back',
    imgUrl: 'https://example.com/slick-back-oval.jpg',
    gen: Gender.male,
    description: 'A slick back for a sleek appearance.',
  ),
];

List<Haircut> femaleHaircutsOval = [
  Haircut(
    shape: 'Oval',
    haircutName: 'Long Layers',
    imgUrl: 'https://example.com/long-layers-oval.jpg',
    gen: Gender.female,
    description: 'Long layers for a versatile and elegant style.',
  ),
  Haircut(
    shape: 'Oval',
    haircutName: 'Side-Swept Bangs',
    imgUrl: 'https://example.com/side-swept-bangs-oval.jpg',
    gen: Gender.female,
    description: 'Side-swept bangs for a soft and feminine look.',
  ),
  Haircut(
    shape: 'Oval',
    haircutName: 'Classic Pixie',
    imgUrl: 'https://example.com/classic-pixie-oval.jpg',
    gen: Gender.female,
    description: 'A classic pixie cut for a chic and modern style.',
  ),
];

List<Haircut> maleHaircutsHeart = [
  Haircut(
    shape: 'Heart',
    haircutName: 'Textured Crop',
    imgUrl: 'https://example.com/textured-crop-heart.jpg',
    gen: Gender.male,
    description: 'A textured crop for a stylish and trendy look.',
  ),
  Haircut(
    shape: 'Heart',
    haircutName: 'Fringe',
    imgUrl: 'https://example.com/fringe-heart.jpg',
    gen: Gender.male,
    description: 'A fringe cut for a contemporary style.',
  ),
  Haircut(
    shape: 'Heart',
    haircutName: 'Short Pompadour',
    imgUrl: 'https://example.com/short-pompadour-heart.jpg',
    gen: Gender.male,
    description: 'A short pompadour for a modern and sleek appearance.',
  ),
];

List<Haircut> femaleHaircutsHeart = [
  Haircut(
    shape: 'Heart',
    haircutName: 'Curtain Bangs',
    imgUrl: 'https://example.com/curtain-bangs-heart.jpg',
    gen: Gender.female,
    description: 'Curtain bangs for a soft and flattering style.',
  ),
  Haircut(
    shape: 'Heart',
    haircutName: 'Layered Lob',
    imgUrl: 'https://example.com/layered-lob-heart.jpg',
    gen: Gender.female,
    description: 'A layered lob for a sophisticated and trendy look.',
  ),
  Haircut(
    shape: 'Heart',
    haircutName: 'Textured Waves',
    imgUrl: 'https://example.com/textured-waves-heart.jpg',
    gen: Gender.female,
    description: 'Textured waves for a beachy and relaxed style.',
  ),
];
