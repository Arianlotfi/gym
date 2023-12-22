import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_badanvv/screens/users/user.dart';
import 'package:project_badanvv/theme.dart';
import 'package:project_badanvv/translations/locale_keys.g.dart';

class rootscreen extends StatefulWidget {
  const rootscreen({super.key});

  @override
  State<rootscreen> createState() => _rootscreenState();
}

class _rootscreenState extends State<rootscreen> {
  int Currntindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: userscreen(
            Activeusers: Currntindex==0,
          )),
         Container(
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            children: [
              Row(
                children: [
                 Expanded(
                  child:Currntindex ==0? Container(
                    height: 2.0,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ):SizedBox(),
                 ),
                 Expanded(
                  child:Currntindex==1? Container(
                    height: 2.0,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ):SizedBox(),
                 )  
                ],
              ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 75.0,
                    child: GestureDetector(
                      onTap: (){
                       setState(() {
                         Currntindex = 0;
                       });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/users.svg',
                          colorFilter: Currntindex == 0?ColorFilter.mode(Theme.of(context).colorScheme.onSecondary,BlendMode.srcIn)
                          :ColorFilter.mode(CustomColors.kLightGreyColor,BlendMode.srcIn),),
                          SizedBox(width: 8.0,),
                          Text(LocaleKeys.active_users.tr(),
                          style: Currntindex == 0? Theme.of(context).textTheme.bodyMedium
                          :Theme.of(context).textTheme.bodySmall,)
                        ],
                      ),
                    ),
                    ),
                ),
                Expanded(
                  child: Container(
                    height: 75.0,
                    child: GestureDetector(
                      onTap: (){
                       setState(() {
                         Currntindex = 1;
                       });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/icons/calendar.svg',
                          colorFilter:Currntindex == 1? ColorFilter.mode(Theme.of(context).colorScheme.onSecondary,BlendMode.srcIn)
                          :ColorFilter.mode(CustomColors.kLightGreyColor,BlendMode.srcIn),),
                          SizedBox(width: 8.0,),
                          Text(LocaleKeys.expired_users.tr(),
                          style:Currntindex==1? Theme.of(context).textTheme.bodyMedium
                          :Theme.of(context).textTheme.bodySmall,)
                        ],
                      ),
                    ),
                    ),
                )
              ],
            )  
            ],
           ),
          ) 
        ],
      ),
    );
  }
}