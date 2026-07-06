
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:virtual_mentor_app/core/theme/app_colors.dart';
import 'package:virtual_mentor_app/core/theme/app_sizes.dart';
import 'package:virtual_mentor_app/core/theme/app_text_styles.dart';
import 'package:virtual_mentor_app/features/auth/presentation/widgets/auth_background_shape_widget.dart';
import 'package:virtual_mentor_app/features/course/presentation/blocs/statistics/progress_overview_bloc.dart';
import 'package:virtual_mentor_app/features/course/presentation/blocs/statistics/progress_overview_event.dart';
import 'package:virtual_mentor_app/features/course/presentation/widgets/statistics_card.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});


  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<ProgressOverviewBloc>().add(GetProgressOverview());
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body:
      
       SizedBox(
        width: AppSizes.designWidth.w,
        height: AppSizes.designHeight.h,
        child: Stack(
          children: [
            const AuthBackgroundShapeWidget(),
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 21.w,vertical: 15.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary, size: AppSizes.iconLg),
                          onPressed: () {},
                           ),
                           SizedBox(width:55.w ),
                           Text('الإحصائيات',
                          style: AppTextStyles.titleBold(color: AppColors.textPrimary),),
                          SizedBox(width:78.w ),
                          IconButton(
                         icon: Icon(Icons.settings_outlined, color: AppColors.textPrimary, size:AppSizes.iconLg),
                         onPressed: () {},),
                        ]
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 30.h),
                        padding: EdgeInsets.symmetric(horizontal: 50.w,vertical: 16.h),
                        decoration: BoxDecoration(
                          color: AppColors.skyBlue,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'التخصص الحالي  ',
                                  style: AppTextStyles.bodyBold(color: AppColors.primary),
                                ),
                                Text(
                                  'هندسة برمجيات',
                                  style: AppTextStyles.bodyRegular(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'عدد التخصصات : 5',
                              style: AppTextStyles.labelRegular(color: AppColors.textSecondary),
                            ),
                            SizedBox(height: 12.h),
                            Container(
                              width: double.infinity,
                              height: 37.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.r),
                                color: AppColors.primary
                              ),
                              child: 
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                Icon(Icons.keyboard_arrow_down, color: AppColors.white, size: 20.w),
                                Text(
                                'إحصائيات باقي التخصصات',
                                style: AppTextStyles.button().copyWith(fontSize: 14.sp),
                              ),
                              ],),
                      
                         
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24.w),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'البرمجة',
                              style: AppTextStyles.titleBold(color: AppColors.textPrimary),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'تعلم البرمجة من الأساسيات إلى المستويات\nالمتقدمة بطريقة احترافية ومنظمة.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.labelRegular(color: AppColors.textSecondary).copyWith(height: 1.4),
                            ),
                            SizedBox(height: 24.h),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 140.w,
                                  height: 140.w,
                                  child: CircularProgressIndicator(
                                    value: 0.0, // نسبة 0%
                                    strokeWidth: 10.w,
                                    backgroundColor: const Color(0xffe4ecff),
                                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '0%',
                                      style: AppTextStyles.displayBold(color: AppColors.textPrimary),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'التقدم الكلي',
                                      style: AppTextStyles.captionRegular(color: AppColors.textSecondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.menu_book_rounded,
                              iconColor: AppColors.primary,
                              iconBg: const Color(0xffeef4ff),
                              value: '7',
                              title: 'المواد',
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.emoji_events_outlined,
                              iconColor: const Color(0xff12b76a),
                              iconBg: const Color(0xffedfcf2),
                              value: '8',
                              title: 'المهارات',
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.grid_view_rounded,
                              iconColor: const Color(0xff9e77ed),
                              iconBg: const Color(0xfff9f5ff),
                              value: '10',
                              title: 'المفاهيم',
                            ),
                          ),
                        ],
                      ),
