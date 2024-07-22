class Mechanic {
  final String photoUrl;
  final String name;
  final String status;
  final DateTime dateTime;

  Mechanic({required this.photoUrl, required this.name, required this.status,required this.dateTime});

  Mechanic.john()
      : name = 'John Thompson',
        photoUrl = 'assets/images/john.png',
        status= 'Working',
        dateTime = DateTime.now();
}
