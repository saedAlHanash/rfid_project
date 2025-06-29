class GetUrl {
  static const entity = 'Entity/Get';
  static const room = 'Room/Get';
  static const division = 'Division/Get';
  static const department = 'Department/Get';
  static const product = 'asset-item';
  static const report = 'report';
  static const asset = 'asset';
  static const assets = 'asset';

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
  static const entities = 'entity';
  static const createEntity = 'Entity/Add';
  static const rooms = 'room';
  static const createRoom = 'Room/Add';
  static const divisions = 'division';
  static const createDivision = 'Division/Add';
  static const departments = 'department';
  static const createDepartment = 'Department/Add';
  static const products = 'asset-item';
  static const createProduct = 'product/Add';

  static const reports = 'report';
  static const createReport = 'report';
  static const assets = 'asset';
  static const createAsset = 'asset-item';
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
  static const updateEntity = 'Entity/Update';
  static const updateRoom = 'Room/Update';
  static const updateDivision = 'Division/Update';
  static const updateDepartment = 'Department/Update';
  static const updateProduct = 'product/Update';

  static const updateReport = 'report/Update';
  static const updateAsset = 'asset-item';

//
}

class DeleteUrl {
  static const deleteEntity = 'Entity/Delete';
  static const deleteRoom = 'Room/Delete';
  static const deleteDivision = 'Division/Delete';
  static const deleteDepartment = 'Department/Delete';
  static const deleteProduct = 'product/Delete';

  static const deleteReport = 'report/Delete';
  static const deleteAsset = 'asset-item/damage';

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
