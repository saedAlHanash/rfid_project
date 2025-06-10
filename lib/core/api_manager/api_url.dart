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

  static const getAllLessons = 'lessons';

  static const getAllLessonsFree = 'lessons/free';

  static const getAllSeasons = 'seasons';

  static const getCourseProgress = 'courses/progress-user';

  static const getMe = 'auth/me';

  static const getAllNotifications = 'notification';

  static const getSocialMedia = 'social-media';

  static const privacyPolicy = 'privacy-policy';

  static const getAnnouncements = 'announcements';

  static const favorite = 'favorites';

  static const productById = 'products';
  static const products = 'products';
  static const search = 'search';

  static const offers = 'products/offers';
  static const bestSeller = 'products/best-seller';
  static const setting = 'settings';

  static const orders = 'orders';

  static const categoryById = 'category';
  static const subCategoryById = 'subCategory';

  static const coupon = 'carts/redeem-coupon';

  static const flashDeals = 'products/flash-deals';

  static const categories = 'categories';
  static const slider = 'ads/sliders';

  static const colors = 'colors';

  static const manufacturers = 'manufacturers';

  static const newArrivalProducts = 'products/new-arrivals';

  static const cart = 'carts';

  static const profile = 'setting/profile';

  static const orderById = 'orders';

  static const subCategories = 'categories/sub';

  static const governors = 'governorate';

  static const orderStatus = 'orders/statues';

  static const driverLocation = 'orders/coordinate';

  static const getMessages = 'drivers/messages';

  static const getSupportMessages = 'conversations';

  static const getRoomMessages = 'messages';

  static const faq = 'questions';

  static const termsAndConditions = 'pages';

  static const educationalGrade = 'educational-grade';
  static const educationalGradeSection = 'educational-grade/sections';

  static const teachersFilter = 'teacher/filter-teacher';

  static const teacher = 'teacher';

  static String lessons({required LessonsType getType}) {
    switch (getType) {
      case LessonsType.nun:
        return 'lesson/free';
      case LessonsType.adjacent:
        return 'lesson/adjacent-lessons';
      case LessonsType.teacher:
        return 'lesson/free-by-teacher';
      case LessonsType.chapter:
        return 'lesson/lesson-by-chapter';
      case LessonsType.suggestion:
        return 'lesson/free-suggestion';
    }
  }

  static String subjects({bool withGrad = true}) {
    return withGrad ? 'subject/by-educational-grade' : 'subject';
  }

  static String summaries({required Summaries getType}) {
    switch (getType) {
      case Summaries.free:
        return 'summary/free';
      case Summaries.teacherFree:
        return 'summary/free-by-teacher';
      case Summaries.teacher:
        return 'summary/by-teacher';
      case Summaries.student:
        return 'summary/student-summary';
    }
  }

  static const exams = 'exam';
  static const freeExams = 'exam/free-exams';

  static var examCategorized = 'exam/categorized';
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

const additionalConst = '/student/';

String get baseUrl {
  return live;
  // return test;
}

//
const live = 'e-learning.testbandtech.com';
const test = 'test-api.basma-academy.com';
