abstract class DbModelBase<T> {
  final T id;
  DbModelBase({required this.id});

  static fromMap(Map<String, dynamic> map) {}

  Map<String, dynamic> toMap() {
    return Map.fromIterable([]);
  }
}
