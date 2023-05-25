import 'package:idekiller/controllers/model.dart';
import 'package:uuid/uuid.dart';

class GlobalValues {
  static String language = 'Java';
  static double font = 14;
  static String code = "public class Main {\n  public static void main (String[] args) {\n    System.out.println(\"Hello, World\");\n  }\n}";
  static User user = User(profilePic: '', name: 'Masss', number: '123', students: [], teachers: [], id: 0, about: 'qwe rty');
  static bool isAuthorized = false;
  static String uuid = "";
}