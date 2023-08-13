import 'dart:async';

import 'package:annapurna_finance/AppImages.dart';
import 'package:annapurna_finance/api_factory/prefs/pref_utils.dart';
import 'package:annapurna_finance/constants.dart';

import 'package:annapurna_finance/login/login_view.dart';
import 'package:annapurna_finance/notifier/providers.dart';
import 'package:annapurna_finance/utils/strings.dart';
import 'package:annapurna_finance/utils/theme_config.dart';
import 'package:annapurna_finance/widgets/ab_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class forgotPasswordPage extends ConsumerStatefulWidget {
  const forgotPasswordPage({Key? key}) : super(key: key);

  @override
  ConsumerState<forgotPasswordPage> createState() => _forgotPasswordPageState();
}

class _forgotPasswordPageState extends ConsumerState<forgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController UserId = TextEditingController();
  TextEditingController MobileNumber = TextEditingController();
  OtpFieldController  OTP= OtpFieldController();
  String otp="";
  String otpText=Strings.sendOTP;
  bool kvisible=false;
  // recording fieldInput
  String? inputtedValue;
  bool userInteracts() => inputtedValue != null;
  int secondsRemaining = 0;
  bool enableResend = false;
  Timer? timer;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    ref.watch(authenticationProvider).noofotpsend=3;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
    print("====${enableResend}");
  }
  void _resendCode() {
    if(ref.watch(authenticationProvider).noofotpsend==0)
      {
        myDialog(context,"assets/alert.png", "Maximum Attempt Reached.\n Please try after a while","Okay", 270, 200,press:(){
          Navigator.pop(context);
        });

      }
    else
      {
        if (_formKey.currentState!.validate()) {
          FocusManager.instance.primaryFocus?.unfocus();
          ref.watch(authenticationProvider).sendotpAPI(
            context: context,
            userName: UserId.text,
            MobileNumber : MobileNumber.text,
          );
        }
        setState((){
          secondsRemaining = 10;
          enableResend = false;
        });
      }

  }
  @override
  dispose(){
    timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double theight=MediaQuery.of(context).size.height;
    double twidth=MediaQuery.of(context).size.width;
    double statusbar=MediaQuery.of(context).padding.top;
    double navbar=MediaQuery.of(context).padding.bottom;
    double bheight=theight-statusbar-navbar;
    return Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Image.asset(AppImages.waveOne, width: 300),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Image.asset(AppImages.waveTwo),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Center(child: Image.asset(AppImages.logo, width: 250)),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                                    height: bheight*0.75,
                                    width: twidth*0.85,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black,
                                            width: 3
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(20))
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 31.0, left: defaultPadding, bottom: 10),
                                          child: Text('Forgot Password',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        ABTextInput(
                                          autoValidator: AutovalidateMode.onUserInteraction,
                                          titleText: 'Employee ID',
                                          controller: UserId,
                                          textInputType: TextInputType.phone,
                                          validator: (value) {
                                            if (inputtedValue != null && (value == null || value.isEmpty)) {
                                              return 'Please enter Employee ID';
                                            }return null;
                                          },
                                          onChange: (value) => setState(() => inputtedValue = value),
                                          hintText: 'Enter Employee ID',
                                        ),
                                        SizedBox(height: bheight*0.01,),
                                        ABTextInput(
                                          controller: MobileNumber,
                                          customInputFormatters: [
                                            LengthLimitingTextInputFormatter(10)
                                          ],
                                          textInputType: TextInputType.phone,
                                          autoValidator: AutovalidateMode.onUserInteraction,
                                          titleText: 'Registered Mobile Number',
                                          validator: (value) {
                                            if (inputtedValue != null && (value == null || value.isEmpty)) {
                                              return 'Please enter Phone number';
                                            }return null;
                                          },
                                          onChange: (value) => setState(() => inputtedValue = value),
                                          hintText: 'Enter No.',
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: bheight*0.025,bottom: bheight*0.01,right: defaultPadding),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(onTap: enableResend ? ()  {

                                                _resendCode();

                                               }: null,
                                                child:!ref.watch(authenticationProvider).otpsend? Text("Send OTP",style: TextStyle(decoration: TextDecoration.underline,color: ThemeColor.primary),):
                                                Text("Resend OTP in $secondsRemaining seconds",style: TextStyle(decoration: TextDecoration.underline,color: ThemeColor.primary),),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: bheight*0.02,right: defaultPadding),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              InkWell(child: Text("(${ref.watch(authenticationProvider).noofotpsend} Attempts left)",))
                                            ],
                                          ),
                                        ),
                                        Padding( padding: EdgeInsets.only(left: defaultPadding),child: InkWell(child: Text("OTP",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),),
                                        SizedBox(height: bheight*0.01,),
                                        OTPTextField(
                                          controller: OTP,
                                          margin: EdgeInsets.symmetric(horizontal: 1),
                                          // contentPadding: ,
                                          length: 6,

                                          otpFieldStyle: OtpFieldStyle(
                                            borderColor: ThemeColor.primary,
                                            enabledBorderColor: ThemeColor.primary,
                                            focusBorderColor: ThemeColor.primary
                                          ),
                                          width: MediaQuery.of(context).size.width,
                                          fieldWidth: twidth*0.1090,
                                          style: TextStyle(
                                              fontSize: bheight*0.03
                                          ),
                                          textFieldAlignment: MainAxisAlignment.center,
                                          fieldStyle: FieldStyle.box,
                                          onCompleted: (pin) async {
                                            setState(() {
                                              otp=pin;
                                            });
                                            if (_formKey.currentState!.validate()) {
                                              FocusManager.instance.primaryFocus?.unfocus();
                                              ref.watch(authenticationProvider).OTPVerificationAPI(
                                                context: context,
                                                Phoneno : MobileNumber.text,
                                                userName: UserId.text,
                                                OTPNO : pin,
                                              );
                                            }
                                            print("Completed: " + pin);
                                          },
                                        ),
                                        SizedBox(height: bheight*0.01,),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                                          child: Text("(Please enter verification code sent on your number)",style: TextStyle(fontSize: bheight*0.013),),
                                        ),
                                        SizedBox(height: bheight*0.02,),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                                                  onPressed: (!userInteracts() || _formKey.currentState == null || !_formKey.currentState!.validate()) ? null :() {
                                                    ref.watch(authenticationProvider).OTPVerificationAPI(
                                                      context: context,
                                                      Phoneno : MobileNumber.text,
                                                      userName: UserId.text,
                                                      OTPNO : otp,
                                                    );
                                                  }, child: Text("Verify & Next")),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  side: BorderSide(color: Colors.deepPurple,width: 2)
                                              ),
                                              onPressed: () async {

                                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView(),));
                                              },
                                              child: Text("Back to Login",style: TextStyle(color: Colors.deepPurple)),
                                            ))
                                          ],
                                        )
                                      ],
                                    )
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
            ),
          ),
        )
    );
  }
}
myDialog(BuildContext context,String image,String text,String buttonText,double height,double width,{press}){
  showDialog(context: context, builder: (context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Container(
        height: height,
        width: width,
        decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(image,height: 70,width: 70,),
            Text("${text}",textAlign: TextAlign.center,),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding,right: defaultPadding),
                    child: OutlinedButton(onPressed: press, style:  OutlinedButton.styleFrom(
                      side: BorderSide(color: ThemeColor.primary),
                    ),child: Text("${buttonText}",style: TextStyle(color: ThemeColor.primary),)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  },);
}