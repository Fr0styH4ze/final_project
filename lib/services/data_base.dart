import 'package:supabase_flutter/supabase_flutter.dart';
class DataBase {
final supabase = Supabase.instance.client;

signup({required String email, required String password})async{
await supabase.auth.signUp(
  email: email,
  password: password,
);}
login({required String email, required String password})async{
  await supabase.auth.signInWithPassword(
  email: email,
  password: password,
);
}
}