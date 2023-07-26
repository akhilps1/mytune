abstract class IFirebaseServeice<T> {
  Future<void> getDetialsFromFirebase();
  Future<void> addDetailsToFireBase({required T model});
  Future<void> updateDetialsFromFirebase({required T model});
  Future<void> deleteDetailsFromFireBae({required T model});
}
