
import 'package:stu_tech/data/server/error_strings.dart';
import 'package:stu_tech/data/tools/file_importer.dart';
import 'package:stu_tech/data/tools/strings/string.dart';

Map<String, String> ruRU = {
  Strings.appName : 'stu_tech Mobile',
  Strings.noData:'Данные не найдены',
  ErrorStrings.badRequest : 'Неверный код статуса запроса ',
  ErrorStrings.formatError : 'Ошибка типа формата',
  ErrorStrings.noInternet : 'Интернет недоступен',
  ErrorStrings.unableToProcess : 'Невозможно переработать',
  ErrorStrings.unexpectedError : 'Неожиданная ошибка',
  ErrorStrings.unKnownError : 'Неожиданная ошибка',
  Strings.phoneOrPasswordWrong : 'Неверный номер мобильного телефона или пароль',

  // Support page
  Strings.write:"Писать",
  //bottom nav bar
  Strings.home : 'Главная',
  Strings.category : 'Категория',
  Strings.add : "Добавить",
  Strings.favorite : 'Избранные',
  Strings.profile : 'Профиль',
  // home page
  Strings.premium:'Премиум',
  Strings.search:"Поиск",
  Strings.showMore:"Показать больше",
  Strings.save: "Сохранять",
  Strings.updatePost: "Обновить",
  Strings.delete:"Удалить",
  Strings.removeFilter: "Удалить фильтр",
  Strings.productOfDay:"Oбъявления дня",

  //Order chat page
  Strings.showInfo: "Показать информацию",
  Strings.hideInfo: "Скрыть информацию",

  //filter page
  Strings.filters:'Фильтры',
  Strings.selectCategory:'Выберите категорию:',
  Strings.location:'Расположение',
  Strings.district:'Район города',
  Strings.select:'Выберите',
  Strings.price:'Цена:',
  Strings.from: "от",
  Strings.to: "до",
  Strings.sum: "сум",

  // Create post
  Strings.createPost:"Создать публикацию",
  Strings.enterTitle:"Введите название:",
  Strings.example:"Например: ткань 2м Х 2м",
  Strings.addPhoto:"Добавить фото",
  Strings.gallery:"Галерея",
  Strings.camera:"Камера",
  Strings.exit:"Выход",
  Strings.photoRequirement:"Размер фотографии не должен превышать 5 МБ",
  Strings.description: "Описание:",
  Strings.salePrice: "Цена в продаже:",
  Strings.cancel: "Отмена",
  Strings.yes: "Да",
  Strings.submit:"Готово",
  Strings.categoryInput:"Выберите категорию",
  Strings.sale:"Скидка",
  Strings.enterDiscountPrice:"Введите цену со скидкой!",
  Strings.addPostPhoto:'Добавте фото',
  Strings.addPostCategory:"Добавить категорию",
  Strings.addPostColor:"Выберите цвет",
  Strings.addPostSellType:"Выберите Тип продажи",
  Strings.cropper:"Обрезать",
  Strings.sellType:"Тип продажи",
  Strings.selectSellType:"Выберите тип продажи",
  Strings.selectColor:"Выберите цвет",
  Strings.discountGreater:"Цена со скидкой должна быть меньше первоначальной цены!",



  // profile page
  Strings.myAds : "Мои объявления",
  Strings.contactUs : "Связаться с нами",
  Strings.contactUsFull : "Свяжитесь с нами для предложений",
  Strings.categories : "Категории",
  Strings.support : "Поддержка",
  Strings.suggestionsAndComplaints: "Введите свои предложения и жалобы",
  Strings.myOrders : "Мои заказы",
  Strings.rules : "Условия",
  Strings.rateThisApp : "Оцените приложение",
  Strings.aboutTheApp : "О приложении",
  Strings.notifications : "Уведомления",
  Strings.selectLanguage : "Выберите язык",
  Strings.logOut : "Выход",
  Strings.updateDetail : "Имя пользователя обновлено",
  Strings.editName : "Изменить имя",
  Strings.editPhone : "Изменить номер",
  Strings.errorPhone : "Введите другой номер",
  Strings.phoneChanged : "Ваш номер изменен",
  Strings.profilePhotoUpdated : "Фотография пользователя обновлена",
  Strings.updatePhoto : "Обновить изображение",
  Strings.yourPostRemoved:'«Ваш пост удален!»',
  Strings.allOrders:'Все заказы',
  Strings.orderer:"Заказчик: ",
  Strings.phoneNumber:"Номер телефона: ",
  Strings.region:"Область",
  Strings.deleteAccount:"Удалить аккаунт",


  // start page
  Strings.welcome : "Добро пожаловать в stu_tech-Mobile",
  Strings.selectLangApp : "Выберите язык приложения",
  Strings.continue1 : "Продолжить",
  // login page
  Strings.signUp : "Регистрация",
  Strings.signIn : "Войти",
  Strings.enterName : "Введите имя",
  Strings.askSignIn : "Уже имеется аккаунт?",
  Strings.plzEnterValidNumber : "Пожалуйста, введите действующий номер мобильного телефона",
  Strings.mobileNumber : "мобильный номер",
  // verification page
  Strings.verification : "Верификация",
  Strings.resendCode : "Отправить код еще раз",
  Strings.sending : "Отправить",
  Strings.confirm : "Подтверждать",
  Strings.enterSms : "Введите СМС-код",
  // create password page
  Strings.createPassword : "Создать пароль",
  Strings.password : "Пароль",
  Strings.confirmPassword : "Подтвердите пароль",
  Strings.enterCharacter : "Введите не менее 6 символов для пароля",
  Strings.invalidPassword : "Пароль не соответствует",
  Strings.rulesOfUse : "Я ознакомился с \nправилами использования",
  // login page
  Strings.enterPassword : "Введите пароль",
  Strings.enterEmail: "Enter Email",
  Strings.forgotPassword : "Забыли пароль?",
  // password reset page
  Strings.passwordReset : "Восстановление пароля",
  // new password page
  Strings.newPassword : "Установить новый пароль",
  // post detail page
  Strings.aboutUser:"Пользователь:",
  Strings.comments:"Комментарии:",
  Strings.writeComment:"Написать комментарий",
  Strings.send:"Отправлять",
  Strings.userOtherPost:"Другие объявления пользователя",
  Strings.similarPosts:"Похожие объявления",
  Strings.orderButton:"Заказать",
  Strings.all:"Все",
  Strings.commentAmount:"Комментарий",
  Strings.commentTitle:"Комментарий",
  Strings.likeError:"Без аккаунта невозможно выполнить действие",


  //Order page
  Strings.post: "Oбъявления:",
  Strings.color: "Цвет:",
  Strings.quantity: "Количество:",
  Strings.type: "Тип:",
  Strings.enterPhone: "Номер телефона:",
  Strings.orderCreated: "Заказ создан",
  Strings.cancelled: "Отменено",
  Strings.youCancelled: "Ваш заказ отменен",
  Strings.undo: "Отменить",




  //user post
  Strings.we:"Мы",
  Strings.foundPost:" нашли объявления",
  Strings.youDeleteProduct:"Вы удалили свое объявление",

  //post order message
  Strings.messageSent:"Сообщение отправлено!",
  Strings.orderNumber:"Номер заказа:",
  Strings.orderAmount:"Количество заказов:",
  Strings.orderStatusCanceled:"Заказ отменен",


  // my Orders
  // others
  Strings.areYouSure:"Вы действительно хотите уйти?",
  Strings.areYouSureToDelete:"Вы уверены, что хотите удалить аккаунт?",

// long texts
  Strings.aboutAppFull:"stu_tech Ulgirji Textil – это современная и удобная онлайн-платформа."
      "Через эту платформу пользователи могут легко размещать свои "
      "текстильные изделия и зарабатывать на них."
      "Покупателям предоставляется широкий выбор и удобные возможности для заказа. "
      "Наше приложение позволяет каждому продавцу представить "
      "свои товары широкой аудитории и развивать свой бизнес.",



};