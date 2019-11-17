class Notifications {
  final int id;
  final String title;
  final String description;

  Notifications({
    this.id,
    this.title,
    this.description,
  });
}

List<Notifications> notifications = [
  Notifications(
    id: 1,
    title: "Notification 1",
    description: 'some description of Notification 1.',
  ),
  Notifications(
    id: 2,
    title: "Notification 2",
    description: 'some description of Notification 2.',
  ),
  Notifications(
    id: 3,
    title: "Notification 3",
    description: 'some description of Notification 3.',
  ),


];
