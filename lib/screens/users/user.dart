import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:project_badanvv/main.dart';
import 'package:project_badanvv/models/users.dart';
import 'package:project_badanvv/screens/add_edit/add_edit.dart';
import 'package:project_badanvv/theme.dart';
import 'package:project_badanvv/translations/locale_keys.g.dart';

class userscreen extends StatefulWidget {
  const userscreen(
    {super.key,
    required this.Activeusers
    });
 final bool Activeusers;
  @override
  State<userscreen> createState() => _userscreenState();
}

class _userscreenState extends State<userscreen> {
  ValueNotifier<String> serchenotifire = ValueNotifier('');
    var box = Hive.box<User>(userboxname);
    
    List<User> getusers(){
      List<User> listusers = [];
      for(var element in box.values){
       var JalaliDate1 = Jalali.now().toDateTime();

       int endDateyear = int.parse(element.endDate!.split('/')[0]);
       int endDatemonth = int.parse(element.endDate!.split('/')[1]);
       int endDateday = int.parse(element.endDate!.split('/')[2]);

       var JalaliDate2 = Jalali(endDateyear,endDatemonth,endDateday).toDateTime();
       if(widget.Activeusers){
        if(JalaliDate2.isAfter(JalaliDate1)){
          listusers.add(element);
        }
       }
       else{
        if(!JalaliDate2.isAfter(JalaliDate1)){
           listusers.add(element);
        }
       }

      }
      return listusers;
    }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton:widget.Activeusers? FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) {
            return addoredit(user: User(),);
          },));
        },
        child: Icon(Icons.add,
        color: Theme.of(context).colorScheme.onPrimary,),
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        ):SizedBox(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              SizedBox(height: 10.0,),
              Row(
                children: [
                  Text(LocaleKeys.users_gym_vesam.tr()),
                  Spacer(),
                  IconButton(
                    onPressed: ()async{
                      isthemedark.value =!isthemedark.value;
                       await sharedPreferences.setBool('isdark', isthemedark.value);
                    },
                     icon: isthemedark.value?SvgPicture.asset('assets/icons/dark.svg'):
                     SvgPicture.asset('assets/icons/light.svg')),
                  IconButton(
                  onPressed: ()async{
                    if(context.locale == Locale('en')){
                       await context.setLocale(Locale('fa'));
                    }else{
                       await context.setLocale(Locale('en'));
                    }
                  },
                   icon:context.locale == Locale('en')?SvgPicture.asset('assets/icons/iran.svg',
                   height: 25.0,
                   width: 25.0,):
                   SvgPicture.asset('assets/icons/us.svg',
                   height: 25.0,
                   width: 25.0,) ),
                  IconButton(onPressed: (){},
                   icon: SvgPicture.asset('assets/icons/refresh.svg',
                  colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSecondary,BlendMode.srcIn),)),
                ],
              ),
              SizedBox(height: 20.0,),
              TextField(
                onChanged: (value) {
                  serchenotifire.value = value;
                },
                decoration: InputDecoration(
                  hintText: LocaleKeys.fullname.tr(),
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  contentPadding: EdgeInsets.all(15.0),
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              ValueListenableBuilder(
                valueListenable:box.listenable(),
                 builder:(context, value, child) {
                   return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: widget.Activeusers?CustomColors.kGreenColor:CustomColors.kRedColor,
                  borderRadius: BorderRadius.circular(12.0)
                ),
                child: Row(
                  children: [
                    Text(widget.Activeusers?LocaleKeys.count_of_active_users.tr():
                    LocaleKeys.count_of_inactive_users.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,),
                    Spacer(),
                    Text(LocaleKeys.people.tr(namedArgs: {
                      "count":getusers().length.toString()
                    }),),
                  ],
                ),
              );
                 },),
              SizedBox(height: 20.0,),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: serchenotifire,
                   builder: (context, value, child) {
                    return ValueListenableBuilder(
                  valueListenable: box.listenable(),
                   builder:(context, value, child) {

                     List<User> users = getusers();
                     if(serchenotifire.value.isEmpty){
                      users = getusers();
                     }
                     else{
                      users = users.where((element) => element.fullnam!.toLowerCase().contains(serchenotifire.value.toLowerCase(),)).toList();
                     }
                     
                     return users.isEmpty ? Center(child:SvgPicture.asset('assets/icons/empty.svg',width: 150.0,height: 150.0,),): 
                     ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    var item = users[index];
                  return  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
                    margin: EdgeInsets.only(bottom: 10.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(12.0)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(item.fullnam!,
                          style: Theme.of(context).textTheme.bodyMedium,),
                        ),
                        Expanded(
                          child: Text(item.endDate!,
                            style: Theme.of(context).textTheme.bodyMedium,),
                          
                        ),
                        Row(
                          children: [
                            IconButton(
                        onPressed: (){},
                         icon: GestureDetector(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) {
                              return addoredit(user: item,); },));
                          },
                          behavior: HitTestBehavior.opaque,
                           child: SvgPicture.asset('assets/icons/edit.svg',
                           width: 25.0,
                           height: 25.0,
                           colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSecondary,BlendMode.srcIn),),
                         )),
                         IconButton(
                        onPressed: (){
                          showDialog(
                            context: context,
                             builder: (context) {
                               return AlertDialog(
                                title: Text(LocaleKeys.delete_user.tr(),
                                style: Theme.of(context).textTheme.bodyMedium,),
                                content: Text(LocaleKeys.confirm_delete.tr(),
                                style: Theme.of(context).textTheme.bodyMedium,),
                                actions: [
                                  TextButton(
                                    onPressed: (){
                                      item.delete();
                                      Navigator.pop(context);
                                    },
                                     child:Text(LocaleKeys.yes.tr())),
                                  TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                     child:Text(LocaleKeys.no.tr())),
                                ],
                               );
                             },);
                        },
                         icon: SvgPicture.asset('assets/icons/delete.svg',
                         width: 25.0,
                         height: 25.0,
                         colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSecondary,BlendMode.srcIn),)),
                          ],
                        )
                      ],
                    ),
                  );
                },);
                   },); 
                  },)
              ),
            ],
          ),
        ),
      )
    );
  }
}