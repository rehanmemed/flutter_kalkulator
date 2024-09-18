import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Login',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo),
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.indigo),
        ),
      ),
      home: LoginPage(),
    );
  }
}

// LoginPage
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final String correctUsername = "rehan";
  final String correctPassword = "123";

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == correctUsername && password == correctPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username atau Password salah')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.account_circle, size: 100, color: Colors.indigo),
                SizedBox(height: 20),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon:
                                Icon(Icons.person, color: Colors.indigo),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(Icons.lock, color: Colors.indigo),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                          ),
                          onPressed: _login,
                          child: Text('Login',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// MenuPage
class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menu Utama")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            _buildMenuCard(
                context, 'Kalkulator', Icons.calculate, CalculatorPage()),
            _buildMenuCard(
                context, 'Cek Ganjil/Genap', Icons.check, GanjilGenapPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
      BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 40, color: Colors.indigo),
              SizedBox(height: 10),
              Text(title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

// Kalkulator
class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _controller = TextEditingController();
  String _input = "";
  String _result = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operation = "";

  void _inputNumber(String number) {
    setState(() {
      _input += number;
      _controller.text = _input;
    });
  }

  void _inputOperation(String operation) {
    setState(() {
      if (_input.isNotEmpty) {
        _num1 = double.tryParse(_input) ?? 0;
        _operation = operation;
        _input = "";
      }
    });
  }

  void _calculateResult() {
    setState(() {
      if (_input.isNotEmpty) {
        _num2 = double.tryParse(_input) ?? 0;
        switch (_operation) {
          case "+":
            _result = (_num1 + _num2).toString();
            break;
          case "-":
            _result = (_num1 - _num2).toString();
            break;
          case "*":
            _result = (_num1 * _num2).toString();
            break;
          case "/":
            _result = _num2 != 0 ? (_num1 / _num2).toString() : "Error";
            break;
          default:
            _result = "Error";
        }
        _input = _result;
        _operation = "";
        _controller.text = _result;
      }
    });
  }

  void _clear() {
    setState(() {
      _input = "";
      _result = "";
      _num1 = 0;
      _num2 = 0;
      _operation = "";
      _controller.clear();
    });
  }

  Widget _buildButton(String text, {Color color = Colors.teal}) {
    return ElevatedButton(
      onPressed: () {
        if (text == "=") {
          _calculateResult();
        } else if (text == "C") {
          _clear();
        } else if (text == "+" || text == "-" || text == "*" || text == "/") {
          _inputOperation(text);
        } else {
          _inputNumber(text);
        }
      },
      child: Text(text, style: TextStyle(fontSize: 20)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kalkulator")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Hasil',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clear,
                ),
              ),
              readOnly: true,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 30, backgroundColor: Colors.orange),
            ),
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: <Widget>[
                _buildButton("7"),
                _buildButton("8"),
                _buildButton("9"),
                _buildButton("/", color: Colors.orange),
                _buildButton("4"),
                _buildButton("5"),
                _buildButton("6"),
                _buildButton("*", color: Colors.orange),
                _buildButton("1"),
                _buildButton("2"),
                _buildButton("3"),
                _buildButton("-", color: Colors.orange),
                _buildButton("0"),
                _buildButton("."),
                _buildButton("=", color: Colors.orange),
                _buildButton("+", color: Colors.orange),
                _buildButton("C", color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Cek Ganjil/Genap
class GanjilGenapPage extends StatefulWidget {
  @override
  _GanjilGenapPageState createState() => _GanjilGenapPageState();
}

class _GanjilGenapPageState extends State<GanjilGenapPage> {
  final TextEditingController _numberController = TextEditingController();
  String _result = "";

  void _checkEvenOdd() {
    setState(() {
      final int number = int.tryParse(_numberController.text) ?? 0;
      _result = number % 2 == 0 ? "Genap" : "Ganjil";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cek Ganjil/Genap")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan angka',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkEvenOdd,
              child: Text('Cek'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
