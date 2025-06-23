import '../../generated/l10n.dart';
import '../util/pair_class.dart';

enum EnrollmentType { free, payed }

enum StartPage { login, home, signupOtp, passwordOtp }

enum GenderEnum {
  male,
  female;

  String get name {
    switch (this) {
      case GenderEnum.male:
        return 'ذكر';
      case GenderEnum.female:
        return 'أنثى';
    }
  }

  String get nameApi {
    switch (this) {
      case GenderEnum.male:
        return 'male';
      case GenderEnum.female:
        return 'female';
    }
  }
}

enum LessonsType { nun, teacher, chapter, suggestion, adjacent }

enum Summaries { free, teacherFree, teacher, student }

enum CourseType { educational, teacher, student }

enum PayType { course, summary, exam }

enum IraqGovernorate {
  baghdad,
  basra,
  nineveh,
  erbil,
  sulaymaniyah,
  dhiQar,
  anbar,
  najaf,
  karbala,
  diyala,
  muthanna,
  salahaddin,
  babil,
  kirkuk,
  wasit,
  dahuk,
  diwaniyah,
  maysan;

  LatLng get getGovernorateLatLng {
    switch (this) {
      case IraqGovernorate.baghdad:
        return LatLng(33.3152, 44.3661);
      case IraqGovernorate.basra:
        return LatLng(30.5085, 47.7804);
      case IraqGovernorate.nineveh:
        return LatLng(36.3350, 43.1189);
      case IraqGovernorate.erbil:
        return LatLng(36.1900, 44.0090);
      case IraqGovernorate.sulaymaniyah:
        return LatLng(35.5610, 45.4408);
      case IraqGovernorate.dhiQar:
        return LatLng(31.0420, 46.2570);
      case IraqGovernorate.anbar:
        return LatLng(33.4200, 43.3000);
      case IraqGovernorate.najaf:
        return LatLng(31.9950, 44.3140);
      case IraqGovernorate.karbala:
        return LatLng(32.6160, 44.0240);
      case IraqGovernorate.diyala:
        return LatLng(33.7500, 44.6400);
      case IraqGovernorate.muthanna:
        return LatLng(31.3090, 45.2800);
      case IraqGovernorate.salahaddin:
        return LatLng(34.6110, 43.6780);
      case IraqGovernorate.babil:
        return LatLng(32.4720, 44.4210);
      case IraqGovernorate.kirkuk:
        return LatLng(35.4680, 44.3920);
      case IraqGovernorate.wasit:
        return LatLng(32.5000, 45.8200);
      case IraqGovernorate.dahuk:
        return LatLng(36.8670, 42.9880);
      case IraqGovernorate.diwaniyah:
        return LatLng(31.9870, 44.9240);
      case IraqGovernorate.maysan:
        return LatLng(31.8350, 47.1440);
    }
  }

  String get name {
    switch (this) {
      case IraqGovernorate.baghdad:
        return 'بغداد';
      case IraqGovernorate.basra:
        return 'البصرة';
      case IraqGovernorate.nineveh:
        return 'نينوى';
      case IraqGovernorate.erbil:
        return 'أربيل';
      case IraqGovernorate.sulaymaniyah:
        return 'السليمانية';
      case IraqGovernorate.dhiQar:
        return 'ذي قار';
      case IraqGovernorate.anbar:
        return 'الأنبار';
      case IraqGovernorate.najaf:
        return 'النجف';
      case IraqGovernorate.karbala:
        return 'كربلاء';
      case IraqGovernorate.diyala:
        return 'ديالى';
      case IraqGovernorate.muthanna:
        return 'المثنى';
      case IraqGovernorate.salahaddin:
        return 'صلاح الدين';
      case IraqGovernorate.babil:
        return 'بابل';
      case IraqGovernorate.kirkuk:
        return 'كركوك';
      case IraqGovernorate.wasit:
        return 'واسط';
      case IraqGovernorate.dahuk:
        return 'دهوك';
      case IraqGovernorate.diwaniyah:
        return 'الديوانية';
      case IraqGovernorate.maysan:
        return 'ميسان';
    }
  }

