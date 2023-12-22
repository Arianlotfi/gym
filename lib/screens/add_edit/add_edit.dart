// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:project_badanvv/main.dart';
import 'package:project_badanvv/models/users.dart';
import 'package:project_badanvv/translations/locale_keys.g.dart';


class addoredit extends StatefulWidget {
   addoredit({
    super.key,
    required this.user
  });
 User user;
 
 
  @override
  State<addoredit> createState() => _addoreditState();
}

class _addoreditState extends State<addoredit> {
   Jalali? rigesterdate;
   Jalali? endDate;
   final TextEditingController fullnamecontroller = TextEditingController();
   final TextEditingController phonecontroller = TextEditingController();
   final TextEditingController pricecontroller = TextEditingController();
   final TextEditingController rigesterdateconroller= TextEditingController();
   final TextEditingController enddatecontroller = TextEditingController();
   ValueNotifier<int> radios = ValueNotifier(0);
   final formkey = GlobalKey<FormState>();
   var box = Hive.box<User>(userboxname);
   @override
   void initState(){
    if(widget.user.isInBox){
      fullnamecontroller.text = widget.user.fullnam.toString();
      phonecontroller.text = widget.user.phone.toString();
      pricecontroller.text = widget.user.price.toString();
      rigesterdateconroller.text = widget.user.rigesterdate!;
      radios.value = widget.user.radios!;
      enddatecontroller.text = widget.user.endDate!;
    }

     super.initState();
   

   }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.onTertiary,
      ),
      body: SafeArea(
        child: Container(padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 100.0),
          child: Form(
            key:formkey ,
            child: Column(
              children: [
                SizedBox(height: 25.0,),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset('assets/icons/logo.png')),
                  SizedBox(height: 15.0,),
                  Text(LocaleKeys.vesam_gym.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,),
                  SizedBox(height: 15.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/add_user.svg',
                      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSecondary,BlendMode.srcIn),),
                      SizedBox(width: 8.0,),
                      Text(LocaleKeys.add_user.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,)
                    ],
                  ),
                  SizedBox(height: 30.0,),
                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return LocaleKeys.error_textfield_fullname.tr();
                      }
                      return null;
                    },
                    controller: fullnamecontroller,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.fullname.tr(),
                      hintStyle: Theme.of(context).textTheme.bodySmall
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return LocaleKeys.error_textfield_phone.tr();
                      }
                      return null;
                    },

                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: phonecontroller,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.phone.tr(),
                      hintStyle: Theme.of(context).textTheme.bodySmall
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return LocaleKeys.error_textfield_price.tr();
                      }
                      return null;
                    },
                    controller: pricecontroller,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.price.tr(),
                      hintStyle: Theme.of(context).textTheme.bodySmall
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return LocaleKeys.error_textfield_registerDate.tr();
                      }
                      return null;
                    },
                    controller: rigesterdateconroller,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical:8.0),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: ()async{
                            Jalali? rigesterdate= await showPersianDatePicker(
                             context: context,
                             initialDate: Jalali.now(),
                             firstDate: Jalali(1385, 8),
                              lastDate: Jalali(1450, 9),
                                                      );
                              rigesterdateconroller.text = rigesterdate?.formatCompactDate()??''; 
                               switch (radios.value) {
                                  case 0:
                                   endDate = rigesterdate?.addDays(15);
                                   break;
                                   case 1:
                                  endDate = rigesterdate?.addMonths(1);
                                   break;
                                   case 2:
                                   endDate = rigesterdate?.addMonths(3);
                                   break;
                                 default:
                               };
                               enddatecontroller.text = endDate?.formatCompactDate()??'';
                          },
                          child: SvgPicture.asset('assets/icons/calendar.svg',
                          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSecondary,BlendMode.srcIn),),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  ValueListenableBuilder(
                    valueListenable: radios,
                     builder: (context, value, child) {
                       return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              value: 0,
                               groupValue: radios.value,
                                activeColor: Colors.blueAccent,
                                onChanged: (value) {
                                  radios.value = 0;
                                  endDate = rigesterdate?.addDays(15);
                                  enddatecontroller.text = endDate?.formatCompactDate()??'';
                                },),
                                Text(LocaleKeys.days_15.tr())
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              value: 1,
                               groupValue: radios.value,
                                activeColor: Colors.blueAccent,
                                onChanged: (value) {
                                  radios.value = 1;
                                  endDate = rigesterdate?.addMonths(1);
                                  enddatecontroller.text = endDate?.formatCompactDate()??''; 
                                },),
                                Text(LocaleKeys.months_1.tr())
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              value: 2,
                               groupValue: radios.value,
                                activeColor: Colors.blueAccent,
                                onChanged: (value) {
                                  radios.value = 2;
                                  endDate = rigesterdate?.addMonths(3);
                                  enddatecontroller.text = endDate?.formatCompactDate()??'';
                                },),
                                Text(LocaleKeys.months_3.tr())
                          ],
                        ),
                      ),
                    ],
                  );
                     },),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return LocaleKeys.error_textfield_endDate.tr();
                      }
                      return null;
                    },
                    controller: enddatecontroller,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical:8.0),
                        child: GestureDetector(
                          onTap: ()async{
          
                             Jalali? endDate =await showPersianDatePicker(
                             context: context,
                             initialDate: Jalali.now(),
                             firstDate: Jalali(1385, 8),
                              lastDate: Jalali(1450, 9),
                                                      );
                              enddatecontroller.text = endDate?.formatCompactDate()??'';
          
                          },
                          behavior: HitTestBehavior.opaque,
                          child: SvgPicture.asset('assets/icons/calendar.svg',
                          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSecondary,BlendMode.srcIn),),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 55.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)
                        )
                      ),
                      onPressed: ()async{
                        if(formkey.currentState!.validate()){
                            widget.user.fullnam = fullnamecontroller.text;
                            widget.user.phone = int.parse(phonecontroller.text);
                            widget.user.price = pricecontroller.text;
                            widget.user.rigesterdate = rigesterdateconroller.text;
                            widget.user.endDate = enddatecontroller.text;
                            widget.user.radios= radios.value;
                            if(widget.user.isInBox){
                              widget.user.save();
                            }else{
                              await box.add(widget.user);
                            }
                            Navigator.pop(context);
                        } 
                      },
                       child: Text(LocaleKeys.save.tr(),
                       style: Theme.of(context).textTheme.bodyLarge,),
                       ),
                  )
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}