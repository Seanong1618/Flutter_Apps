import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/successfulLogin.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Declarations
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool isRememberMe = false;

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Text(
          'Username',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0,2)
                )
              ]
          ),
          height: 60,
          child: TextField(
            controller: usernameController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.black87
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top:14),
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xfffc4e03),
                ),
                hintText: 'Email',
                hintStyle: TextStyle(
                    color: Colors.black38
                )
            ),
          ),
        )
      ],
    );
  }
  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Text(
          'Password',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0,2)
                )
              ]
          ),
          height: 60,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
                color: Colors.black87
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top:14),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xfffc4e03),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                    color: Colors.black38
                )
            ),
          ),
        )
      ],
    );
  }
  Widget buildForgetPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print("Forgot Password is pressed"),
        child: Text(
          'Forget Password?',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
  Widget buildRememberCb() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget> [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.red,
              activeColor: Colors.white,
              onChanged: (value){
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        child: Text('LOGIN'),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.redAccent,
            shadowColor: Colors.grey,
            elevation: 5,
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            shape: const BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )
        ),
        onPressed: (){
          print('Pressed');
          //start the logic here
          //set variables for the user input
          String usernameHolder = usernameController.text;
          String passwordHolder = passwordController.text;
          //check the user input
          print("Username is: $usernameHolder");
          print("Password is: $passwordHolder");
          login(usernameHolder,passwordHolder);
        },
      ),
    );
  }
  //Create function for login post api
  Future<void> login(String username, String password) async{
    if (!username.isEmpty && !password.isEmpty){
     var response = await http.post(Uri.parse("https://tnbti01.teravibe.com:9955/login/"),
         body:({
           'email':usernameController.text,
           'password':passwordController.text
         }));
     if(response.statusCode==200){
       //successful login
       print("Successfu Login");
       Navigator.push(context, MaterialPageRoute(builder: (context) => successfulLogin()));
     }else{
       print("Invalid Credentials!");
       showDialog(
         context: context,
         builder: (context) => AlertDialog(
           title: Text("Alert!"),
           content: Text("Invalid Credentials."),
           actions: [
             TextButton(
               onPressed: (){
                 print("Closed is Selected");
                 Navigator.pop(context);
               },
               child: Text("Close"),
             ),
           ],
         ),
       );
     }
    }else{
      print("Field is Empty");
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Text("Alert!"),
              content: Text("Field is Empty!"),
            actions: [
              TextButton(
                  onPressed: (){
                    print("Closed is Selected");
                    Navigator.pop(context);
                  },
                  child: Text("Close"),
              ),
            ],
          ),
      );
    }

  }
  Widget buildSignUpBt() {
    return GestureDetector(
      onTap: () => print("Sign Up Pressed"),
      child: RichText(
        text: TextSpan(
            children: [
              TextSpan(
                text: "Don\'t have an Account?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500
                ),
              ),
              TextSpan(
                text: ' Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
        ),
      ),
    );
  }
  Widget buildCreator() {
    return Column(
      children: const [
        Text(
          'Made by Sean Somera with Flutter',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget> [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x66fc4e03),
                          Color(0x99fc4e03),
                          Color(0xccfc4e03),
                          Color(0xfffc4e03),
                        ]
                    )
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 120
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Image.asset('assets/loginIcon.png',
                        height: 150,
                      ),

                      buildEmail(),
                      SizedBox(height: 30),
                      buildPassword(),
                      //forget password
                      buildForgetPassBtn(),
                      buildRememberCb(),
                      buildLoginBtn(),
                      buildSignUpBt(),
                      SizedBox(height: 50),
                      buildCreator(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}