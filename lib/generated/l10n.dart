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

  /// `Sign Up`
  String get registration {
    return Intl.message('Sign Up', name: 'registration', desc: '', args: []);
  }

  /// `Log In`
  String get login {
    return Intl.message('Log In', name: 'login', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `I want to receive news via email`
  String get getNews {
    return Intl.message(
      'I want to receive news via email',
      name: 'getNews',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the terms of service`
  String get agreement {
    return Intl.message(
      'I agree to the terms of service',
      name: 'agreement',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up with:`
  String get logWith {
    return Intl.message('Sign Up with:', name: 'logWith', desc: '', args: []);
  }

  /// `I already have an account`
  String get haveAccount {
    return Intl.message(
      'I already have an account',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get register {
    return Intl.message('Sign Up', name: 'register', desc: '', args: []);
  }

  /// `Enter the verification code`
  String get inputCode {
    return Intl.message(
      'Enter the verification code',
      name: 'inputCode',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get entry {
    return Intl.message('Log In', name: 'entry', desc: '', args: []);
  }

  /// `Log In`
  String get singIn {
    return Intl.message('Log In', name: 'singIn', desc: '', args: []);
  }

  /// `Reset Password`
  String get recoveryPassword {
    return Intl.message(
      'Reset Password',
      name: 'recoveryPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter the email address linked to\nyour account`
  String get inputEmail {
    return Intl.message(
      'Enter the email address linked to\nyour account',
      name: 'inputEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send Email`
  String get sendEmail {
    return Intl.message('Send Email', name: 'sendEmail', desc: '', args: []);
  }

  /// `AI Assistants`
  String get aiAssistens {
    return Intl.message(
      'AI Assistants',
      name: 'aiAssistens',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get saveMessage {
    return Intl.message('Saved', name: 'saveMessage', desc: '', args: []);
  }

  /// `Enter your request`
  String get inputTextForSearch {
    return Intl.message(
      'Enter your request',
      name: 'inputTextForSearch',
      desc: '',
      args: [],
    );
  }

  /// `Hi, I'm Ed! I’m great at understanding screenshots and can help you quickly solve most issues with complex software and social media`
  String get helloWords {
    return Intl.message(
      'Hi, I\'m Ed! I’m great at understanding screenshots and can help you quickly solve most issues with complex software and social media',
      name: 'helloWords',
      desc: '',
      args: [],
    );
  }

  /// `Press {combination} or tap the voice recording icon\nto activate a screenshot and\nvoice command`
  String instruction(Object combination) {
    return Intl.message(
      'Press $combination or tap the voice recording icon\nto activate a screenshot and\nvoice command',
      name: 'instruction',
      desc: '',
      args: [combination],
    );
  }

  /// `Нет доступа к микрофону!\nПроверьте подключение микрофона в настройках`
  String get notConnectMicrophone {
    return Intl.message(
      'Нет доступа к микрофону!\nПроверьте подключение микрофона в настройках',
      name: 'notConnectMicrophone',
      desc: '',
      args: [],
    );
  }

  /// `Current Plan`
  String get nowTariff {
    return Intl.message('Current Plan', name: 'nowTariff', desc: '', args: []);
  }

  /// `Token balance`
  String get counterToken {
    return Intl.message(
      'Token balance',
      name: 'counterToken',
      desc: '',
      args: [],
    );
  }

  /// `Manage Subscription`
  String get subsribeManagment {
    return Intl.message(
      'Manage Subscription',
      name: 'subsribeManagment',
      desc: '',
      args: [],
    );
  }

  /// `Manage Account`
  String get settingHotKey {
    return Intl.message(
      'Manage Account',
      name: 'settingHotKey',
      desc: '',
      args: [],
    );
  }

  /// `Voice Selection`
  String get voiceChange {
    return Intl.message(
      'Voice Selection',
      name: 'voiceChange',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message('Support', name: 'support', desc: '', args: []);
  }

  /// `Account`
  String get profileTitle {
    return Intl.message('Account', name: 'profileTitle', desc: '', args: []);
  }

  /// `Cancel Subscription`
  String get cancelSubscribe {
    return Intl.message(
      'Cancel Subscription',
      name: 'cancelSubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Add Funds`
  String get replenishBalace {
    return Intl.message(
      'Add Funds',
      name: 'replenishBalace',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get historyOperation {
    return Intl.message(
      'History',
      name: 'historyOperation',
      desc: '',
      args: [],
    );
  }

  /// `Balance Top Up`
  String get balanceReplenishment {
    return Intl.message(
      'Balance Top Up',
      name: 'balanceReplenishment',
      desc: '',
      args: [],
    );
  }

  /// `Other Plans`
  String get anotherRates {
    return Intl.message(
      'Other Plans',
      name: 'anotherRates',
      desc: '',
      args: [],
    );
  }

  /// `Card number`
  String get cardNumber {
    return Intl.message('Card number', name: 'cardNumber', desc: '', args: []);
  }

  /// `Expires on`
  String get validiyTo {
    return Intl.message('Expires on', name: 'validiyTo', desc: '', args: []);
  }

  /// `CVV`
  String get cvv {
    return Intl.message('CVV', name: 'cvv', desc: '', args: []);
  }

  /// `Top Up`
  String get topUp {
    return Intl.message('Top Up', name: 'topUp', desc: '', args: []);
  }

  /// `Enter amount`
  String get inputBalance {
    return Intl.message(
      'Enter amount',
      name: 'inputBalance',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Cancel Subscription`
  String get canceledSubscribe {
    return Intl.message(
      'Cancel Subscription',
      name: 'canceledSubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Default shortcut`
  String get nowHotKey {
    return Intl.message(
      'Default shortcut',
      name: 'nowHotKey',
      desc: '',
      args: [],
    );
  }

  /// `Press Alt+X to activate the screen and enable voice input. You can customize this to your preferred hotkeys:`
  String get hotKeySetDescription {
    return Intl.message(
      'Press Alt+X to activate the screen and enable voice input. You can customize this to your preferred hotkeys:',
      name: 'hotKeySetDescription',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `It looks like something went wrong!`
  String get appErrorDescription {
    return Intl.message(
      'It looks like something went wrong!',
      name: 'appErrorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Manage Account`
  String get accountManagment {
    return Intl.message(
      'Manage Account',
      name: 'accountManagment',
      desc: '',
      args: [],
    );
  }

  /// `Add new card`
  String get addNewCard {
    return Intl.message('Add new card', name: 'addNewCard', desc: '', args: []);
  }

  /// `Your card`
  String get yourCard {
    return Intl.message('Your card', name: 'yourCard', desc: '', args: []);
  }

  /// `Link`
  String get addCard {
    return Intl.message('Link', name: 'addCard', desc: '', args: []);
  }

  /// `Top Up`
  String get topUpBalance {
    return Intl.message('Top Up', name: 'topUpBalance', desc: '', args: []);
  }

  /// `Subscription successfully canceled`
  String get subscribeSuccessCanceled {
    return Intl.message(
      'Subscription successfully canceled',
      name: 'subscribeSuccessCanceled',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel your subscription?`
  String get warningWithCanceledSubscribe {
    return Intl.message(
      'Are you sure you want to cancel your subscription?',
      name: 'warningWithCanceledSubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Voice selection`
  String get voiceSelection {
    return Intl.message(
      'Voice selection',
      name: 'voiceSelection',
      desc: '',
      args: [],
    );
  }

  /// `Social networks`
  String get socialNetworks {
    return Intl.message(
      'Social networks',
      name: 'socialNetworks',
      desc: '',
      args: [],
    );
  }

  /// `Any other questions? Contact us`
  String get haveQuestions {
    return Intl.message(
      'Any other questions? Contact us',
      name: 'haveQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Activate`
  String get activate {
    return Intl.message('Activate', name: 'activate', desc: '', args: []);
  }

  /// `Plan successfully changed`
  String get successChangeRate {
    return Intl.message(
      'Plan successfully changed',
      name: 'successChangeRate',
      desc: '',
      args: [],
    );
  }

  /// `Plan Activation`
  String get activatePlanTitle {
    return Intl.message(
      'Plan Activation',
      name: 'activatePlanTitle',
      desc: '',
      args: [],
    );
  }

  /// `Combination save: {keyCombination}`
  String keycombinationSave(Object keyCombination) {
    return Intl.message(
      'Combination save: $keyCombination',
      name: 'keycombinationSave',
      desc: '',
      args: [keyCombination],
    );
  }

  /// `Press key...`
  String get pressKey {
    return Intl.message('Press key...', name: 'pressKey', desc: '', args: []);
  }

  /// `Hot Key customization`
  String get hotKeyCustomization {
    return Intl.message(
      'Hot Key customization',
      name: 'hotKeyCustomization',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while sending a message`
  String get errorSendMessage {
    return Intl.message(
      'An error occurred while sending a message',
      name: 'errorSendMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete account and all data`
  String get deleteAccountAndAllData {
    return Intl.message(
      'Delete account and all data',
      name: 'deleteAccountAndAllData',
      desc: '',
      args: [],
    );
  }

  /// `This action is irreversible`
  String get thisActionIsIrreversible {
    return Intl.message(
      'This action is irreversible',
      name: 'thisActionIsIrreversible',
      desc: '',
      args: [],
    );
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

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Account Management`
  String get accountManagement {
    return Intl.message(
      'Account Management',
      name: 'accountManagement',
      desc: '',
      args: [],
    );
  }

  /// `Coped text!`
  String get textCoped {
    return Intl.message('Coped text!', name: 'textCoped', desc: '', args: []);
  }

  /// `Open`
  String get open {
    return Intl.message('Open', name: 'open', desc: '', args: []);
  }

  /// `Closed`
  String get closed {
    return Intl.message('Closed', name: 'closed', desc: '', args: []);
  }

  /// `Ed Helper, a helper app for your project`
  String get edHelperAHelperAppForYourProject {
    return Intl.message(
      'Ed Helper, a helper app for your project',
      name: 'edHelperAHelperAppForYourProject',
      desc: '',
      args: [],
    );
  }

  /// `No chats created.`
  String get noChatHistory {
    return Intl.message(
      'No chats created.',
      name: 'noChatHistory',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to your account`
  String get logInAcc {
    return Intl.message(
      'Sign in to your account',
      name: 'logInAcc',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Create chat`
  String get createChat {
    return Intl.message('Create chat', name: 'createChat', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Chat`
  String get chat {
    return Intl.message('Chat', name: 'chat', desc: '', args: []);
  }

  /// `All rights reserved`
  String get allRightsResevered {
    return Intl.message(
      'All rights reserved',
      name: 'allRightsResevered',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contacts {
    return Intl.message('Contacts', name: 'contacts', desc: '', args: []);
  }

  /// `What customers are saying`
  String get customersReviews {
    return Intl.message(
      'What customers are saying',
      name: 'customersReviews',
      desc: '',
      args: [],
    );
  }

  /// `Learn how to use it in 30 seconds!`
  String get learnHowToUse {
    return Intl.message(
      'Learn how to use it in 30 seconds!',
      name: 'learnHowToUse',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message('Download', name: 'download', desc: '', args: []);
  }

  /// `Assistance in training a variety of neural networks available on the market:`
  String get assistanceInTrainingAVarietyOfNeuralNetworksAvailableOn {
    return Intl.message(
      'Assistance in training a variety of neural networks available on the market:',
      name: 'assistanceInTrainingAVarietyOfNeuralNetworksAvailableOn',
      desc: '',
      args: [],
    );
  }

  /// `Clear instructions (text, video, screenshots) for solving any problems in complex software:`
  String get clearInstructionsTextVideoScreenshotsForSolvingAnyProblemsIn {
    return Intl.message(
      'Clear instructions (text, video, screenshots) for solving any problems in complex software:',
      name: 'clearInstructionsTextVideoScreenshotsForSolvingAnyProblemsIn',
      desc: '',
      args: [],
    );
  }

  /// `ED Helper  Features`
  String get edHelperFeatures {
    return Intl.message(
      'ED Helper  Features',
      name: 'edHelperFeatures',
      desc: '',
      args: [],
    );
  }

  /// `No file selected`
  String get noFileSelected {
    return Intl.message(
      'No file selected',
      name: 'noFileSelected',
      desc: '',
      args: [],
    );
  }

  /// `No more searching through forums or YouTube.  I provide clear GIF instructions for a wide range of questions about neural networks and complex software. What do you need help with?`
  String get askMeAnythingAboutComplexSoftwareAndNeuralNetworksillHelp {
    return Intl.message(
      'No more searching through forums or YouTube.  I provide clear GIF instructions for a wide range of questions about neural networks and complex software. What do you need help with?',
      name: 'askMeAnythingAboutComplexSoftwareAndNeuralNetworksillHelp',
      desc: '',
      args: [],
    );
  }

  /// `Hi there! My name is Ed!`
  String get hiThereMyNameIsEd {
    return Intl.message(
      'Hi there! My name is Ed!',
      name: 'hiThereMyNameIsEd',
      desc: '',
      args: [],
    );
  }

  /// `Boost your learning and work efficiency multiple times!`
  String get boostYourLearningAndWorkEfficiencyMultipleTimes {
    return Intl.message(
      'Boost your learning and work efficiency multiple times!',
      name: 'boostYourLearningAndWorkEfficiencyMultipleTimes',
      desc: '',
      args: [],
    );
  }

  /// `for complex software and neural networks`
  String get forComplexSoftwareAndNeuralNetworks {
    return Intl.message(
      'for complex software and neural networks',
      name: 'forComplexSoftwareAndNeuralNetworks',
      desc: '',
      args: [],
    );
  }

  /// `Multimedia`
  String get multimedia {
    return Intl.message('Multimedia', name: 'multimedia', desc: '', args: []);
  }

  /// `AI assistant`
  String get aiAssistant {
    return Intl.message(
      'AI assistant',
      name: 'aiAssistant',
      desc: '',
      args: [],
    );
  }

  /// `Enter your application text`
  String get enterYourApplicationText {
    return Intl.message(
      'Enter your application text',
      name: 'enterYourApplicationText',
      desc: '',
      args: [],
    );
  }

  /// `Error sending question!`
  String get errorSendingQuestion {
    return Intl.message(
      'Error sending question!',
      name: 'errorSendingQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Question sent successfully!`
  String get questionSentSuccessfully {
    return Intl.message(
      'Question sent successfully!',
      name: 'questionSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `You need to be logged in to send a question`
  String get youNeedToBeLoggedInToSendAQuestion {
    return Intl.message(
      'You need to be logged in to send a question',
      name: 'youNeedToBeLoggedInToSendAQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `You don't have a tariff`
  String get youDontHaveATariff {
    return Intl.message(
      'You don\'t have a tariff',
      name: 'youDontHaveATariff',
      desc: '',
      args: [],
    );
  }

  /// `Your account is not connected`
  String get yourAccountIsNotConnected {
    return Intl.message(
      'Your account is not connected',
      name: 'yourAccountIsNotConnected',
      desc: '',
      args: [],
    );
  }

  /// `Error loading user`
  String get errorLoadingUser {
    return Intl.message(
      'Error loading user',
      name: 'errorLoadingUser',
      desc: '',
      args: [],
    );
  }

  /// `Choose File`
  String get chooseFile {
    return Intl.message('Choose File', name: 'chooseFile', desc: '', args: []);
  }

  /// `Error uploading file. Please try again.`
  String get errorUploadingFilePleaseTryAgain {
    return Intl.message(
      'Error uploading file. Please try again.',
      name: 'errorUploadingFilePleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `To access advanced features, download the app`
  String get toAccessAdvancedFeaturesDownloadTheApp {
    return Intl.message(
      'To access advanced features, download the app',
      name: 'toAccessAdvancedFeaturesDownloadTheApp',
      desc: '',
      args: [],
    );
  }

  /// `DOWNLOAD THE APP`
  String get downloadApp {
    return Intl.message(
      'DOWNLOAD THE APP',
      name: 'downloadApp',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `Delete successfully!`
  String get deleteSuccessfully {
    return Intl.message(
      'Delete successfully!',
      name: 'deleteSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `There was an error`
  String get thereWasAnError {
    return Intl.message(
      'There was an error',
      name: 'thereWasAnError',
      desc: '',
      args: [],
    );
  }

  /// `History is empty`
  String get historyIsEmpty {
    return Intl.message(
      'History is empty',
      name: 'historyIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Update Successfully`
  String get updateSuccessfully {
    return Intl.message(
      'Update Successfully',
      name: 'updateSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Update Failed`
  String get updateFailed {
    return Intl.message(
      'Update Failed',
      name: 'updateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Delete Failed`
  String get deleteFailed {
    return Intl.message(
      'Delete Failed',
      name: 'deleteFailed',
      desc: '',
      args: [],
    );
  }

  /// `Straight-to-the-point instructions – only precise steps for working with complex software:`
  String
  get straighttothepointInstructionsOnlyPreciseStepsForWorkingWithComplexSoftware {
    return Intl.message(
      'Straight-to-the-point instructions – only precise steps for working with complex software:',
      name:
          'straighttothepointInstructionsOnlyPreciseStepsForWorkingWithComplexSoftware',
      desc: '',
      args: [],
    );
  }

  /// `Select language`
  String get selectLanguage {
    return Intl.message(
      'Select language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Annual`
  String get annual {
    return Intl.message('Annual', name: 'annual', desc: '', args: []);
  }

  /// `Monthly`
  String get monthly {
    return Intl.message('Monthly', name: 'monthly', desc: '', args: []);
  }

  /// `Unsubscribe error`
  String get unsubscribeError {
    return Intl.message(
      'Unsubscribe error',
      name: 'unsubscribeError',
      desc: '',
      args: [],
    );
  }

  /// `for working with`
  String get forWorkingWith {
    return Intl.message(
      'for working with',
      name: 'forWorkingWith',
      desc: '',
      args: [],
    );
  }

  /// `How to animate a character using AI?`
  String get howToAnimateACharacterUsingAi {
    return Intl.message(
      'How to animate a character using AI?',
      name: 'howToAnimateACharacterUsingAi',
      desc: '',
      args: [],
    );
  }

  /// `How to create VFX graphics on an existing video?`
  String get howToCreateVfxGraphicsOnAnExistingVideo {
    return Intl.message(
      'How to create VFX graphics on an existing video?',
      name: 'howToCreateVfxGraphicsOnAnExistingVideo',
      desc: '',
      args: [],
    );
  }

  /// `How to speed up modeling and rendering in 3ds Max?`
  String get howToSpeedUpModelingAndRenderingIn3dsMax {
    return Intl.message(
      'How to speed up modeling and rendering in 3ds Max?',
      name: 'howToSpeedUpModelingAndRenderingIn3dsMax',
      desc: '',
      args: [],
    );
  }

  /// `Advanced animation tools in Blender??`
  String get advancedAnimationToolsInBlender {
    return Intl.message(
      'Advanced animation tools in Blender??',
      name: 'advancedAnimationToolsInBlender',
      desc: '',
      args: [],
    );
  }

  /// `How to generate concept art in Midjourney?`
  String get howToGenerateConceptArtInMidjourney {
    return Intl.message(
      'How to generate concept art in Midjourney?',
      name: 'howToGenerateConceptArtInMidjourney',
      desc: '',
      args: [],
    );
  }

  /// `Instant Answers to Any Question`
  String get instantAnswersToAnyQuestion {
    return Intl.message(
      'Instant Answers to Any Question',
      name: 'instantAnswersToAnyQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Ask a question – get an accurate answer in seconds`
  String get askAQuestionGetAnAccurateAnswerInSeconds {
    return Intl.message(
      'Ask a question – get an accurate answer in seconds',
      name: 'askAQuestionGetAnAccurateAnswerInSeconds',
      desc: '',
      args: [],
    );
  }

  /// `Clear Solutions Without Unnecessary Text`
  String get clearSolutionsWithoutUnnecessaryText {
    return Intl.message(
      'Clear Solutions Without Unnecessary Text',
      name: 'clearSolutionsWithoutUnnecessaryText',
      desc: '',
      args: [],
    );
  }

  /// `Step-by-step GIF instructions instead of long videos and boring lectures`
  String get stepbystepGifInstructionsInsteadOfLongVideosAndBoringLectures {
    return Intl.message(
      'Step-by-step GIF instructions instead of long videos and boring lectures',
      name: 'stepbystepGifInstructionsInsteadOfLongVideosAndBoringLectures',
      desc: '',
      args: [],
    );
  }

  /// `24/7 Support with No Waiting`
  String get supportWithNoWaiting {
    return Intl.message(
      '24/7 Support with No Waiting',
      name: 'supportWithNoWaiting',
      desc: '',
      args: [],
    );
  }

  /// `Help is always at hand whenever you need it`
  String get helpIsAlwaysAtHandWheneverYouNeedIt {
    return Intl.message(
      'Help is always at hand whenever you need it',
      name: 'helpIsAlwaysAtHandWheneverYouNeedIt',
      desc: '',
      args: [],
    );
  }

  /// `Easy File and Voice Message Sharing`
  String get easyFileAndVoiceMessageSharing {
    return Intl.message(
      'Easy File and Voice Message Sharing',
      name: 'easyFileAndVoiceMessageSharing',
      desc: '',
      args: [],
    );
  }

  /// `Send screenshots, audio, and documents in one click – get a quick response`
  String get sendScreenshotsAudioAndDocumentsInOneClickGetA {
    return Intl.message(
      'Send screenshots, audio, and documents in one click – get a quick response',
      name: 'sendScreenshotsAudioAndDocumentsInOneClickGetA',
      desc: '',
      args: [],
    );
  }

  /// `Automation for Work and Learning`
  String get automationForWorkAndLearning {
    return Intl.message(
      'Automation for Work and Learning',
      name: 'automationForWorkAndLearning',
      desc: '',
      args: [],
    );
  }

  /// `Fast file analysis, text generation, smart suggestions, translation, website analysis, and more`
  String
  get fastFileAnalysisTextGenerationSmartSuggestionsTranslationWebsiteAnalysis {
    return Intl.message(
      'Fast file analysis, text generation, smart suggestions, translation, website analysis, and more',
      name:
          'fastFileAnalysisTextGenerationSmartSuggestionsTranslationWebsiteAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Save Time and Effort`
  String get saveTimeAndEffort {
    return Intl.message(
      'Save Time and Effort',
      name: 'saveTimeAndEffort',
      desc: '',
      args: [],
    );
  }

  /// `Forget endless searches for information – solve tasks instantly`
  String get forgetEndlessSearchesForInformationSolveTasksInstantly {
    return Intl.message(
      'Forget endless searches for information – solve tasks instantly',
      name: 'forgetEndlessSearchesForInformationSolveTasksInstantly',
      desc: '',
      args: [],
    );
  }

  /// `Anna, 27 years old`
  String get anna27YearsOld {
    return Intl.message(
      'Anna, 27 years old',
      name: 'anna27YearsOld',
      desc: '',
      args: [],
    );
  }

  /// `3D visualizer`
  String get dVisualizer {
    return Intl.message(
      '3D visualizer',
      name: 'dVisualizer',
      desc: '',
      args: [],
    );
  }

  /// `I used to have to spend hours scouring forums, reading complex articles, and watching dozens of video tutorials to figure out 3ds Max. ED-helper has solved this problem! Now I can ask a question and get an accurate answer in a few seconds. My training has accelerated at least ten times!`
  String get iUsedToHaveToSpendHoursScouringForumsReading {
    return Intl.message(
      'I used to have to spend hours scouring forums, reading complex articles, and watching dozens of video tutorials to figure out 3ds Max. ED-helper has solved this problem! Now I can ask a question and get an accurate answer in a few seconds. My training has accelerated at least ten times!',
      name: 'iUsedToHaveToSpendHoursScouringForumsReading',
      desc: '',
      args: [],
    );
  }

  /// `Olga, 22 years old`
  String get olga22YearsOld {
    return Intl.message(
      'Olga, 22 years old',
      name: 'olga22YearsOld',
      desc: '',
      args: [],
    );
  }

  /// `Student`
  String get student {
    return Intl.message('Student', name: 'student', desc: '', args: []);
  }

  /// `I'm studying to become an architect and started using ArchiCAD quite recently. Without the help of "Edik," as I affectionately call ED-Helper, I think I would have been lost in a sea of video tutorials. Now any difficulty is solved instantly. Studying has become much more effective.`
  String get imStudyingToBecomeAnArchitectAndStartedUsingArchicad {
    return Intl.message(
      'I\'m studying to become an architect and started using ArchiCAD quite recently. Without the help of "Edik," as I affectionately call ED-Helper, I think I would have been lost in a sea of video tutorials. Now any difficulty is solved instantly. Studying has become much more effective.',
      name: 'imStudyingToBecomeAnArchitectAndStartedUsingArchicad',
      desc: '',
      args: [],
    );
  }

  /// `It's great when a neural network PERFECTLY teaches you how to use any neural network.  I mastered Midjourney, Krea, RunWay in ONE day! Without any training costs and a long search for information. ED-helper has made the process easy and enjoyable. I feel like I'm growing professionally every day!`
  String get itsGreatWhenANeuralNetworkPerfectlyTeachesYouHow {
    return Intl.message(
      'It\'s great when a neural network PERFECTLY teaches you how to use any neural network.  I mastered Midjourney, Krea, RunWay in ONE day! Without any training costs and a long search for information. ED-helper has made the process easy and enjoyable. I feel like I\'m growing professionally every day!',
      name: 'itsGreatWhenANeuralNetworkPerfectlyTeachesYouHow',
      desc: '',
      args: [],
    );
  }

  /// `Neural Network Specialist`
  String get neuralNetworkSpecialist {
    return Intl.message(
      'Neural Network Specialist',
      name: 'neuralNetworkSpecialist',
      desc: '',
      args: [],
    );
  }

  /// `Ekaterina, 25 years old`
  String get ekaterina25YearsOld {
    return Intl.message(
      'Ekaterina, 25 years old',
      name: 'ekaterina25YearsOld',
      desc: '',
      args: [],
    );
  }

  /// `I work with Unreal Engine 5, and I used to constantly waste time dealing with technical nuances. Redhelper has become a real find! He saved me a lot of time and nerves, and projects are moving much faster now.`
  String get iWorkWithUnrealEngine5AndIUsedTo {
    return Intl.message(
      'I work with Unreal Engine 5, and I used to constantly waste time dealing with technical nuances. Redhelper has become a real find! He saved me a lot of time and nerves, and projects are moving much faster now.',
      name: 'iWorkWithUnrealEngine5AndIUsedTo',
      desc: '',
      args: [],
    );
  }

  /// `VFX artist`
  String get vfxArtist {
    return Intl.message('VFX artist', name: 'vfxArtist', desc: '', args: []);
  }

  /// `Khizri, 30 years old`
  String get khizri30YearsOld {
    return Intl.message(
      'Khizri, 30 years old',
      name: 'khizri30YearsOld',
      desc: '',
      args: [],
    );
  }

  /// `Revit has always seemed complicated, and I've spent my evenings looking for solutions to minor problems. Thanks to ED-Helper, I get the necessary instructions at the touch of a button. Even complex topics are explained so clearly that I quickly solve work tasks.`
  String get revitHasAlwaysSeemedComplicatedAndIveSpentMyEvenings {
    return Intl.message(
      'Revit has always seemed complicated, and I\'ve spent my evenings looking for solutions to minor problems. Thanks to ED-Helper, I get the necessary instructions at the touch of a button. Even complex topics are explained so clearly that I quickly solve work tasks.',
      name: 'revitHasAlwaysSeemedComplicatedAndIveSpentMyEvenings',
      desc: '',
      args: [],
    );
  }

  /// `Architect`
  String get architect {
    return Intl.message('Architect', name: 'architect', desc: '', args: []);
  }

  /// `Aleksey, 34 years old`
  String get aleksey34YearsOld {
    return Intl.message(
      'Aleksey, 34 years old',
      name: 'aleksey34YearsOld',
      desc: '',
      args: [],
    );
  }

  /// `neural networks and advanced software`
  String get neuralNetworksAndAdvancedSoftware {
    return Intl.message(
      'neural networks and advanced software',
      name: 'neuralNetworksAndAdvancedSoftware',
      desc: '',
      args: [],
    );
  }

  /// `Account not found`
  String get accountNotFound {
    return Intl.message(
      'Account not found',
      name: 'accountNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Code`
  String get invalidCode {
    return Intl.message(
      'Invalid Code',
      name: 'invalidCode',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully!`
  String get passwordChangedSuccessfully {
    return Intl.message(
      'Password changed successfully!',
      name: 'passwordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuee {
    return Intl.message('Continue', name: 'continuee', desc: '', args: []);
  }

  /// `Set`
  String get set {
    return Intl.message('Set', name: 'set', desc: '', args: []);
  }

  /// `Input new password`
  String get inputNewPassword {
    return Intl.message(
      'Input new password',
      name: 'inputNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `You have exceeded your monthly message limit or your subscription has expired.`
  String get youHaveExceededYourMonthlyMessageLimitOrYourSubscription {
    return Intl.message(
      'You have exceeded your monthly message limit or your subscription has expired.',
      name: 'youHaveExceededYourMonthlyMessageLimitOrYourSubscription',
      desc: '',
      args: [],
    );
  }

  /// `The generation limit has been exhausted`
  String get theGenerationLimitHasBeenExhausted {
    return Intl.message(
      'The generation limit has been exhausted',
      name: 'theGenerationLimitHasBeenExhausted',
      desc: '',
      args: [],
    );
  }

  /// `Active until:`
  String get activeUntil {
    return Intl.message(
      'Active until:',
      name: 'activeUntil',
      desc: '',
      args: [],
    );
  }

  /// `Subscription suspended. To extend it you need to`
  String get subscriptionSuspendedToExtendItYouNeedTo {
    return Intl.message(
      'Subscription suspended. To extend it you need to',
      name: 'subscriptionSuspendedToExtendItYouNeedTo',
      desc: '',
      args: [],
    );
  }

  /// `Pay subscription`
  String get paySubscription {
    return Intl.message(
      'Pay subscription',
      name: 'paySubscription',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Input your name`
  String get inputYourName {
    return Intl.message(
      'Input your name',
      name: 'inputYourName',
      desc: '',
      args: [],
    );
  }

  /// `Input your e-mail`
  String get inputYourEmail {
    return Intl.message(
      'Input your e-mail',
      name: 'inputYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Input your password`
  String get inputYourPassword {
    return Intl.message(
      'Input your password',
      name: 'inputYourPassword',
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
      Locale.fromSubtags(languageCode: 'ru'),
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
