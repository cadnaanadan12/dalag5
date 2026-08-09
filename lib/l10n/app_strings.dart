/// Dhammaan qoraalada application-ka, oo lugu qoro Ingiriisi & Soomaali.
/// Si loo daro qoraal cusub: ku dar key isku mid ah labada lug ('en' iyo 'so').
/// MUHIIM: Screen-yada oo dhan waa inay isticmaalaan lang.t('key') halkii ay
/// ku qori lahaayeen qoraal Ingiriisi ah oo toos ah, si luuqadu meel walba ugu shaqeeyso.
class AppStrings {
  AppStrings._();

  static const Map<String, Map<String, String>> values = {
    'en': {
      // Splash
      'tagline': 'Market Prices at Your Fingertips',
      'powered_by': 'POWERED BY DALAG INTELLIGENCE',

      // Login
      'welcome_back': 'Welcome Back',
      'login_subtitle':
          'Access your agricultural market intelligence dashboard',
      'username': 'Username',
      'username_hint': 'e.g. abdirahman_w',
      'password': 'Password',
      'forgot_password': 'Forgot Password?',
      'stay_signed_in': 'Stay signed in for 30 days',
      'login': 'Login',
      'or_continue_with': 'OR CONTINUE WITH',
      'new_to_dalag': 'New to Dalag?',
      'create_account': 'Create an Account',
      'secure_access': 'SECURE MARKETPLACE ACCESS',
      'rights_reserved': '© 2024 Dalag Intelligence. All rights reserved.',
      'enter_username_password': 'Please enter your username and password',
      'create_account_title': 'Create Account',
      'create_account_subtitle': 'Join Dalag and stay ahead of market trends',
      'email': 'Email',
      'email_hint': 'you@example.com',
      'confirm_password': 'Confirm Password',
      'already_have_account': 'Already have an account?',
      'sign_in': 'Sign In',
      'fill_all_fields': 'Please fill all fields',
      'passwords_not_match': 'Passwords do not match',
      'full_name': 'Full Name',

      // Home
      'welcome_back_caps': 'WELCOME BACK',
      'guest': 'Guest',
      'market_stable': 'Market prices in %city are stable today.',
      'daily_forecast': 'DAILY FORECAST',
      'search_vegetables': 'Search vegetables (e.g. Basal, Tamaand)',
      'trending_prices': 'Trending Prices',
      'view_all': 'View All',
      'current_price': 'CURRENT PRICE',
      'market_activity': 'Market Activity',
      'item': 'Item',
      'unit': 'Unit',
      'price': 'Price',
      'change': 'Change',
      'stable': 'Stable',

      // Markets
      'live_market_rates': 'Live Market Rates',
      'today': 'TODAY',
      'vegetables': 'Vegetables',
      'fruits': 'Fruits',
      'grains': 'Grains',
      'oils': 'Oils',
      'poultry': 'Poultry',
      'spices': 'Spices',
      'produce': 'PRODUCE',
      'price_slsh': 'PRICE (SLSH)',
      'market_sentiment': 'MARKET SENTIMENT',
      'sentiment_text':
          'Expect price drops in %city next week due to high supply from Wajaale.',
      'view_analysis': 'View Analysis',
      'price_comparison': 'PRICE COMPARISON',
      'select_category': 'SELECT CATEGORY',
      'all_categories': 'All',
      'items_count': 'items',

      // Add price
      'update_market_price': 'Update Market Price',
      'add_subtitle':
          'Contribute real-time data to help local farmers and traders stay informed.',
      'select_vegetable': 'SELECT PRODUCE',
      'market_city': 'MARKET CITY',
      'submit_price': 'Submit Price',
      'price_submitted': 'Price submitted successfully',
      'enter_valid_price': 'Please enter a valid price',

      // Settings
      'preferences': 'PREFERENCES',
      'notification_settings': 'Notification Settings',
      'notification_sub': 'Price alerts and market updates',
      'language': 'Language',
      'language_sub': 'English / Somali',
      'city_preferences': 'City Preferences',
      'city_pref_sub': 'Select your preferred market city',
      'select_preferred_city': 'Select Preferred City',
      'support': 'SUPPORT',
      'help_support': 'Help & Support',
      'help_sub': 'FAQs and contact support',
      'privacy_policy': 'Privacy Policy',
      'privacy_sub': 'Terms and data usage',
      'logout': 'Logout',
      'app_version': 'App Version 2.4.0 (Dalag Stable)',
      'edit_profile': 'Edit Profile',
      'change_photo': 'Change Photo',
      'name': 'Name',
      'city': 'City',
      'save': 'Save',
      'dark_mode': 'Dark Mode',
      'dark_mode_on': 'Dark',
      'dark_mode_off': 'Light',

      // Help & support (chat)
      'help_chat': 'Chat with Support',
      'type_message': 'Type your message...',
      'send': 'Send',
      'chat_greeting': 'Hello! How can we help you today?',
      'chat_auto_reply':
          'Thank you for your message. Our support team will get back to you shortly.',

      // Privacy Policy
      'privacy_policy_title': 'Privacy Policy',
      'privacy_last_updated': 'Last updated: 2024',
      'privacy_intro':
          'Dalag Intelligence ("we", "us", or "our") operates the Dalag mobile application. This page explains how we collect, use and protect your personal data when you use our Service.',
      'privacy_data_collection_title': 'Information We Collect',
      'privacy_data_collection_body':
          'We may collect your name, email, phone number, city, and usage data such as app activity and device information to provide and improve the Service.',
      'privacy_use_title': 'How We Use Your Data',
      'privacy_use_body':
          'We use your data to operate the app, notify you of price changes, provide support, and improve market intelligence features.',
      'privacy_security_title': 'Data Security',
      'privacy_security_body':
          'We take reasonable steps to protect your data, but no method of electronic storage is 100% secure.',
      'privacy_contact_title': 'Contact Us',
      'privacy_contact_body':
          'For questions about this policy, email us at support@dalag.com',

      // Analysis chart
      'price_trend_title': 'Price Trend - Last 7 Days',
      'price_trend_caption': 'Price trend for Tomatoes in %city',
      'mon': 'Mon',
      'tue': 'Tue',
      'wed': 'Wed',
      'thu': 'Thu',
      'fri': 'Fri',
      'sat': 'Sat',
      'sun': 'Sun',

      // Nav
      'home': 'Home',
      'markets': 'Markets',
      'add': 'Add',
      'settings': 'Settings',
    },
    'so': {
      // Splash
      'tagline': 'Qiimaha Suuqa Faraha ku Hay',
      'powered_by': 'WAXAA MATALA DALAG INTELLIGENCE',

      // Login
      'welcome_back': 'Soo Dhawoow Mar Kale',
      'login_subtitle': 'Gal dashboard-ka macluumaadka suuqa beeraha',
      'username': 'Magaca Isticmaalaha',
      'username_hint': 'tusaale: abdirahman_w',
      'password': 'Furaha Sirta ah',
      'forgot_password': 'Furaha ma illowday?',
      'stay_signed_in': 'Igu haye 30 maalmood',
      'login': 'Gal',
      'or_continue_with': 'AMA KU SII WAD',
      'new_to_dalag': 'Cusub Dalag?',
      'create_account': 'Samee Akoon',
      'secure_access': 'GELITAAN AMMAAN AH OO SUUQA AH',
      'rights_reserved':
          '© 2024 Dalag Intelligence. Xuquuqda oo dhan way xafidan yihiin.',
      'enter_username_password': 'Fadlan geli magacaaga iyo furaha sirta ah',
      'create_account_title': 'Samee Akoon Cusub',
      'create_account_subtitle': 'Ku biir Dalag oo la soco isbeddellada suuqa',
      'email': 'Iimayl',
      'email_hint': 'adaan@tusaale.com',
      'confirm_password': 'Xaqiiji Furaha Sirta ah',
      'already_have_account': 'Akoon miyaad horey u lahayd?',
      'sign_in': 'Gal Akoonkaaga',
      'fill_all_fields': 'Fadlan buuxi dhammaan meelaha',
      'passwords_not_match': 'Furaha sirta ahi isku mid ma aha',
      'full_name': 'Magaca Buuxa',

      // Home
      'welcome_back_caps': 'SOO DHAWOOW',
      'guest': 'Marti',
      'market_stable': 'Qiimaha suuqa %city maanta wuu deggan yahay.',
      'daily_forecast': 'CIMILADA MAANTA',
      'search_vegetables': 'Raadi khudaar (tusaale: Basal, Tamaand)',
      'trending_prices': 'Qiimaha Kaca',
      'view_all': 'Dhammaan Arag',
      'current_price': 'QIIMAHA HADDA',
      'market_activity': 'Dhaqdhaqaaqa Suuqa',
      'item': 'Alaab',
      'unit': 'Cabbir',
      'price': 'Qiime',
      'change': 'Isbeddel',
      'stable': 'Deggan',

      // Markets
      'live_market_rates': 'Qiimaha Suuqa Tooska ah',
      'today': 'MAANTA',
      'vegetables': 'Khudaar',
      'fruits': 'Miro',
      'grains': 'Hadhuudh',
      'oils': 'Saliid',
      'poultry': 'Digaag',
      'spices': 'Xawaash',
      'produce': 'ALAABTA',
      'price_slsh': 'QIIMAHA (SLSH)',
      'market_sentiment': 'DHINACA SUUQA',
      'sentiment_text':
          'Waxaa la filayaa in qiimaha %city hoos u dhaco toddobaadka soo socda sababtoo ah baayacmushtari badan oo ka imanaya Wajaale.',
      'view_analysis': 'Falanqayn Arag',
      'price_comparison': 'ISBARBARDHIGGA QIIMAHA',
      'select_category': 'DOORO QAYBTA',
      'all_categories': 'Dhammaan',
      'items_count': 'alaab',

      // Add price
      'update_market_price': 'Cusboonaysii Qiimaha Suuqa',
      'add_subtitle':
          'Ku biir xogta waqtiga dhabta ah si aad u caawiso beeralayda iyo ganacsatada.',
      'select_vegetable': 'DOORO ALAABTA',
      'market_city': 'MAGAALADA SUUQA',
      'submit_price': 'Dir Qiimaha',
      'price_submitted': 'Qiimaha si guul leh ayaa loo diray',
      'enter_valid_price': 'Fadlan geli qiime sax ah',

      // Settings
      'preferences': 'DOORASHOOYINKA',
      'notification_settings': 'Dejinta Ogeysiisyada',
      'notification_sub': 'Digniinaha qiimaha iyo cusbooneysiinta suuqa',
      'language': 'Luuqadda',
      'language_sub': 'Ingiriisi / Soomaali',
      'city_preferences': 'Magaalada la doortay',
      'city_pref_sub': 'Dooro magaalada suuqa ee aad jeceshahay',
      'select_preferred_city': 'Dooro Magaalada Aad Doorbidayso',
      'support': 'TAAKULEYNTA',
      'help_support': 'Caawimaad & Taageero',
      'help_sub': 'Su\'aalaha badanaa la weydiiyo iyo xiriirka taageerada',
      'privacy_policy': 'Sharciga Xogta Sirta ah',
      'privacy_sub': 'Shuruudaha iyo isticmaalka xogta',
      'logout': 'Ka Bax',
      'app_version': 'Nooca App-ka 2.4.0 (Dalag Stable)',
      'edit_profile': 'Wax ka beddel Astaanta',
      'change_photo': 'Beddel Sawirka',
      'name': 'Magaca',
      'city': 'Magaalada',
      'save': 'Keydi',
      'dark_mode': 'Habka Madow',
      'dark_mode_on': 'Madow',
      'dark_mode_off': 'Cad',

      // Help & support (chat)
      'help_chat': 'La Hadal Taageerada',
      'type_message': 'Qor fariintaada...',
      'send': 'Dir',
      'chat_greeting': 'Salaan! Sidee ayaan kuu caawin karnaa maanta?',
      'chat_auto_reply':
          'Waad ku mahadsan tahay fariintaada. Kooxda taageerada ayaa dhawaan kula soo xiriiri doonta.',

      // Privacy Policy
      'privacy_policy_title': 'Sharciga Xogta Sirta ah',
      'privacy_last_updated': 'La cusboonaysiiyay: 2024',
      'privacy_intro':
          'Dalag Intelligence ("annaga") waxay maamushaa application-ka mudnaanta ee Dalag. Boggan wuxuu sharaxayaa sida aan u ururino, u isticmaalno, una ilaalino xogtaada shakhsi ahaaneed marka aad isticmaalayso adeegga.',
      'privacy_data_collection_title': 'Xogta Aan Ururino',
      'privacy_data_collection_body':
          'Waxaan soo ururin karnaa magacaaga, iimaylkaaga, lambarka taleefannkaaga, magaaladaada, iyo xogta isticmaalka sida dhaqdhaqaaqa app-ka si aan u fidino oo aan u hagaajino adeegga.',
      'privacy_use_title': 'Sida Aan U Isticmaalno Xogtaada',
      'privacy_use_body':
          'Xogtaada waxaan u isticmaalnaa in aan ku shaqayno app-ka, kuu ogaysiino isbeddelka qiimaha, aan kuu bixino taageero, iyo in aan hagaajino sifooyinka macluumaadka suuqa.',
      'privacy_security_title': 'Amniga Xogta',
      'privacy_security_body':
          'Waxaan qaadanaa tallaabooyin macquul ah si aan u ilaalino xogtaada, laakiin habka kaydinta elektaroonigga ah 100% ammaan ma aha.',
      'privacy_contact_title': 'Nala Soo Xiriir',
      'privacy_contact_body':
          'Su\'aalo kasta oo ku saabsan sharciyadan, nagu soo xiriir: support@dalag.com',

      // Analysis chart
      'price_trend_title': 'Isbeddelka Qiimaha - 7 Maalmood',
      'price_trend_caption': 'Isbeddelka qiimaha Yaanyada ee %city',
      'mon': 'Isn',
      'tue': 'Tal',
      'wed': 'Arb',
      'thu': 'Kha',
      'fri': 'Jim',
      'sat': 'Sab',
      'sun': 'Axd',

      // Nav
      'home': 'Guriga',
      'markets': 'Suuqyada',
      'add': 'Dar',
      'settings': 'Dejinta',
    },
  };
}
