enum MyWorkmanager {
  oneOff("restaurant", "restaurant"),
  periodic("restaurant-hitz", "restoraurant-hitz");

  final String uniqueName;
  final String taskName;

  const MyWorkmanager(this.uniqueName, this.taskName);
}