  static IraqGovernorate getByName(String name) {
    return IraqGovernorate.values.firstWhere((g) => g.name == name, orElse: () => IraqGovernorate.baghdad);
  }
  //
  // static IraqGovernorate getByApproximateName(String inputName) {
  //   inputName = inputName.trim();
  //
  //   IraqGovernorate? bestMatch;
  //   double bestScore = 0;
  //
  //   for (final gov in IraqGovernorate.values) {
  //     final score = StringSimilarity.compareTwoStrings(inputName, gov.name);
  //     if (score > bestScore) {
  //       bestScore = score;
  //       bestMatch = gov;
  //     }
  //   }
  //
  //   // حدد الحد الأدنى لقبول التشابه (مثلاً 0.6)
  //   if (bestScore >= 0.6 && bestMatch != null) {
  //     return bestMatch;
  //   }
  //
  //   return IraqGovernorate.baghdad;
  // }
}

enum ApiType { get, post, put, patch, delete }

enum FontManager { regular, semeBold, bold }

enum VideoPlatform { youtube, dailymotion, vimeo, unknown }

enum ResendCodeType {
  sms,
  whatsapp;

  String get name {
    switch (this) {
      case ResendCodeType.sms:
        return 'رسالة نصية';
      case ResendCodeType.whatsapp:
        return 'واتس آب';
    }
  }

  String get nameApi {
    switch (this) {
      case ResendCodeType.sms:
        return 'SMS';
      case ResendCodeType.whatsapp:
        return 'WHATSAPP';
    }
  }
}

enum ExamStatus {
  newExam,
  underCorrection,
  completed;

  bool get isNewExam => this == newExam;

  bool get isUnderCorrection => this == underCorrection;

  bool get isCompleted => this == completed;

  String get name {
    switch (this) {
      case ExamStatus.newExam:
        return S().new1;
      case ExamStatus.underCorrection:
        return S().underCorrection;
      case ExamStatus.completed:
        return S().closed;
    }
  }

  static ExamStatus fromName(String name) {
    switch (name) {
      case 'new':
        return ExamStatus.newExam;
      case 'under_correction':
        return ExamStatus.underCorrection;
      case 'completed':
        return ExamStatus.completed;
    }
    return ExamStatus.newExam;
  }

  String get nameApi {
    switch (this) {
      case ExamStatus.newExam:
        return 'new';
      case ExamStatus.underCorrection:
        return 'under_correction';
      case ExamStatus.completed:
        return 'completed';
    }
  }
}

enum ExamType {
  free,
  paid;

  String get name {
    switch (this) {
      case ExamType.free:
        return S().free;
      case ExamType.paid:
        return S().paid;
    }
  }

  static ExamType fromName(String name) {
    switch (name) {
      case 'free':
        return ExamType.free;
      case 'paid':
        return ExamType.paid;
    }
    return ExamType.free;
  }

  String get nameApi {
    switch (this) {
      case ExamType.free:
        return 'free';
      case ExamType.paid:
        return 'paid';
    }
  }
}

enum QuestionType {
  trueOrFalse,
  multipleChoice,
  openEnded;

  bool get isTrueOrFalse => this == trueOrFalse;

  bool get isMultipleChoice => this == multipleChoice;

  bool get isOpenEnded => this == openEnded;

  String get name {
    switch (this) {
      case QuestionType.trueOrFalse:
        return S().trueOrFalse;
      case QuestionType.multipleChoice:
        return S().multipleChoice;
      case QuestionType.openEnded:
        return S().openEnded;
    }
  }

  static QuestionType fromName(String name) {
    switch (name) {
      case 'TrueOrFalse':
        return QuestionType.trueOrFalse;
      case 'MultipleChoice':
        return QuestionType.multipleChoice;
      case 'OpenEnded':
        return QuestionType.openEnded;
    }
    return QuestionType.trueOrFalse;
  }

  String get nameApi {
    switch (this) {
      case QuestionType.trueOrFalse:
        return 'TrueOrFalse';
      case QuestionType.multipleChoice:
        return 'MultipleChoice';
      case QuestionType.openEnded:
        return 'OpenEnded';
    }
  }
}
