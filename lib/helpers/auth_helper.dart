import 'package:get_storage/get_storage.dart';
import 'package:withschools/models/user.dart';

class AuthHelper {
  final box = GetStorage();

  Future makePrefes(User user) async {
    final box = GetStorage();
    //@user
    box.write('id', user.id.toString());
    box.write('fullName', user.fullName.toString());
    box.write('firstName', user.firstName.toString());
    box.write('lastName', user.lastName.toString());
    box.write('avatar', user.avatar.toString());
    box.write('email', user.email.toString());
    box.write('phoneNumber', user.phoneNumber.toString());
    box.write('guard', user.guard.toString());
    box.write('token', user.token.toString());
    box.write('locale', user.locale.toString());
    //@school
    box.write('lat', user.school?.lat.toString());
    box.write('lng', user.school?.lng.toString());
  }

  // Getter method to retrieve the stored token
  String getToken() {
    return box.read('token') ?? '';
  }

  //Clear box
  Future logout() async {
    final box = GetStorage();
    box.remove('token');
    box.remove('fullname');
    box.remove('locale');
    box.remove('guard');
  }
}
