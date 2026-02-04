import 'package:flutter_nv1/models/post_model.dart'; // Importe seu model Post

// Contrato (Interface)
abstract class HomeRepository {
  Future<List<Post>> getList();
}