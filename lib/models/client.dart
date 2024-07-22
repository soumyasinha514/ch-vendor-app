class Client {
  final String photoUrl;
  final String name;
  final String address;

  Client({required this.photoUrl, required this.name, required this.address});

  Client.charlie()
      : name = 'Charlie Puth',
        photoUrl = 'assets/images/charlie.png',
        address = 'G-sector, Treasure Fantasy, Indore';
}
