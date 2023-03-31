class FirebaseCustomException{
  final String description;

  FirebaseCustomException(this.description);

  @override
  String toString() {
    return '$this $description';
  }
}