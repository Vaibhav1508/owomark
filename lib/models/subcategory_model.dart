class SubCategory {
  final int id;
  final String title;
  final String description;

  SubCategory({
    this.id,
    this.title,
    this.description,
  });
}

List<SubCategory> subcategories = [
  SubCategory(
    id: 1,
    title: "Mechanical Engg",
    description: 'some description of category Mechanical Engg.',
  ),
  SubCategory(
    id: 2,
    title: "Electrical Engg",
    description: 'some description of category Electrical Engg.',
  ),
  SubCategory(
    id: 3,
    title: "Civil Engg",
    description: 'some description of category Civil Engg.',
  ),
  SubCategory(
    id: 4,
    title: "Computer Engg",
    description: 'some description of category Computer Engg.',
  ),
  SubCategory(
    id: 5,
    title: "BioMedical Engg",
    description: 'some description of category BioMedical Engg.',
  ),
];
