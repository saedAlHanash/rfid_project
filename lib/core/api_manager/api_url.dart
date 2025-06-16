class GetUrl {
  static const product = 'product/Get';
  static const room = 'room/Get';
  static const department = 'department/Get';
  static const report = 'report/Get';
  static const asset = 'asset/Get';

  static var getAllNotifications = '';

  static var profile = 'profile';
  static const exam = 'exam';

  static const temp = '';
  static const getHome = 'home';

  static var chapters = 'chapter/by-course';

  static var banner = '';
  static var banners = 'advertisement';

  static var group = '';

  static var groups = 'group';

  static var temps = '';

//
}

class PostUrl {
  static const products = 'product/GetAll';
  static const createProduct = 'product/Add';
  static const rooms = 'room/GetAll';
  static const createRoom = 'room/Add';
  static const departments = 'department/GetAll';
  static const createDepartment = 'department/Add';
  static const reports = 'report/GetAll';
  static const createReport = 'report/Add';
  static const assets = 'asset/GetAll';
  static const createAsset = 'asset/Add';
  static const createExam = 'exam';
  static const addReview = 'reviews';
  static const loginUrl = 'auth/login';
  static const signup = 'auth/register';

  static const forgetPassword = 'auth/forget-password';

  static const resetPassword = 'auth/reset-password';

  static const closeVideo = 'lesson/close-video';

  static const insertFireBaseToken = 'auth/me/update-fcm-token';
  static const uploadFile = 'add-images';

  static var updateProfile;

  static var logout = 'auth/logout';
//
}

class PutUrl {
  static const updateProduct = 'product/Update';
  static const updateRoom = 'room/Update';
  static const updateDepartment = 'department/Update';
  static const updateReport = 'report/Update';
  static const updateAsset = 'asset/Update';

//
}

class DeleteUrl {
  static const deleteProduct = 'product/Delete';
  static const deleteRoom = 'room/Delete';
  static const deleteDepartment = 'department/Delete';
  static const deleteReport = 'report/Delete';
  static const deleteAsset = 'asset/Delete';

  static var deleteMyAccount = '';

//
}

class PatchUrl {
  //
}

const additionalConst = '/client/v1/';

String get baseUrl {
  return live;
  // return test;
}

//
const live = 'jaradalasul.com';
const test = 'jaradalasul.com';