Container(
  width: double.infinity,
  height: 155.h,
  padding: EdgeInsets.symmetric(vertical: 24.h,horizontal: 24.w),
  margin: EdgeInsets.symmetric(vertical: 30.h),
  decoration: BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(16.r),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ملخص الأداء',
            style: AppTextStyles.bodyBold(color: AppColors.textPrimary),
          ),
           Icon(Icons.more_horiz, color: AppColors.textSecondary, size: 24.w),
        ],
      ),
      SizedBox(height: 16.h),
      Row(
        children: [
           Expanded(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(end: 14.w),
                  decoration:BoxDecoration(
                    border:Border.all(color:AppColors.primary,width: 2.w ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.star_sharp, color: AppColors.primary, size: 20.w),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إجمالي النقاط',
                      style: AppTextStyles.captionRegular(color: AppColors.textSecondary),
                    ),
                    SizedBox(height: 9.h),
                    Row(
                      children: [
                        Text(
                          '88',
                          style: AppTextStyles.titleBold(color: AppColors.textPrimary),
                        ),
                        SizedBox(width: 8.11.w,),
                        Text(
                          'XP ',
                          style: AppTextStyles.captionRegular(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 40.h,
            width: 1.w,
            color: AppColors.textSecondary.withValues(alpha: 0.2),
            margin: EdgeInsets.symmetric(horizontal: 17.w),
          ),
            Expanded(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(end: 14.w,),
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.trending_up_sharp, color: const Color.fromARGB(255, 224, 230, 227), size: 24.w),
                ),
                Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'متوسط النتيجة',
                      style: AppTextStyles.captionRegular(color: AppColors.textSecondary),
                    ),
                     SizedBox(height: 8.11.w,),
                    Text(
                      '44%',
                      style: AppTextStyles.titleBold(color: AppColors.textPrimary),
                    ),
                  ],
                ),
                SizedBox(width: 12.w),
              ],
            ),
          ),
          
        ],
      ),
    ],
  ),
),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
     Text(
      'حالة المهارات',
      style: AppTextStyles.bodyRegular(color: AppColors.textPrimary),
    ),
    TextButton(
      onPressed: () {},
      child: Text(
        'عرض الكل',
        style: AppTextStyles.labelRegular(color: AppColors.primary),
      ),
    ),
  ],
),
SizedBox(height: 12.h),
Row(
  children: [
       Expanded(
         child: Container(
           height: 65.h,
           padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
           decoration: BoxDecoration(
           color: const Color(0xFFFFE4E4).withValues(alpha: 0.80),
             borderRadius: BorderRadius.circular(12.r),
             border: Border.all(color:const Color(0xFFEF4444).withValues(alpha: 0.20)),
           ),
           child: Row(
             children: [
               Container(
                 margin: EdgeInsetsDirectional.only(end: 10.w),
                 decoration: const BoxDecoration(
                   color: AppColors.error,
                   shape: BoxShape.circle,
                 ),
                 child: Icon(Icons.arrow_downward, color: Colors.white, size: AppSizes.iconLg),
               ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     'ضعيفة',
                     style: AppTextStyles.button(color: AppColors.error),
                   ),
                   SizedBox(height: 2.h),
                   Text(
                     '1 مهارة',
                     style: AppTextStyles.captionRegular(color: const Color(0xffb42318)),
                   ),
                 ],
               ),
             ],
           ),
         ),
       ),
       SizedBox(width: 22.w,),
    Expanded(
      child: Container(
        height: 65.h,
        padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 16.w),
        decoration: BoxDecoration(
          color: const Color(0xffedfcf2),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xffd1fadf), width: 1.w),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: const Color(0xff027a48), size: AppSizes.iconLg),
            SizedBox(width: 10.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'متقنة',
                  style: AppTextStyles.button(color: AppColors.success),
                ),
                SizedBox(height: 2.h),
                Text(
                  '0 مهارات',
                  style: AppTextStyles.captionRegular(color: const Color(0xff027a48)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    SizedBox(width: 12.w),
  ],
),
SizedBox(height: 16.h),

