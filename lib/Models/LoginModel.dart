class LoginModel {
  bool? status;
  String? message;
  UserData? data;
  LoginModel.profiledata(d){
    status= d['status'];
    message = d['message'];
    data = d['data'] != null ? UserData.profiledata(d['data']):null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? point;
  int? credit;
  String? token;

  UserData.profiledata(d){
    id= d['id'];
    email = d['email'];
    credit = d['credit'];
    image = d['image'];
    name = d['name'];
    phone = d['phone'];
    point = d['point'];
    token = d['token'];
  }
}
