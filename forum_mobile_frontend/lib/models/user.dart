class User{
  int id;

  String username;
  String password ;
  String name;
  String email;
  String dateofbirth;
  String phone ;


  String picture ;
  User({this.id ,this.username,this.phone,this.dateofbirth,this.email,this.name,this.password,this.picture});
  factory User.fromJson(Map<String , dynamic> json){
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      picture: json['picture'],
      name: json['name'],
      email: json['email'],
      dateofbirth: json['dateofbirth'],
      phone: json['phone'],

    );
  }
}