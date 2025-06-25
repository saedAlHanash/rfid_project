// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Invalid email`
  String get wrongEmail {
    return Intl.message(
      'Invalid email',
      name: 'wrongEmail',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Choosing`
  String get choosing {
    return Intl.message('Choosing', name: 'choosing', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Educational Grade`
  String get educationalGrade {
    return Intl.message(
      'Educational Grade',
      name: 'educationalGrade',
      desc: '',
      args: [],
    );
  }

  /// `Mail`
  String get mail {
    return Intl.message('Mail', name: 'mail', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Favorites`
  String get fav {
    return Intl.message('Favorites', name: 'fav', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrder {
    return Intl.message('My Orders', name: 'myOrder', desc: '', args: []);
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please create an account`
  String get pleasCreateAccount {
    return Intl.message(
      'Please create an account',
      name: 'pleasCreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get userName {
    return Intl.message('Username', name: 'userName', desc: '', args: []);
  }

  /// `Home Address`
  String get homeAddress {
    return Intl.message(
      'Home Address',
      name: 'homeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get region {
    return Intl.message('Region', name: 'region', desc: '', args: []);
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get rePassword {
    return Intl.message(
      'Confirm Password',
      name: 'rePassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Please check your internet connection`
  String get noInternet {
    return Intl.message(
      'Please check your internet connection',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `Name field is required`
  String get nameEmpty {
    return Intl.message(
      'Name field is required',
      name: 'nameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Phone number field is required`
  String get phoneNumberEmpty {
    return Intl.message(
      'Phone number field is required',
      name: 'phoneNumberEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Email field is required`
  String get emailEmpty {
    return Intl.message(
      'Email field is required',
      name: 'emailEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password field is required`
  String get passwordEmpty {
    return Intl.message(
      'Password field is required',
      name: 'passwordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get passwordNotMatch {
    return Intl.message(
      'Password does not match',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgetPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueTo {
    return Intl.message('Continue', name: 'continueTo', desc: '', args: []);
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Confirmation Code`
  String get confirmCode {
    return Intl.message(
      'Enter Confirmation Code',
      name: 'confirmCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation code sent to email: `
  String get codeSentToEmail {
    return Intl.message(
      'Confirmation code sent to email: ',
      name: 'codeSentToEmail',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Notifications`
  String get notification {
    return Intl.message(
      'Notifications',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Terms of Use and Privacy Policy`
  String get policy {
    return Intl.message(
      'Terms of Use and Privacy Policy',
      name: 'policy',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get policyJust {
    return Intl.message(
      'Privacy Policy',
      name: 'policyJust',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Contact Us`
  String get contact {
    return Intl.message('Contact Us', name: 'contact', desc: '', args: []);
  }

  /// `Change Name`
  String get changeName {
    return Intl.message('Change Name', name: 'changeName', desc: '', args: []);
  }

  /// `Change Phone Number`
  String get changePhone {
    return Intl.message(
      'Change Phone Number',
      name: 'changePhone',
      desc: '',
      args: [],
    );
  }

  /// `Change Address`
  String get changeAddress {
    return Intl.message(
      'Change Address',
      name: 'changeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePass {
    return Intl.message(
      'Change Password',
      name: 'changePass',
      desc: '',
      args: [],
    );
  }

  /// `Phone number cannot be changed`
  String get phoneNumberCanNotBeChange {
    return Intl.message(
      'Phone number cannot be changed',
      name: 'phoneNumberCanNotBeChange',
      desc: '',
      args: [],
    );
  }

  /// `Continue Sign Up`
  String get continueSignUp {
    return Intl.message(
      'Continue Sign Up',
      name: 'continueSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get wrongPhone {
    return Intl.message(
      'Invalid phone number',
      name: 'wrongPhone',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `يجب عليك إضافة بياناتك الخاصة لتسهيل التواصل معك`
  String get signInToContinue {
    return Intl.message(
      'يجب عليك إضافة بياناتك الخاصة لتسهيل التواصل معك',
      name: 'signInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message('Remember Me', name: 'rememberMe', desc: '', args: []);
  }

  /// `Don't Have An Account?`
  String get doNotHaveAnAccount {
    return Intl.message(
      'Don\'t Have An Account?',
      name: 'doNotHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In With Social Networks:`
  String get signInWithSocial {
    return Intl.message(
      'Sign In With Social Networks:',
      name: 'signInWithSocial',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Create New Account`
  String get createNewAccount {
    return Intl.message(
      'Create New Account',
      name: 'createNewAccount',
      desc: '',
      args: [],
    );
  }

  /// `يجب عليك إدخال بياناتك الصحيحة لتجنب المشاكل والأخطاء`
  String get addCorectData {
    return Intl.message(
      'يجب عليك إدخال بياناتك الصحيحة لتجنب المشاكل والأخطاء',
      name: 'addCorectData',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message('name', name: 'name', desc: '', args: []);
  }

  /// `birthday`
  String get birthday {
    return Intl.message('birthday', name: 'birthday', desc: '', args: []);
  }

  /// `The Phone Number Is 11 Digits`
  String get need11 {
    return Intl.message(
      'The Phone Number Is 11 Digits',
      name: 'need11',
      desc: '',
      args: [],
    );
  }

  /// `The Password Is More Than 8 Letters And Numbers`
  String get need8 {
    return Intl.message(
      'The Password Is More Than 8 Letters And Numbers',
      name: 'need8',
      desc: '',
      args: [],
    );
  }

  /// `confirm password`
  String get confirmPassword {
    return Intl.message(
      'confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already Have An Account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already Have An Account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In.`
  String get sgnIn {
    return Intl.message('Sign In.', name: 'sgnIn', desc: '', args: []);
  }

  /// `Please Choose How You Would Like To Send The Verification Code`
  String get confirmMethod {
    return Intl.message(
      'Please Choose How You Would Like To Send The Verification Code',
      name: 'confirmMethod',
      desc: '',
      args: [],
    );
  }

  /// `Phone Call`
  String get phoneCall {
    return Intl.message('Phone Call', name: 'phoneCall', desc: '', args: []);
  }

  /// `Phone SMS`
  String get phoneSms {
    return Intl.message('Phone SMS', name: 'phoneSms', desc: '', args: []);
  }

  /// `Enter Your OTP Code Here.`
  String get enterOTP {
    return Intl.message(
      'Enter Your OTP Code Here.',
      name: 'enterOTP',
      desc: '',
      args: [],
    );
  }

  /// `Didn't Receive The OTP?`
  String get didNotReceiveOTP {
    return Intl.message(
      'Didn\'t Receive The OTP?',
      name: 'didNotReceiveOTP',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message('Resend', name: 'resend', desc: '', args: []);
  }

  /// `verify`
  String get verify {
    return Intl.message('verify', name: 'verify', desc: '', args: []);
  }

  /// `Account Created!`
  String get accountCreated {
    return Intl.message(
      'Account Created!',
      name: 'accountCreated',
      desc: '',
      args: [],
    );
  }

  /// `Your Account Had Been Created`
  String get haveBeenCreated {
    return Intl.message(
      'Your Account Had Been Created',
      name: 'haveBeenCreated',
      desc: '',
      args: [],
    );
  }

  /// `Successfully.`
  String get successfully {
    return Intl.message(
      'Successfully.',
      name: 'successfully',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get confirmation {
    return Intl.message(
      'Confirmation',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Number Phone`
  String get numberPhone {
    return Intl.message(
      'Number Phone',
      name: 'numberPhone',
      desc: '',
      args: [],
    );
  }

  /// `Your Password Has\nBeen Reset!`
  String get passwordReset {
    return Intl.message(
      'Your Password Has\nBeen Reset!',
      name: 'passwordReset',
      desc: '',
      args: [],
    );
  }

  /// `save change`
  String get saveChange {
    return Intl.message('save change', name: 'saveChange', desc: '', args: []);
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Your Address`
  String get yourAddress {
    return Intl.message(
      'Your Address',
      name: 'yourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Your Phone`
  String get yourPhone {
    return Intl.message('Your Phone', name: 'yourPhone', desc: '', args: []);
  }

  /// `Your Name`
  String get yourName {
    return Intl.message('Your Name', name: 'yourName', desc: '', args: []);
  }

  /// `Your Email`
  String get yourEmail {
    return Intl.message('Your Email', name: 'yourEmail', desc: '', args: []);
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `first name`
  String get firstName {
    return Intl.message('first name', name: 'firstName', desc: '', args: []);
  }

  /// `Last name`
  String get lastName {
    return Intl.message('Last name', name: 'lastName', desc: '', args: []);
  }

  /// `Country`
  String get country {
    return Intl.message('Country', name: 'country', desc: '', args: []);
  }

  /// `Use Current Location`
  String get useCurrentLocation {
    return Intl.message(
      'Use Current Location',
      name: 'useCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `Registered Before`
  String get registeredBefore {
    return Intl.message(
      'Registered Before',
      name: 'registeredBefore',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get changeEmail {
    return Intl.message(
      'Change Email',
      name: 'changeEmail',
      desc: '',
      args: [],
    );
  }

  /// `My Info`
  String get myInfo {
    return Intl.message('My Info', name: 'myInfo', desc: '', args: []);
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message('My Orders', name: 'myOrders', desc: '', args: []);
  }

  /// `WishList`
  String get wishList {
    return Intl.message('WishList', name: 'wishList', desc: '', args: []);
  }

  /// `F.A.q`
  String get faq {
    return Intl.message('F.A.q', name: 'faq', desc: '', args: []);
  }

  /// `Terms And Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms And Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message('About Us', name: 'aboutUs', desc: '', args: []);
  }

  /// `Support`
  String get support {
    return Intl.message('Support', name: 'support', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Currency`
  String get currency {
    return Intl.message('Currency', name: 'currency', desc: '', args: []);
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Done resend code`
  String get done_resend_code {
    return Intl.message(
      'Done resend code',
      name: 'done_resend_code',
      desc: '',
      args: [],
    );
  }

  /// `Search In All`
  String get search_In_All {
    return Intl.message(
      'Search In All',
      name: 'search_In_All',
      desc: '',
      args: [],
    );
  }

  /// `Flash Deal`
  String get flash_deal {
    return Intl.message('Flash Deal', name: 'flash_deal', desc: '', args: []);
  }

  /// `See All`
  String get see_all {
    return Intl.message('See All', name: 'see_all', desc: '', args: []);
  }

  /// `Offer`
  String get offer {
    return Intl.message('Offer', name: 'offer', desc: '', args: []);
  }

  /// `Days`
  String get days {
    return Intl.message('Days', name: 'days', desc: '', args: []);
  }

  /// `Hours`
  String get hours {
    return Intl.message('Hours', name: 'hours', desc: '', args: []);
  }

  /// `seconds`
  String get seconds {
    return Intl.message('seconds', name: 'seconds', desc: '', args: []);
  }

  /// `Min`
  String get min {
    return Intl.message('Min', name: 'min', desc: '', args: []);
  }

  /// `Minutes`
  String get minutes {
    return Intl.message('Minutes', name: 'minutes', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Reviews`
  String get reviews {
    return Intl.message('Reviews', name: 'reviews', desc: '', args: []);
  }

  /// `Sizes`
  String get sizes {
    return Intl.message('Sizes', name: 'sizes', desc: '', args: []);
  }

  /// `Registered Before`
  String get registered_before {
    return Intl.message(
      'Registered Before',
      name: 'registered_before',
      desc: '',
      args: [],
    );
  }

  /// `Max`
  String get max {
    return Intl.message('Max', name: 'max', desc: '', args: []);
  }

  /// `Apply filters`
  String get apply_filters {
    return Intl.message(
      'Apply filters',
      name: 'apply_filters',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message('Color', name: 'color', desc: '', args: []);
  }

  /// `Colors`
  String get colors {
    return Intl.message('Colors', name: 'colors', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `New Check Your Email For\nConfirmation Link`
  String get new_check_email {
    return Intl.message(
      'New Check Your Email For\nConfirmation Link',
      name: 'new_check_email',
      desc: '',
      args: [],
    );
  }

  /// `Expiration`
  String get expiration {
    return Intl.message('Expiration', name: 'expiration', desc: '', args: []);
  }

  /// `Save For Later?`
  String get save_for_later {
    return Intl.message(
      'Save For Later?',
      name: 'save_for_later',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Confirm Address`
  String get confirm_address {
    return Intl.message(
      'Confirm Address',
      name: 'confirm_address',
      desc: '',
      args: [],
    );
  }

  /// `Cvc`
  String get cvc {
    return Intl.message('Cvc', name: 'cvc', desc: '', args: []);
  }

  /// `Card Name`
  String get card_name {
    return Intl.message('Card Name', name: 'card_name', desc: '', args: []);
  }

  /// `Card Number`
  String get card_number {
    return Intl.message('Card Number', name: 'card_number', desc: '', args: []);
  }

  /// `Payment Summary`
  String get payment_summary {
    return Intl.message(
      'Payment Summary',
      name: 'payment_summary',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `Filters`
  String get filters {
    return Intl.message('Filters', name: 'filters', desc: '', args: []);
  }

  /// `Additional service`
  String get additional_service {
    return Intl.message(
      'Additional service',
      name: 'additional_service',
      desc: '',
      args: [],
    );
  }

  /// `Order summary`
  String get order_summary {
    return Intl.message(
      'Order summary',
      name: 'order_summary',
      desc: '',
      args: [],
    );
  }

  /// `Coupon Code`
  String get coupon_code {
    return Intl.message('Coupon Code', name: 'coupon_code', desc: '', args: []);
  }

  /// `This Code Is Invalid CODE`
  String get code_invalid {
    return Intl.message(
      'This Code Is Invalid CODE',
      name: 'code_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Wishlist`
  String get wishlist {
    return Intl.message('Wishlist', name: 'wishlist', desc: '', args: []);
  }

  /// `Related Products`
  String get related_products {
    return Intl.message(
      'Related Products',
      name: 'related_products',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get add_to_cart {
    return Intl.message('Add To Cart', name: 'add_to_cart', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `New Arrival`
  String get new_arrival {
    return Intl.message('New Arrival', name: 'new_arrival', desc: '', args: []);
  }

  /// `Required`
  String get is_required {
    return Intl.message('Required', name: 'is_required', desc: '', args: []);
  }

  /// `Oops!`
  String get oops {
    return Intl.message('Oops!', name: 'oops', desc: '', args: []);
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password And Confirm.`
  String get enter_new_password_and_confirm {
    return Intl.message(
      'Enter New Password And Confirm.',
      name: 'enter_new_password_and_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `update`
  String get update {
    return Intl.message('update', name: 'update', desc: '', args: []);
  }

  /// `governor`
  String get governor {
    return Intl.message('governor', name: 'governor', desc: '', args: []);
  }

  /// `receiverPhone`
  String get receiverPhone {
    return Intl.message(
      'receiverPhone',
      name: 'receiverPhone',
      desc: '',
      args: [],
    );
  }

  /// `Select Governor`
  String get selectGovernor {
    return Intl.message(
      'Select Governor',
      name: 'selectGovernor',
      desc: '',
      args: [],
    );
  }

  /// `From Map`
  String get selectFromMap {
    return Intl.message('From Map', name: 'selectFromMap', desc: '', args: []);
  }

  /// `My Location`
  String get myLocation {
    return Intl.message('My Location', name: 'myLocation', desc: '', args: []);
  }

  /// `start with 07 and 11 digit`
  String get helperPhoneText {
    return Intl.message(
      'start with 07 and 11 digit',
      name: 'helperPhoneText',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, Your Search Is \nNot Available`
  String get emptySearch {
    return Intl.message(
      'Sorry, Your Search Is \nNot Available',
      name: 'emptySearch',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Requests`
  String get emptyCart {
    return Intl.message(
      'Sorry, There Are \nNo Requests',
      name: 'emptyCart',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Requests`
  String get emptyFav {
    return Intl.message(
      'Sorry, There Are \nNo Requests',
      name: 'emptyFav',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Offers`
  String get emptyOffers {
    return Intl.message(
      'Sorry, There Are \nNo Offers',
      name: 'emptyOffers',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Notifications`
  String get emptyNotifications {
    return Intl.message(
      'Sorry, There Are \nNo Notifications',
      name: 'emptyNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Orders`
  String get emptyOrders {
    return Intl.message(
      'Sorry, There Are \nNo Orders',
      name: 'emptyOrders',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Address`
  String get confirmAddress {
    return Intl.message(
      'Confirm Address',
      name: 'confirmAddress',
      desc: '',
      args: [],
    );
  }

  /// `Cash Payment`
  String get cashPayment {
    return Intl.message(
      'Cash Payment',
      name: 'cashPayment',
      desc: '',
      args: [],
    );
  }

  /// `E-Payment`
  String get ePayment {
    return Intl.message('E-Payment', name: 'ePayment', desc: '', args: []);
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Order Created`
  String get donePending {
    return Intl.message(
      'Order Created',
      name: 'donePending',
      desc: '',
      args: [],
    );
  }

  /// `Order Processed`
  String get doneProcessing {
    return Intl.message(
      'Order Processed',
      name: 'doneProcessing',
      desc: '',
      args: [],
    );
  }

  /// `Order Was Ready`
  String get doneReady {
    return Intl.message(
      'Order Was Ready',
      name: 'doneReady',
      desc: '',
      args: [],
    );
  }

  /// `Order Shipped`
  String get doneShipping {
    return Intl.message(
      'Order Shipped',
      name: 'doneShipping',
      desc: '',
      args: [],
    );
  }

  /// `Order Completed`
  String get doneCompleted {
    return Intl.message(
      'Order Completed',
      name: 'doneCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Order Canceled`
  String get doneCanceled {
    return Intl.message(
      'Order Canceled',
      name: 'doneCanceled',
      desc: '',
      args: [],
    );
  }

  /// ` PaymentFailed`
  String get donePaymentFailed {
    return Intl.message(
      ' PaymentFailed',
      name: 'donePaymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Order Returned`
  String get doneReturned {
    return Intl.message(
      'Order Returned',
      name: 'doneReturned',
      desc: '',
      args: [],
    );
  }

  /// `At`
  String get at {
    return Intl.message('At', name: 'at', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Processing`
  String get processing {
    return Intl.message('Processing', name: 'processing', desc: '', args: []);
  }

  /// `Ready`
  String get ready {
    return Intl.message('Ready', name: 'ready', desc: '', args: []);
  }

  /// `Shipping`
  String get shipping {
    return Intl.message('Shipping', name: 'shipping', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Canceled`
  String get canceled {
    return Intl.message('Canceled', name: 'canceled', desc: '', args: []);
  }

  /// `Payment Failed`
  String get paymentFailed {
    return Intl.message(
      'Payment Failed',
      name: 'paymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Returned`
  String get returned {
    return Intl.message('Returned', name: 'returned', desc: '', args: []);
  }

  /// `Not Yet`
  String get notYet {
    return Intl.message('Not Yet', name: 'notYet', desc: '', args: []);
  }

  /// `Tracking Order`
  String get trackingOrder {
    return Intl.message(
      'Tracking Order',
      name: 'trackingOrder',
      desc: '',
      args: [],
    );
  }

  /// `Your Order`
  String get yourOrder {
    return Intl.message('Your Order', name: 'yourOrder', desc: '', args: []);
  }

  /// `Delivery Date`
  String get deliveryDate {
    return Intl.message(
      'Delivery Date',
      name: 'deliveryDate',
      desc: '',
      args: [],
    );
  }

  /// `Ready To Deliver`
  String get readyToDeliver {
    return Intl.message(
      'Ready To Deliver',
      name: 'readyToDeliver',
      desc: '',
      args: [],
    );
  }

  /// `Estimated For`
  String get estimatedFor {
    return Intl.message(
      'Estimated For',
      name: 'estimatedFor',
      desc: '',
      args: [],
    );
  }

  /// `Pleas Set Your Address`
  String get pleasSetYourAddress {
    return Intl.message(
      'Pleas Set Your Address',
      name: 'pleasSetYourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Review Order`
  String get reviewOrder {
    return Intl.message(
      'Review Order',
      name: 'reviewOrder',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get en {
    return Intl.message('English', name: 'en', desc: '', args: []);
  }

  /// `Arabic`
  String get ar {
    return Intl.message('Arabic', name: 'ar', desc: '', args: []);
  }

  /// `Kurdish`
  String get ku {
    return Intl.message('Kurdish', name: 'ku', desc: '', args: []);
  }

  /// `Dollar`
  String get dollar {
    return Intl.message('Dollar', name: 'dollar', desc: '', args: []);
  }

  /// `Dinar`
  String get dinar {
    return Intl.message('Dinar', name: 'dinar', desc: '', args: []);
  }

  /// `Please Send Your Rating For The Product`
  String get setReview {
    return Intl.message(
      'Please Send Your Rating For The Product',
      name: 'setReview',
      desc: '',
      args: [],
    );
  }

  /// `No Reviews found`
  String get emptyReview {
    return Intl.message(
      'No Reviews found',
      name: 'emptyReview',
      desc: '',
      args: [],
    );
  }

  /// `Add Review`
  String get addReview {
    return Intl.message('Add Review', name: 'addReview', desc: '', args: []);
  }

  /// `Search Result`
  String get searchResult {
    return Intl.message(
      'Search Result',
      name: 'searchResult',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Sub Categories`
  String get subCategories {
    return Intl.message(
      'Sub Categories',
      name: 'subCategories',
      desc: '',
      args: [],
    );
  }

  /// `Rated`
  String get rated {
    return Intl.message('Rated', name: 'rated', desc: '', args: []);
  }

  /// `Sign In With Social Networks`
  String get signInWithSocialNetworks {
    return Intl.message(
      'Sign In With Social Networks',
      name: 'signInWithSocialNetworks',
      desc: '',
      args: [],
    );
  }

  /// `Done Payment`
  String get confirmPayment {
    return Intl.message(
      'Done Payment',
      name: 'confirmPayment',
      desc: '',
      args: [],
    );
  }

  /// `Please Log In to continue `
  String get needLogin {
    return Intl.message(
      'Please Log In to continue ',
      name: 'needLogin',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message('Product', name: 'product', desc: '', args: []);
  }

  /// `Your Location`
  String get yourLocation {
    return Intl.message(
      'Your Location',
      name: 'yourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Identity Image`
  String get identityImage {
    return Intl.message(
      'Identity Image',
      name: 'identityImage',
      desc: '',
      args: [],
    );
  }

  /// `Done Pick`
  String get donePick {
    return Intl.message('Done Pick', name: 'donePick', desc: '', args: []);
  }

  /// `Click To Update`
  String get clickToUpdate {
    return Intl.message(
      'Click To Update',
      name: 'clickToUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Profile Image`
  String get profileImage {
    return Intl.message(
      'Profile Image',
      name: 'profileImage',
      desc: '',
      args: [],
    );
  }

  /// `The code has been sent! If necessary, we can resend the code up to two additional times.`
  String get doneSendCode {
    return Intl.message(
      'The code has been sent! If necessary, we can resend the code up to two additional times.',
      name: 'doneSendCode',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a text message containing your verification code to the phone number: `
  String get doneSendSms {
    return Intl.message(
      'We have sent a text message containing your verification code to the phone number: ',
      name: 'doneSendSms',
      desc: '',
      args: [],
    );
  }

  /// `Remember Password`
  String get rememberPassword {
    return Intl.message(
      'Remember Password',
      name: 'rememberPassword',
      desc: '',
      args: [],
    );
  }

  /// `Success!`
  String get isSuccess {
    return Intl.message('Success!', name: 'isSuccess', desc: '', args: []);
  }

  /// `Teaching staff`
  String get teachingStaff {
    return Intl.message(
      'Teaching staff',
      name: 'teachingStaff',
      desc: '',
      args: [],
    );
  }

  /// `Lesson`
  String get lesson {
    return Intl.message('Lesson', name: 'lesson', desc: '', args: []);
  }

  /// `Follow`
  String get follow {
    return Intl.message('Follow', name: 'follow', desc: '', args: []);
  }

  /// `Un Follow`
  String get unFollow {
    return Intl.message('Un Follow', name: 'unFollow', desc: '', args: []);
  }

  /// `Courses`
  String get courses {
    return Intl.message('Courses', name: 'courses', desc: '', args: []);
  }

  /// `Free lessons`
  String get freeLesson {
    return Intl.message('Free lessons', name: 'freeLesson', desc: '', args: []);
  }

  /// `Free Summary`
  String get freeSummary {
    return Intl.message(
      'Free Summary',
      name: 'freeSummary',
      desc: '',
      args: [],
    );
  }

  /// `Summaries`
  String get summaries {
    return Intl.message('Summaries', name: 'summaries', desc: '', args: []);
  }

  /// `Educational Progress`
  String get educationalProgress {
    return Intl.message(
      'Educational Progress',
      name: 'educationalProgress',
      desc: '',
      args: [],
    );
  }

  /// `جميع إعدادات الإخطارات`
  String get subTitleNotification {
    return Intl.message(
      'جميع إعدادات الإخطارات',
      name: 'subTitleNotification',
      desc: '',
      args: [],
    );
  }

  /// `قفل الجهاز، أقفال التطبيقات`
  String get subTitlePassword {
    return Intl.message(
      'قفل الجهاز، أقفال التطبيقات',
      name: 'subTitlePassword',
      desc: '',
      args: [],
    );
  }

  /// `خدمه العملاء رسال واتصل`
  String get subTitleSupport {
    return Intl.message(
      'خدمه العملاء رسال واتصل',
      name: 'subTitleSupport',
      desc: '',
      args: [],
    );
  }

  /// `إعدادات القفل، مستشعر الحركة`
  String get subTitlePolicy {
    return Intl.message(
      'إعدادات القفل، مستشعر الحركة',
      name: 'subTitlePolicy',
      desc: '',
      args: [],
    );
  }

  /// `سوف يتم حذف الحساب بجميع البيانات والكورسات`
  String get subTitleDeleteAccount {
    return Intl.message(
      'سوف يتم حذف الحساب بجميع البيانات والكورسات',
      name: 'subTitleDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `رقم الإصدار`
  String get buildNumber {
    return Intl.message('رقم الإصدار', name: 'buildNumber', desc: '', args: []);
  }

  /// `تم التطوير بواسطة`
  String get devBy {
    return Intl.message('تم التطوير بواسطة', name: 'devBy', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Teachers`
  String get teachers {
    return Intl.message('Teachers', name: 'teachers', desc: '', args: []);
  }

  /// `Teacher`
  String get teacher {
    return Intl.message('Teacher', name: 'teacher', desc: '', args: []);
  }

  /// `Subscription`
  String get subscription {
    return Intl.message(
      'Subscription',
      name: 'subscription',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Your Phone`
  String get confirmYourPhone {
    return Intl.message(
      'Confirm Your Phone',
      name: 'confirmYourPhone',
      desc: '',
      args: [],
    );
  }

  /// `المجموعات`
  String get groups {
    return Intl.message('المجموعات', name: 'groups', desc: '', args: []);
  }

  /// `Change Educational Grade`
  String get changeEducationalGrade {
    return Intl.message(
      'Change Educational Grade',
      name: 'changeEducationalGrade',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats {
    return Intl.message('Chats', name: 'chats', desc: '', args: []);
  }

  /// `Choose how to receive your 2-step code:`
  String get chooseHowToReceiveYour2stepCode {
    return Intl.message(
      'Choose how to receive your 2-step code:',
      name: 'chooseHowToReceiveYour2stepCode',
      desc: '',
      args: [],
    );
  }

  /// `Send via SMS`
  String get sendViaSms {
    return Intl.message('Send via SMS', name: 'sendViaSms', desc: '', args: []);
  }

  /// `Send via WhatsApp`
  String get sendViaWhatsapp {
    return Intl.message(
      'Send via WhatsApp',
      name: 'sendViaWhatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `Get Code`
  String get getCode {
    return Intl.message('Get Code', name: 'getCode', desc: '', args: []);
  }

  /// `Search about...`
  String get searchAbout {
    return Intl.message(
      'Search about...',
      name: 'searchAbout',
      desc: '',
      args: [],
    );
  }

  /// `Start lesson`
  String get startLesson {
    return Intl.message(
      'Start lesson',
      name: 'startLesson',
      desc: '',
      args: [],
    );
  }

  /// `Course`
  String get course {
    return Intl.message('Course', name: 'course', desc: '', args: []);
  }

  /// `Worksheet`
  String get worksheet {
    return Intl.message('Worksheet', name: 'worksheet', desc: '', args: []);
  }

  /// `Worksheets`
  String get worksheets {
    return Intl.message('Worksheets', name: 'worksheets', desc: '', args: []);
  }

  /// `My courses`
  String get myCourses {
    return Intl.message('My courses', name: 'myCourses', desc: '', args: []);
  }

  /// `Sorry, there are no courses now.`
  String get sorryThereAreNoCoursesNow {
    return Intl.message(
      'Sorry, there are no courses now.',
      name: 'sorryThereAreNoCoursesNow',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, there are no working papers now.`
  String get sorryThereAreNoWorkingPapersNow {
    return Intl.message(
      'Sorry, there are no working papers now.',
      name: 'sorryThereAreNoWorkingPapersNow',
      desc: '',
      args: [],
    );
  }

  /// `Buy now`
  String get buyNow {
    return Intl.message('Buy now', name: 'buyNow', desc: '', args: []);
  }

  /// `To get exams, lessons and notes`
  String get toGetExamsLessonsAndNotes {
    return Intl.message(
      'To get exams, lessons and notes',
      name: 'toGetExamsLessonsAndNotes',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must start with 07`
  String get phoneNumberMustStartWith07 {
    return Intl.message(
      'Phone number must start with 07',
      name: 'phoneNumberMustStartWith07',
      desc: '',
      args: [],
    );
  }

  /// `Enter the verification code we just sent to your number`
  String get enterTheVerificationCodeWeJustSentToYourNumber {
    return Intl.message(
      'Enter the verification code we just sent to your number',
      name: 'enterTheVerificationCodeWeJustSentToYourNumber',
      desc: '',
      args: [],
    );
  }

  /// `I remembered my password`
  String get iRememberedMyPassword {
    return Intl.message(
      'I remembered my password',
      name: 'iRememberedMyPassword',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive the code?`
  String get didntReceiveTheCode {
    return Intl.message(
      'Didn\'t receive the code?',
      name: 'didntReceiveTheCode',
      desc: '',
      args: [],
    );
  }

  /// `Send code`
  String get sendCode {
    return Intl.message('Send code', name: 'sendCode', desc: '', args: []);
  }

  /// `Set a new password`
  String get setANewPassword {
    return Intl.message(
      'Set a new password',
      name: 'setANewPassword',
      desc: '',
      args: [],
    );
  }

  /// `The password must be more than 8 characters and numbers.`
  String get thePasswordMustBeMoreThan8CharactersAndNumbers {
    return Intl.message(
      'The password must be more than 8 characters and numbers.',
      name: 'thePasswordMustBeMoreThan8CharactersAndNumbers',
      desc: '',
      args: [],
    );
  }

  /// `You must enter your data correctly to avoid problems and errors.`
  String get youMustEnterYourDataCorrectlyToAvoidProblemsAnd {
    return Intl.message(
      'You must enter your data correctly to avoid problems and errors.',
      name: 'youMustEnterYourDataCorrectlyToAvoidProblemsAnd',
      desc: '',
      args: [],
    );
  }

  /// `Governorate`
  String get governorate {
    return Intl.message('Governorate', name: 'governorate', desc: '', args: []);
  }

  /// `Free exams`
  String get freeExams {
    return Intl.message('Free exams', name: 'freeExams', desc: '', args: []);
  }

  /// `Exam duration:`
  String get examDuration {
    return Intl.message(
      'Exam duration:',
      name: 'examDuration',
      desc: '',
      args: [],
    );
  }

  /// `Exam list`
  String get examList {
    return Intl.message('Exam list', name: 'examList', desc: '', args: []);
  }

  /// `Exam`
  String get exam {
    return Intl.message('Exam', name: 'exam', desc: '', args: []);
  }

  /// `New`
  String get new1 {
    return Intl.message('New', name: 'new1', desc: '', args: []);
  }

  /// `Under correction`
  String get underCorrection {
    return Intl.message(
      'Under correction',
      name: 'underCorrection',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get closed {
    return Intl.message('Closed', name: 'closed', desc: '', args: []);
  }

  /// `Paid exams`
  String get paidExams {
    return Intl.message('Paid exams', name: 'paidExams', desc: '', args: []);
  }

  /// `Free`
  String get free {
    return Intl.message('Free', name: 'free', desc: '', args: []);
  }

  /// `Paid`
  String get paid {
    return Intl.message('Paid', name: 'paid', desc: '', args: []);
  }

  /// `Started at:`
  String get startedAt {
    return Intl.message('Started at:', name: 'startedAt', desc: '', args: []);
  }

  /// `Finish duration`
  String get finishDuration {
    return Intl.message(
      'Finish duration',
      name: 'finishDuration',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message('Duration', name: 'duration', desc: '', args: []);
  }

  /// `True or false`
  String get trueOrFalse {
    return Intl.message(
      'True or false',
      name: 'trueOrFalse',
      desc: '',
      args: [],
    );
  }

  /// `Multiple choice`
  String get multipleChoice {
    return Intl.message(
      'Multiple choice',
      name: 'multipleChoice',
      desc: '',
      args: [],
    );
  }

  /// `Open ended`
  String get openEnded {
    return Intl.message('Open ended', name: 'openEnded', desc: '', args: []);
  }

  /// `Finished at:`
  String get finishedAt {
    return Intl.message('Finished at:', name: 'finishedAt', desc: '', args: []);
  }

  /// `Question`
  String get question {
    return Intl.message('Question', name: 'question', desc: '', args: []);
  }

  /// `Mark`
  String get mark {
    return Intl.message('Mark', name: 'mark', desc: '', args: []);
  }

  /// `Enter your answer`
  String get enterYourAnswer {
    return Intl.message(
      'Enter your answer',
      name: 'enterYourAnswer',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message('yes', name: 'yes', desc: '', args: []);
  }

  /// `Subject`
  String get subject {
    return Intl.message('Subject', name: 'subject', desc: '', args: []);
  }

  /// `Teacher of:`
  String get teacherOf {
    return Intl.message('Teacher of:', name: 'teacherOf', desc: '', args: []);
  }

  /// `Sections`
  String get sections {
    return Intl.message('Sections', name: 'sections', desc: '', args: []);
  }

  /// `Submit exam`
  String get submitExam {
    return Intl.message('Submit exam', name: 'submitExam', desc: '', args: []);
  }

  /// `and`
  String get and {
    return Intl.message('and', name: 'and', desc: '', args: []);
  }

  /// `month`
  String get month {
    return Intl.message('month', name: 'month', desc: '', args: []);
  }

  /// `day`
  String get day {
    return Intl.message('day', name: 'day', desc: '', args: []);
  }

  /// `hour`
  String get hour {
    return Intl.message('hour', name: 'hour', desc: '', args: []);
  }

  /// `minute`
  String get minute {
    return Intl.message('minute', name: 'minute', desc: '', args: []);
  }

  /// `second`
  String get second {
    return Intl.message('second', name: 'second', desc: '', args: []);
  }

  /// `Empty questions`
  String get emptyQuestions {
    return Intl.message(
      'Empty questions',
      name: 'emptyQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Exams`
  String get exams {
    return Intl.message('Exams', name: 'exams', desc: '', args: []);
  }

  /// `Exam Subject`
  String get examSubject {
    return Intl.message(
      'Exam Subject',
      name: 'examSubject',
      desc: '',
      args: [],
    );
  }

  /// `Exam status`
  String get examStatus {
    return Intl.message('Exam status', name: 'examStatus', desc: '', args: []);
  }

  /// `If you exit the application during the exam, the exam will be considered complete.`
  String get ifYouExitTheApplicationDuringTheExamTheExam {
    return Intl.message(
      'If you exit the application during the exam, the exam will be considered complete.',
      name: 'ifYouExitTheApplicationDuringTheExamTheExam',
      desc: '',
      args: [],
    );
  }

  /// `Start exam`
  String get startExam {
    return Intl.message('Start exam', name: 'startExam', desc: '', args: []);
  }

  /// `Exam status not allowed`
  String get examStatusNotAllowed {
    return Intl.message(
      'Exam status not allowed',
      name: 'examStatusNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Exam is paid`
  String get examIsPaid {
    return Intl.message('Exam is paid', name: 'examIsPaid', desc: '', args: []);
  }

  /// `Chapters`
  String get chapters {
    return Intl.message('Chapters', name: 'chapters', desc: '', args: []);
  }

  /// `Blocked by teacher`
  String get blockedByTeacher {
    return Intl.message(
      'Blocked by teacher',
      name: 'blockedByTeacher',
      desc: '',
      args: [],
    );
  }

  /// `Grades`
  String get grades {
    return Intl.message('Grades', name: 'grades', desc: '', args: []);
  }

  /// `You can change your study level later.`
  String get youCanChangeYourStudyLevelLater {
    return Intl.message(
      'You can change your study level later.',
      name: 'youCanChangeYourStudyLevelLater',
      desc: '',
      args: [],
    );
  }

  /// `Bandtech`
  String get bandtech {
    return Intl.message('Bandtech', name: 'bandtech', desc: '', args: []);
  }

  /// `Design, programming, property rights and publishing`
  String get designProgrammingPropertyRightsAndPublishing {
    return Intl.message(
      'Design, programming, property rights and publishing',
      name: 'designProgrammingPropertyRightsAndPublishing',
      desc: '',
      args: [],
    );
  }

  /// `Add product`
  String get addProduct {
    return Intl.message('Add product', name: 'addProduct', desc: '', args: []);
  }

  /// `Edit product`
  String get editProduct {
    return Intl.message(
      'Edit product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Remove product`
  String get removeProduct {
    return Intl.message(
      'Remove product',
      name: 'removeProduct',
      desc: '',
      args: [],
    );
  }

  /// `Transfer product`
  String get transferProduct {
    return Intl.message(
      'Transfer product',
      name: 'transferProduct',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message('Reports', name: 'reports', desc: '', args: []);
  }

  /// `Asset inventory`
  String get assetInventory {
    return Intl.message(
      'Asset inventory',
      name: 'assetInventory',
      desc: '',
      args: [],
    );
  }

  /// `Asset name`
  String get assetName {
    return Intl.message('Asset name', name: 'assetName', desc: '', args: []);
  }

  /// `department`
  String get department {
    return Intl.message('department', name: 'department', desc: '', args: []);
  }

  /// `Division`
  String get division {
    return Intl.message('Division', name: 'division', desc: '', args: []);
  }

  /// `Room`
  String get room {
    return Intl.message('Room', name: 'room', desc: '', args: []);
  }

  /// `Asset site`
  String get assetSite {
    return Intl.message('Asset site', name: 'assetSite', desc: '', args: []);
  }

  /// `Entity`
  String get entity {
    return Intl.message('Entity', name: 'entity', desc: '', args: []);
  }

  /// `Tag`
  String get tag {
    return Intl.message('Tag', name: 'tag', desc: '', args: []);
  }

  /// `If you wish to enter the sticker number manually`
  String get ifYouWishToEnterTheStickerNumberManually {
    return Intl.message(
      'If you wish to enter the sticker number manually',
      name: 'ifYouWishToEnterTheStickerNumberManually',
      desc: '',
      args: [],
    );
  }

  /// `Search for product`
  String get searchForProduct {
    return Intl.message(
      'Search for product',
      name: 'searchForProduct',
      desc: '',
      args: [],
    );
  }

  /// `clear`
  String get clear {
    return Intl.message('clear', name: 'clear', desc: '', args: []);
  }

  /// `Start`
  String get start {
    return Intl.message('Start', name: 'start', desc: '', args: []);
  }

  /// `save`
  String get save {
    return Intl.message('save', name: 'save', desc: '', args: []);
  }

  /// `Stop`
  String get stop {
    return Intl.message('Stop', name: 'stop', desc: '', args: []);
  }

  /// `Asset status`
  String get assetStatus {
    return Intl.message(
      'Asset status',
      name: 'assetStatus',
      desc: '',
      args: [],
    );
  }

  /// `Move product`
  String get moveProduct {
    return Intl.message(
      'Move product',
      name: 'moveProduct',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
