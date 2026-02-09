import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  // Chave usada para salvar os dados no disco
  static const String _key = 'key';

  // Salva o usuário (transformando em String JSON)
  static Future<void> save(String user) async {
    var prefs = await SharedPreferences.getInstance();

    // Cria um mapa simples para salvar (simulando um token ou user data)
    // No vídeo ele salva o objeto inteiro, aqui simplificamos para didática
    await prefs.setString(
      _key,
      jsonEncode({"user": user, "isAuth": true}),
    );
  }

  // Verifica se o usuário está logado
  static Future<bool> isAuth() async {
    var prefs = await SharedPreferences.getInstance();

    // Recupera a string salva
    var jsonResult = prefs.getString(_key);

    if (jsonResult != null) {
      // Decodifica o JSON
      var mapUser = jsonDecode(jsonResult);
      return mapUser['isAuth'] ?? false;
    }

    return false;
  }

  // Faz o Logout (remove os dados do disco)
  static Future<void> logout() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}