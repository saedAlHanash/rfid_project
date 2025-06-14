import '../strings/enum_manager.dart';

class GetUrl {
  static const exam = 'exam';

  static const temp = '';
  static const getHome = 'home';

  static var chapters = 'chapter/by-course';

  static var banner = '';
  static var banners = 'advertisement';

  static var group = '';

  static var groups = 'group';

  static var temps = '';

  static var getAllNotifications = '';

  static var profile = 'profile';

  //--------------

  static String courses(CourseType type) {
    switch (type) {
      case CourseType.educational:
        return 'course';
      case CourseType.teacher:
        return 'course/by-teacher';
      case CourseType.student:
        return 'course/student-course';
    }
  }
}

class PostUrl {
  static const createExam = 'exam';
  static const addReview = 'reviews';
  static const loginUrl = 'auth/login';
  static const signup = 'auth/register';

  static const forgetPassword = 'auth/forget-password';

  static const resetPassword = 'auth/reset-password';

  static const closeVideo = 'lesson/close-video';

  static const insertFireBaseToken = 'auth/me/update-fcm-token';
  static const uploadFile = 'add-images';

  static const insertCode = 'courses/insert-code';
  static const logout = 'logout';

  static const confirmCode = 'auth/verify-account';
  static const otpPassword = 'auth/reset-password';

  static const addFavorite = 'favorites';

  static const restPass = 'reset-password';

  static const createOrder = 'checkout/cash';
  static const createEPaymentOrder = 'checkout/credit';

  static const resendCode = 'auth/resend-verification-code';

  static const addToCart = 'carts';

  static const updateProfile = 'setting/update-profile';

  static const addSupportMessage = 'messages/add';

  static const loginSocial = 'social/login';
  static const addPhone = 'social/add-phone';

  static const socialVerifyPhone = 'social/verify-phone';

  static var changePassword = 'auth/change-password';
  static var payCourse = 'course/active';
  static var paySummary = 'summary/active';
  static var payExam = 'exam/active';

  static var createTemp = '';

  static var temps = '';

  static var createGroup = '';

  static String addMessage(int id) {
    return 'drivers/messages/$id/add';
  }

  static String increase(int id) {
    return 'carts/products/$id/quantity/increase';
  }

  static String decrease(int id) {
    return 'carts/products/$id/quantity/decrease';
  }
}

class PutUrl {
  static const updateExam = 'NON/Update';
  static const updateName = 'update-name';
  static const updatePhone = 'update-phone';
  static const updateAddress = 'update-address';

  static const follow = 'teacher/follow';
  static const like = 'lesson/like';
  static const desLike = 'lesson/unlike';

  static const startExam = 'exam/start-exam';
  static var updateTemp = '';

  static var updateGroup = '';
}

class DeleteUrl {
  static const deleteExam = 'NON/Delete';
  static const removeFavorite = 'favorites';

  static const removeFromCart = 'carts/products';

  static const clearCart = 'carts';

  static const deleteMyAccount = 'auth/delete-account';

  static var deleteTemp = '';

  static var deleteGroup = '';
}

const additionalConst = '/client/v1/';

String get baseUrl {
  return live;
  // return test;
}

//
const live = 'jaradalasul.com';
const test = 'jaradalasul.com';
