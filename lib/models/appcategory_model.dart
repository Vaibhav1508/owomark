class AppCategory {
  final int id;
  final String title;
  final String description;

  AppCategory({
    this.id,
    this.title,
    this.description,
  });
}

List<AppCategory> categories = [
  AppCategory(
    id: 1,
    title: "Mechanical Engg",
    description: 'some description of category Mechanical Engg.',
  ),
  AppCategory(
    id: 2,
    title: "Electrical Engg",
    description: 'some description of category Electrical Engg.',
  ),
  AppCategory(
    id: 3,
    title: "Civil Engg",
    description: 'some description of category Civil Engg.',
  ),
  AppCategory(
    id: 4,
    title: "Computer Engg",
    description: 'some description of category Computer Engg.',
  ),
  AppCategory(
    id: 5,
    title: "BioMedical Engg",
    description: 'some description of category BioMedical Engg.',
  ),
];
