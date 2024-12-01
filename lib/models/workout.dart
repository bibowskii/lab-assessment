class workout {
  String name;
  String ID;
  String UID;
  DateTime dateTime;
  bool isDone; // Default status is Not Done (false)

  workout({
    required this.dateTime,
    required this.name,
    required this.ID,
    required this.UID,
    this.isDone = false, // Default value for status is false (Not Done)
  });
}
