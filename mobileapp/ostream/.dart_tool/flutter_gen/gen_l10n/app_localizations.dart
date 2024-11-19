import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @onboarding_1_t.
  ///
  /// In ar, this message translates to:
  /// **'اعثر على مكانك المثالي'**
  String get onboarding_1_t;

  /// No description provided for @onboarding_1_s.
  ///
  /// In ar, this message translates to:
  /// **'اكتشف أفضل الأماكن لمناسباتك الخاصة. تصفح بسهولة، قارن، واحجز الموقع المثالي لاحتفالك.'**
  String get onboarding_1_s;

  /// No description provided for @onboarding_2_t.
  ///
  /// In ar, this message translates to:
  /// **'التقط كل لحظة'**
  String get onboarding_2_t;

  /// No description provided for @onboarding_2_s.
  ///
  /// In ar, this message translates to:
  /// **'قم بتوظيف مصورين محترفين وفنانين موهوبين في المكياج لجعل مناسبتك لا تُنسى. اختر من بين أفضل الخبراء بالقرب منك.'**
  String get onboarding_2_s;

  /// No description provided for @onboarding_3_t.
  ///
  /// In ar, this message translates to:
  /// **'استعد بأناقة'**
  String get onboarding_3_t;

  /// No description provided for @onboarding_3_s.
  ///
  /// In ar, this message translates to:
  /// **'احجز غرف المكياج واستعد براحة وفخامة. خطط لكل شيء من تطبيق واحد مصمم خصيصًا لك.'**
  String get onboarding_3_s;

  /// No description provided for @next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In ar, this message translates to:
  /// **'تخطي'**
  String get skip;

  /// No description provided for @about_title.
  ///
  /// In ar, this message translates to:
  /// **'عن ليالي'**
  String get about_title;

  /// No description provided for @about_description.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا بك في ليالي، منصتك الشاملة لحجز كل ما تحتاجه لجعل لحظاتك الخاصة لا تُنسى. سواء كنت تخطط لحفل زفاف، احتفال، أو حدث راقي، ليالي يبسط العملية من خلال تقديم مجموعة من الخدمات المميزة في متناول يدك.'**
  String get about_description;

  /// No description provided for @about_what_we_offer.
  ///
  /// In ar, this message translates to:
  /// **'ما نقدمه:'**
  String get about_what_we_offer;

  /// No description provided for @about_venues.
  ///
  /// In ar, this message translates to:
  /// **'أماكن: اكتشف واحجز أماكن فاخرة تناسب أسلوبك والمناسبة الخاصة بك.'**
  String get about_venues;

  /// No description provided for @about_photographers.
  ///
  /// In ar, this message translates to:
  /// **'المصورون: التقط كل لحظة ثمينة مع مصورين محترفين واحصل على مجموعات صور عالية الجودة مباشرةً عبر تطبيقنا.'**
  String get about_photographers;

  /// No description provided for @about_makeup_rooms_artists.
  ///
  /// In ar, this message translates to:
  /// **'غرف وفنانو المكياج: ابحث واحجز فنانين موهوبين في المكياج، إلى جانب غرف مكياج مجهزة بالكامل لتظهر بأفضل مظهر في يومك الكبير.'**
  String get about_makeup_rooms_artists;

  /// No description provided for @about_dresses.
  ///
  /// In ar, this message translates to:
  /// **'الفساتين: تصفح واستأجر فساتين رائعة تتناسب مع رؤيتك والمناسبة.'**
  String get about_dresses;

  /// No description provided for @about_closing.
  ///
  /// In ar, this message translates to:
  /// **'مع ليالي، يمكنك تخطيط كل تفاصيل الحدث بسهولة، مما يضمن أن كل شيء مثالي من البداية إلى النهاية. تم تصميم تطبيقنا لتقديم الراحة والجودة والإبداع لمساعدتك في تحقيق يوم أحلامك.'**
  String get about_closing;

  /// No description provided for @about_download.
  ///
  /// In ar, this message translates to:
  /// **'قم بتنزيل ليالي اليوم وابدأ في تخطيط لحظاتك التي لا تُنسى!'**
  String get about_download;

  /// No description provided for @register.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل'**
  String get register;

  /// No description provided for @already_have_an_account.
  ///
  /// In ar, this message translates to:
  /// **'لديك حساب بالفعل؟'**
  String get already_have_an_account;

  /// No description provided for @sign_in.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get sign_in;

  /// No description provided for @enter_your_credentials.
  ///
  /// In ar, this message translates to:
  /// **'أدخل بيانات الاعتماد الخاصة بك'**
  String get enter_your_credentials;

  /// No description provided for @email.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get email;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @forget_password.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور'**
  String get forget_password;

  /// No description provided for @please_fill.
  ///
  /// In ar, this message translates to:
  /// **'يرجى ملء'**
  String get please_fill;

  /// No description provided for @do_not_have_an_account.
  ///
  /// In ar, this message translates to:
  /// **'ليس لديك حساب؟'**
  String get do_not_have_an_account;

  /// No description provided for @registration.
  ///
  /// In ar, this message translates to:
  /// **'التسجيل'**
  String get registration;

  /// No description provided for @personal_info.
  ///
  /// In ar, this message translates to:
  /// **'المعلومات الشخصية'**
  String get personal_info;

  /// No description provided for @please_fill_the_following.
  ///
  /// In ar, this message translates to:
  /// **'يرجى ملء ما يلي'**
  String get please_fill_the_following;

  /// No description provided for @first_name.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الأول'**
  String get first_name;

  /// No description provided for @last_name.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الأخير'**
  String get last_name;

  /// No description provided for @phone_number.
  ///
  /// In ar, this message translates to:
  /// **'رقم الهاتف'**
  String get phone_number;

  /// No description provided for @date_of_birth.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الميلاد'**
  String get date_of_birth;

  /// No description provided for @gender.
  ///
  /// In ar, this message translates to:
  /// **'الجنس'**
  String get gender;

  /// No description provided for @please_fill_req_field.
  ///
  /// In ar, this message translates to:
  /// **'يرجى ملء الحقول المطلوبة'**
  String get please_fill_req_field;

  /// No description provided for @empty.
  ///
  /// In ar, this message translates to:
  /// **'فارغ'**
  String get empty;

  /// No description provided for @see_all.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get see_all;

  /// No description provided for @choose_your_languages.
  ///
  /// In ar, this message translates to:
  /// **'اختر لغتك'**
  String get choose_your_languages;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @account.
  ///
  /// In ar, this message translates to:
  /// **'الحساب'**
  String get account;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @delete_my_account.
  ///
  /// In ar, this message translates to:
  /// **'حذف حسابي'**
  String get delete_my_account;

  /// No description provided for @yes.
  ///
  /// In ar, this message translates to:
  /// **'نعم'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In ar, this message translates to:
  /// **'لا'**
  String get no;

  /// No description provided for @male.
  ///
  /// In ar, this message translates to:
  /// **'ذكر'**
  String get male;

  /// No description provided for @female.
  ///
  /// In ar, this message translates to:
  /// **'أنثى'**
  String get female;

  /// No description provided for @welcome.
  ///
  /// In ar, this message translates to:
  /// **'أهلا بك'**
  String get welcome;

  /// No description provided for @edit_profile.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الملف الشخصي'**
  String get edit_profile;

  /// No description provided for @internet_connection_error.
  ///
  /// In ar, this message translates to:
  /// **'يرجى التحقق من اتصالك بالإنترنت'**
  String get internet_connection_error;

  /// No description provided for @server_error.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في الخادم 505'**
  String get server_error;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @follow.
  ///
  /// In ar, this message translates to:
  /// **'متابعة'**
  String get follow;

  /// No description provided for @unfollow.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء المتابعة'**
  String get unfollow;

  /// No description provided for @following.
  ///
  /// In ar, this message translates to:
  /// **'متابع'**
  String get following;

  /// No description provided for @edit_my_personal_info.
  ///
  /// In ar, this message translates to:
  /// **'تعديل معلوماتي الشخصية'**
  String get edit_my_personal_info;

  /// No description provided for @app_settings.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات التطبيق'**
  String get app_settings;

  /// No description provided for @dark_mode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الداكن'**
  String get dark_mode;

  /// No description provided for @languages.
  ///
  /// In ar, this message translates to:
  /// **'اللغات'**
  String get languages;

  /// No description provided for @about.
  ///
  /// In ar, this message translates to:
  /// **'حول'**
  String get about;

  /// No description provided for @do_you_wanna_exit.
  ///
  /// In ar, this message translates to:
  /// **'هل ترغب في الخروج؟ :('**
  String get do_you_wanna_exit;

  /// No description provided for @available_dates.
  ///
  /// In ar, this message translates to:
  /// **'التواريخ المتاحة'**
  String get available_dates;

  /// No description provided for @b_g_info.
  ///
  /// In ar, this message translates to:
  /// **'معلومات العريس والعروس'**
  String get b_g_info;

  /// No description provided for @payment.
  ///
  /// In ar, this message translates to:
  /// **'الدفع'**
  String get payment;

  /// No description provided for @summery.
  ///
  /// In ar, this message translates to:
  /// **'الملخص'**
  String get summery;

  /// No description provided for @terms_accept.
  ///
  /// In ar, this message translates to:
  /// **'أوافق على جميع الشروط والأحكام'**
  String get terms_accept;

  /// No description provided for @book_now.
  ///
  /// In ar, this message translates to:
  /// **'احجز الآن'**
  String get book_now;

  /// No description provided for @please_choose_payment_option.
  ///
  /// In ar, this message translates to:
  /// **'يرجى اختيار خيار الدفع'**
  String get please_choose_payment_option;

  /// No description provided for @please_choose_date.
  ///
  /// In ar, this message translates to:
  /// **'يرجى اختيار تاريخ'**
  String get please_choose_date;

  /// No description provided for @groom_name.
  ///
  /// In ar, this message translates to:
  /// **'اسم العريس'**
  String get groom_name;

  /// No description provided for @bride_name.
  ///
  /// In ar, this message translates to:
  /// **'اسم العروس'**
  String get bride_name;

  /// No description provided for @card.
  ///
  /// In ar, this message translates to:
  /// **'بطاقة'**
  String get card;

  /// No description provided for @soon.
  ///
  /// In ar, this message translates to:
  /// **'قريبًا..'**
  String get soon;

  /// No description provided for @will_be_available_soon.
  ///
  /// In ar, this message translates to:
  /// **'سيتوفر قريبًا'**
  String get will_be_available_soon;

  /// No description provided for @cash.
  ///
  /// In ar, this message translates to:
  /// **'نقدا في مكان الحجزً'**
  String get cash;

  /// No description provided for @booking_auto_remove.
  ///
  /// In ar, this message translates to:
  /// **'سيتم إلغاء الحجز تلقائيًا بعد 48 ساعة إذا لم تقم بالدفع.'**
  String get booking_auto_remove;

  /// No description provided for @vodafone_cash.
  ///
  /// In ar, this message translates to:
  /// **'فودافون كاش'**
  String get vodafone_cash;

  /// No description provided for @transfer.
  ///
  /// In ar, this message translates to:
  /// **'تحويل'**
  String get transfer;

  /// No description provided for @transaction_number.
  ///
  /// In ar, this message translates to:
  /// **'رقم العملية'**
  String get transaction_number;

  /// No description provided for @please_write_transaction_number.
  ///
  /// In ar, this message translates to:
  /// **'يرجى كتابة رقم العملية'**
  String get please_write_transaction_number;

  /// No description provided for @deposit.
  ///
  /// In ar, this message translates to:
  /// **'المقدم'**
  String get deposit;

  /// No description provided for @total.
  ///
  /// In ar, this message translates to:
  /// **'الإجمالي'**
  String get total;

  /// No description provided for @egp.
  ///
  /// In ar, this message translates to:
  /// **'ج.م'**
  String get egp;

  /// No description provided for @reviews.
  ///
  /// In ar, this message translates to:
  /// **'التقييمات'**
  String get reviews;

  /// No description provided for @oops.
  ///
  /// In ar, this message translates to:
  /// **'أوه...'**
  String get oops;

  /// No description provided for @sorry_login_first.
  ///
  /// In ar, this message translates to:
  /// **'عذرًا، عليك تسجيل الدخول أولاً'**
  String get sorry_login_first;

  /// No description provided for @favorites.
  ///
  /// In ar, this message translates to:
  /// **'المفضلة'**
  String get favorites;

  /// No description provided for @categories.
  ///
  /// In ar, this message translates to:
  /// **'الفئات'**
  String get categories;

  /// No description provided for @popular.
  ///
  /// In ar, this message translates to:
  /// **'الأكثر شهرة'**
  String get popular;

  /// No description provided for @top.
  ///
  /// In ar, this message translates to:
  /// **'أفضل'**
  String get top;

  /// No description provided for @venues.
  ///
  /// In ar, this message translates to:
  /// **'القاعات'**
  String get venues;

  /// No description provided for @photographers.
  ///
  /// In ar, this message translates to:
  /// **'المصورون'**
  String get photographers;

  /// No description provided for @makeup_rooms.
  ///
  /// In ar, this message translates to:
  /// **'غرف المكياج'**
  String get makeup_rooms;

  /// No description provided for @makeup_artist.
  ///
  /// In ar, this message translates to:
  /// **'فناني المكياج'**
  String get makeup_artist;

  /// No description provided for @type_something.
  ///
  /// In ar, this message translates to:
  /// **'اكتب شيئًا'**
  String get type_something;

  /// No description provided for @search.
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get search;

  /// No description provided for @my_bookings.
  ///
  /// In ar, this message translates to:
  /// **'حجوزاتي'**
  String get my_bookings;

  /// No description provided for @upcoming.
  ///
  /// In ar, this message translates to:
  /// **'القادمة'**
  String get upcoming;

  /// No description provided for @past.
  ///
  /// In ar, this message translates to:
  /// **'الماضية'**
  String get past;

  /// No description provided for @error_loading_bookings.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في تحميل الحجوزات'**
  String get error_loading_bookings;

  /// No description provided for @no_bookings_available.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد حجوزات متاحة'**
  String get no_bookings_available;

  /// No description provided for @status.
  ///
  /// In ar, this message translates to:
  /// **'الحالة'**
  String get status;

  /// No description provided for @paid.
  ///
  /// In ar, this message translates to:
  /// **'مدفوع'**
  String get paid;

  /// No description provided for @remaining.
  ///
  /// In ar, this message translates to:
  /// **'المتبقي'**
  String get remaining;

  /// No description provided for @created_at.
  ///
  /// In ar, this message translates to:
  /// **'تم الإنشاء في'**
  String get created_at;

  /// No description provided for @updated_at.
  ///
  /// In ar, this message translates to:
  /// **'تم التحديث في'**
  String get updated_at;

  /// No description provided for @add_a_review.
  ///
  /// In ar, this message translates to:
  /// **'إضافة تقييم'**
  String get add_a_review;

  /// No description provided for @my_reservation.
  ///
  /// In ar, this message translates to:
  /// **'حجزاتي'**
  String get my_reservation;

  /// No description provided for @date.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get date;

  /// No description provided for @reservation_num.
  ///
  /// In ar, this message translates to:
  /// **'رقم الحجز'**
  String get reservation_num;

  /// No description provided for @package.
  ///
  /// In ar, this message translates to:
  /// **'الباقة'**
  String get package;

  /// No description provided for @contact_us.
  ///
  /// In ar, this message translates to:
  /// **'اتصل بنا'**
  String get contact_us;

  /// No description provided for @rate_your_reservation.
  ///
  /// In ar, this message translates to:
  /// **'قيّم حجزك'**
  String get rate_your_reservation;

  /// No description provided for @rate.
  ///
  /// In ar, this message translates to:
  /// **'التقييم'**
  String get rate;

  /// No description provided for @write_your_review.
  ///
  /// In ar, this message translates to:
  /// **'اكتب مراجعتك...'**
  String get write_your_review;

  /// No description provided for @submit.
  ///
  /// In ar, this message translates to:
  /// **'إرسال'**
  String get submit;

  /// No description provided for @notifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notifications;

  /// No description provided for @discount.
  ///
  /// In ar, this message translates to:
  /// **'خصم'**
  String get discount;

  /// No description provided for @offers.
  ///
  /// In ar, this message translates to:
  /// **'عروض'**
  String get offers;

  /// No description provided for @please_login_to_see.
  ///
  /// In ar, this message translates to:
  /// **'يرجى تسجيل الدخول لعرض هذه الشاشة'**
  String get please_login_to_see;

  /// No description provided for @my_profile.
  ///
  /// In ar, this message translates to:
  /// **'ملفي الشخصي'**
  String get my_profile;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @activity.
  ///
  /// In ar, this message translates to:
  /// **'النشاط'**
  String get activity;

  /// No description provided for @followers.
  ///
  /// In ar, this message translates to:
  /// **'المتابعون'**
  String get followers;

  /// No description provided for @photos.
  ///
  /// In ar, this message translates to:
  /// **'الصور'**
  String get photos;

  /// No description provided for @items.
  ///
  /// In ar, this message translates to:
  /// **'العناصر'**
  String get items;

  /// No description provided for @reels.
  ///
  /// In ar, this message translates to:
  /// **'المقاطع'**
  String get reels;

  /// No description provided for @my_photo_sessions.
  ///
  /// In ar, this message translates to:
  /// **'جلسات التصوير الخاصة بي'**
  String get my_photo_sessions;

  /// No description provided for @price.
  ///
  /// In ar, this message translates to:
  /// **'السعر'**
  String get price;

  /// No description provided for @checkout.
  ///
  /// In ar, this message translates to:
  /// **'الدفع'**
  String get checkout;

  /// No description provided for @hello_guest.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا، ضيف'**
  String get hello_guest;

  /// No description provided for @hello.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا'**
  String get hello;

  /// No description provided for @name.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get name;

  /// No description provided for @reservation.
  ///
  /// In ar, this message translates to:
  /// **'حجز ليالي'**
  String get reservation;

  /// No description provided for @enjoy_your_day_message.
  ///
  /// In ar, this message translates to:
  /// **'استمتع بمناسبتك، وبعد انتهاء المناسبة يمكنك التقييم'**
  String get enjoy_your_day_message;

  /// No description provided for @terms_halls.
  ///
  /// In ar, this message translates to:
  /// **'1. يتطلب دفع عربون 50٪ لتأكيد الحجز. \n2. إلغاء الحجز قبل 7 أيام من الحدث سيؤدي إلى خصم 20٪.\n3. لا يسمح بتقديم الطعام الخارجي إلا بموافقة مسبقة.\n4. يجب مغادرة المكان بحلول الساعة 12:00 صباحًا ما لم يتم الاتفاق على خلاف ذلك.\n5. يجب على العميل تغطية أي أضرار تحدث للقاعات أو المعدات.'**
  String get terms_halls;

  /// No description provided for @terms_photographers.
  ///
  /// In ar, this message translates to:
  /// **'1. يتطلب دفع عربون غير قابل للاسترداد بنسبة 30٪ عند الحجز. \n2. يجب على العميل تقديم إشعار بتغيير الجدول الزمني قبل 72 ساعة على الأقل.\n3. يتم دفع كامل المبلغ في يوم الحدث.\n4. سيتم تسليم جميع الصور الرقمية في غضون 10 أيام عمل.'**
  String get terms_photographers;

  /// No description provided for @terms_makeup_rooms.
  ///
  /// In ar, this message translates to:
  /// **'1. يجب حجز غرفة المكياج قبل 3 أيام على الأقل. \n2. يتطلب دفع عربون بنسبة 25٪ لتأكيد الحجز.\n3. يمكن استخدام الغرفة لمدة تصل إلى 3 ساعات. يتم فرض رسوم إضافية على الساعات الإضافية.\n4. إلغاء الحجز خلال 24 ساعة سيؤدي إلى خصم 10٪.\n5. يجب على العميل دفع تكاليف أي أضرار تحدث للغرفة أو المعدات.'**
  String get terms_makeup_rooms;

  /// No description provided for @terms_makeup_artists.
  ///
  /// In ar, this message translates to:
  /// **'1. يتطلب دفع عربون غير قابل للاسترداد بنسبة 50٪ لتأكيد الموعد. \n2. يجب إلغاء المواعيد قبل 48 ساعة على الأقل لتجنب أي رسوم إضافية.\n3. خدمات المكياج تكون للفترة الزمنية المتفق عليها، وستتحمل تكلفة إضافية للوقت الإضافي.\n4. قد يتم تطبيق تكاليف السفر إذا كانت الوجهة خارج المدينة.\n5. يحتفظ فنان المكياج بالحق في رفض الخدمة إذا تم انتهاك الشروط.'**
  String get terms_makeup_artists;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
