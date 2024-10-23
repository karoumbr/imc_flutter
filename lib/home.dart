import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Saisir données";
  double _imc = 0.0;
  Color _textColor = Colors.white;
  bool _notZero = false;

  void _resetFields(){
    weightController.text ="";
    heightController.text ="";
    setState(() {
      _infoText = "";
      _formKey = GlobalKey<FormState>();
      _notZero = false;
    });
  }
/*void _calculerIMC(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      _imc = weight / (height * height);
      _notZero = true;
      if (_imc <18.5){
        _infoText = "Insuffisance pondérale";
        _textColor = Colors.pink;
      } else if(_imc >=18.5 && _imc <24.9){
        _infoText = "Poids normal";
        _textColor = Colors.green;
      } else if(_imc >=25 && _imc <29.9){
        _infoText = "Surpoids";
        _textColor = Colors.orange;
      }else {
        _infoText = "Obésité";
        _textColor = Colors.red;
      }
    });
}*/
  void _calculerIMC() {
    setState(() {
      String weightText = weightController.text;
      String heightText = heightController.text;

      if (weightText.isEmpty || heightText.isEmpty) {
        _infoText = "Saisir les deux valeurs";
        _textColor = Colors.red;
        _notZero = false;
        return;
      }

      try {
        double weight = double.parse(weightText);
        double height = double.parse(heightText);

        if (height == 0 || weight == 0) {
          _infoText = "Les valeurs ne peuvent pas être zéro";
          _textColor = Colors.red;
          _notZero = false;
          return;
        }

        _imc = weight / (height * height);
        _notZero = true;

        if (_imc < 18.5) {
          _infoText = "Insuffisance pondérale";
          _textColor = Colors.pink;
        } else if (_imc >= 18.5 && _imc < 24.9) {
          _infoText = "Poids normal";
          _textColor = Colors.green;
        } else if (_imc >= 25 && _imc < 29.9) {
          _infoText = "Surpoids";
          _textColor = Colors.orange;
        } else {
          _infoText = "Obésité";
          _textColor = Colors.red;
        }
      } catch (e) {
        _infoText = "Entrée invalide";
        _textColor = Colors.red;
        _notZero = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IMC"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget> [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Poids", style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 20,
                  ),),
                  Expanded(child: Container(
                    margin: const EdgeInsets.fromLTRB(30, 30, 10, 10),
                    decoration: BoxDecoration(
                      boxShadow: [
                      BoxShadow(
                        color:  Colors.grey.withOpacity(0.3),
                        spreadRadius: 0.2,
                        blurRadius: 1,
                        offset: const Offset(1, 3),
                      ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(50.0),)
                    ),
                    child: TextFormField(keyboardType: TextInputType.number,textAlign: TextAlign.right,
                    controller: weightController,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Saisir poids.';
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      hintText: "00.0",
                      hintStyle: const TextStyle(fontSize: 18.0, color: Colors.black26),
                      suffixIcon: const Text(
                      'KG',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color:Colors.lightBlueAccent,
                      ),
                    ),
                      border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: const BorderSide(width:0,style: BorderStyle.none,)
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    ),
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Taille", style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 20,
                  ),),
                  Expanded(child: Container(
                    margin: const EdgeInsets.fromLTRB(30, 30, 10, 10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:  Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.2,
                            blurRadius: 1,
                            offset: const Offset(1, 3),
                          ),
                        ],
                        borderRadius: const BorderRadius.all(Radius.circular(50.0),)
                    ),
                    child: TextFormField(keyboardType: TextInputType.number,textAlign: TextAlign.right,
                      controller: heightController,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Saisir taille.';
                        }
                      },

                      decoration: InputDecoration(
                        contentPadding:
                        const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        hintText: "00.0",
                        hintStyle: const TextStyle(fontSize: 18.0, color: Colors.black26),
                        suffixIcon: const Text(
                          'M',
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color:Colors.lightBlueAccent,
                          ),
                        ),
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(width:0,style: BorderStyle.none,)
                        ),
                        fillColor: Colors.white,
                        filled: true,

                      ),



                    ),
                  ))
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _calculerIMC();
                    }
                  },
                  child: const Padding(padding: EdgeInsets.all(10.0),
                  child: Text("Calculer", style: TextStyle(fontSize: 20),),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.lightBlueAccent),
                ),
              ),
              Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Vous êtes ",
                      style: TextStyle(color: Colors.black26, fontSize: 18),),),
                   Padding(padding: const EdgeInsets.all(16.0),
                      child: Text(_infoText, style: TextStyle(color: _textColor , fontSize: 24),),),
       // child: Text("Message ", style: TextStyle(color: Colors.black, fontSize: 24),),),
      ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
