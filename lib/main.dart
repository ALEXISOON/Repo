import 'package:flutter/material.dart';
import 'package:formulario/models/user_model.dart';
import 'package:formulario/screens/success_screen.dart';
import 'package:formulario/services/mongo_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario de Usuario',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UsuarioForm(),
    );
  }
}

class UsuarioForm extends StatefulWidget {
  @override
  _UsuarioFormState createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  final _formKey = GlobalKey<FormState>();

  String? _nombre;
  String? _apellido;
  String? _email;
  String? _rol;
  String? _ciudad;
  String? _area;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Formulario de Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildDatosPersonales(),
              SizedBox(height: 20),
              _buildRolDropdown(),
              _buildCiudadDropdown(),
              _buildAreaDropdown(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatosPersonales() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Datos Personales',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Nombre'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingrese el nombre';
            }
            return null;
          },
          onSaved: (value) => _nombre = value,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Apellido'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingrese el apellido';
            }
            return null;
          },
          onSaved: (value) => _apellido = value,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingrese el email';
            }
            if (!value.contains('@')) {
              return 'Ingrese un email válido';
            }
            return null;
          },
          onSaved: (value) => _email = value,
        ),
      ],
    );
  }

  Widget _buildRolDropdown() {
    final List<String> roles = ['Gerencia', 'Usuario', 'Procesos'];

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: 'Rol'),
      value: _rol,
      items:
          roles.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
      validator: (value) => value == null ? 'Seleccione un rol' : null,
      onChanged: (newValue) {
        setState(() {
          _rol = newValue;
        });
      },
      onSaved: (value) => _rol = value,
    );
  }

  Widget _buildCiudadDropdown() {
    final List<String> ciudades = [
      'Quito',
      'Calderón',
      'Tumbaco',
      'Pomasqui',
      'Centro Historico',
    ];

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: 'Ciudad'),
      value: _ciudad,
      items:
          ciudades.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
      validator: (value) => value == null ? 'Seleccione una ciudad' : null,
      onChanged: (newValue) {
        setState(() {
          _ciudad = newValue;
        });
      },
      onSaved: (value) => _ciudad = value,
    );
  }

  Widget _buildAreaDropdown() {
    final List<String> areas = [
      'Ventas',
      'Marketing',
      'TI',
      'Recursos Humanos',
      'Operaciones',
    ];

    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: 'Área'),
      value: _area,
      items:
          areas.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
      validator: (value) => value == null ? 'Seleccione un área' : null,
      onChanged: (newValue) {
        setState(() {
          _area = newValue;
        });
      },
      onSaved: (value) => _area = value,
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          // <-- Aquí va tu código
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();

            final user = User(
              nombre: _nombre!,
              apellido: _apellido!,
              email: _email!,
              rol: _rol!,
              ciudad: _ciudad!,
              area: _area!,
            );

            final isSaved = await MongoService.saveUser(user.toJson());

            if (isSaved) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuccessScreen()),
              );
            }
          }
        },
        child: Text('Guardar Usuario'),
      ),
    );
  }
}

//Esta parte muestra una ventana pequeña con la informacion "Guardada" del usuario//
/*void _mostrarDatosGuardados() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Datos del Usuario'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: $_nombre $_apellido'),
              Text('Email: $_email'),
              Text('Rol: $_rol'),
              Text('Ciudad: $_ciudad'),
              Text('Área: $_area'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}*/
