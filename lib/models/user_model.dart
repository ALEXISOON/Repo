class User {
  final String nombre;
  final String apellido;
  final String email;
  final String rol;
  final String ciudad;
  final String area;

  User({
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.rol,
    required this.ciudad,
    required this.area,
  });

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'apellido': apellido,
    'email': email,
    'rol': rol,
    'ciudad': ciudad,
    'area': area,
  };
}