Row(
  children: [
    Expanded(child: StatisticsCard(value:'0', title:'المهارات\nالمتقنة',)),
    SizedBox(width: 8.w),
    Expanded(child: StatisticsCard(value:'0', title:'المهارات\nالضعيفة')),
    SizedBox(width: 8.w),
    Expanded(child: StatisticsCard(value:'0', title:'المهارات\nقيد التطوير')),
    SizedBox(width: 8.w),
    Expanded(child: StatisticsCard(value:'7', title:'المهارات الغير مبدوءة')),
  ],
),
SizedBox(height: 20.h),

Text(
  'تحليل المهارات',
  style: AppTextStyles.bodyRegular(color: AppColors.textPrimary),
),

Container(
  width: double.infinity,
  padding: EdgeInsets.symmetric(vertical: 24.h,horizontal: 16.w),
  margin: EdgeInsetsDirectional.only(top: 12.h,bottom: 30.h),
  decoration: BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(24.r),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'المهارة الأضعف حالياً',
            style: AppTextStyles.bodyRegular(color: AppColors.error),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '44%',
                style: AppTextStyles.displayBold(color: AppColors.error),
              ),
              SizedBox(height: 4.h),
              Text(
                'النتيجة الحالية',
                style: AppTextStyles.captionRegular(color: AppColors.textPrimary),
              ),
            ],
          ),
        ],
      ),
      SizedBox(height: 16.h),
      
      // تفاصيل المهارة (FastAPI)
      Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FastAPI',
              style: AppTextStyles.titleMedium(color: AppColors.textPrimary).copyWith(fontSize: 24.sp),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'تطوير الخدمات- ',
                  style: AppTextStyles.captionMedium(),
                ),
                Text(
                  'Backend Development',
                  style: AppTextStyles.captionMedium(),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: 16.h),

      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('مبتدئ', style: AppTextStyles.labelRegular(),),
              Text('متقدم', style: AppTextStyles.labelRegular()),
            ],
          ),
          SizedBox(height: 6.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: 0.44,
              minHeight: 10.h,
              backgroundColor: AppColors.grey100,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.error),
            ),
          ),
        ],
      ),
      SizedBox(height: 20.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb, color: AppColors.primary, size: 20.w),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'بناءً على التقييم الأخير تحتاج التركيز على التحقق من البيانات (pydantic) لتحسين مستواك في هذه المهارة.',
              style: AppTextStyles.captionRegular().copyWith(height: 1.4),
            ),
          ),
        ],
      ),
    ],
  ),
),
SizedBox(height: 16.h),

Container(
  width: double.infinity,
  padding: EdgeInsets.all(32.w),
  decoration: BoxDecoration(
    color: AppColors.skyBlue, 
    borderRadius: BorderRadius.circular(16.r),
  ),
  child: Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'التقييم القادم',
            style: AppTextStyles.titleMedium().copyWith(fontSize: 24.sp),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.access_time, color: AppColors.textSecondary, size: 11.67.w),
               SizedBox(width: 6.w),
              Text(
                'متاح خلال يوم واحد / جلسة واحدة',
                style: AppTextStyles.captionRegular(),
              ),
            ],
          ),
        ],
      ),
      const Spacer(),
      Container(
        padding: EdgeInsets.all(12.w),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.notifications_none_rounded, color: Colors.white, size: 26.w),
      ),
    ],
  ),
),
SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String value,
    required String title,
  }) {
    return Container(
      width:105.w,
      height: 112.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16.r),
        
      ),
      child: Column(
        children: [
          Container(
            width:40.w ,
            height: 40.h,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size:AppSizes.iconSm),
          ),
          SizedBox(height: 10.h),
          Text(
            value,
            style: AppTextStyles.titleBold(color: AppColors.textPrimary),
          ),
          SizedBox(height: 9.h),
          Text(
            title,
            style: AppTextStyles.captionMedium(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

}
