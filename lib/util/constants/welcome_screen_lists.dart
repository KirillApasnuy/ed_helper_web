import 'package:ed_helper_web/data/models/features_card_model.dart';

import '../../data/models/review_model.dart';
import '../../generated/l10n.dart';

class WelcomeScreenLists {
  var _context;

  get context => _context;

  set context(value) {
    _context = value;
  }

  WelcomeScreenLists();

  List<String> buttonTitles() => [
        S.current.howToAnimateACharacterUsingAi,
        S.current.howToCreateVfxGraphicsOnAnExistingVideo,
        S.current.howToSpeedUpModelingAndRenderingIn3dsMax,
        S.current.advancedAnimationToolsInBlender,
        S.current.howToGenerateConceptArtInMidjourney,
      ];

  static final List<String> appTitles = """
  3ds Max
Blender
Unreal Engine 5
Autodesk Maya
Cinema 4D
AutoCAD
SketchUp
ZBrush
Houdini
Rhino
Revit
ArchiCAD
V-Ray
Corona Renderer
Lumion
Enscape Vectorworks Architect
KeyShot
Unity
CryEngine
Twinmotion
Adobe PhotoShop
DaVinci Resolve
CapCut
Adobe Premiere Pro
After Effects
Nuke
Figma
Tilda
Affinity Suite
FL Studio
Ableton Live
Logic Pro X
Audacity
iZotope RX"""
      .split("\n");
  static final List<String> aiNames = """MidJourney
Stable Diffusion
Runway ML
Adobe Firefly
DreamBooth
Artbreeder
NightCafe Studio
Krea.ai
Vizcom
Recraft
ArchiCAD
Jasper Art
Luma AI
Kaedim
Pika Labs
Polycam
NVIDIA Canvas
Scenario.gg
Remini
StyleGAN
GauGAN
PhotoAI
3DFY.ai
Wonder Studio
DeepFaceLab"""
      .split("\n");

  List<ReviewModel> reviews() => [
        ReviewModel(
            "assets/review_img/anna.png",
            S.current.anna27YearsOld,
            S.current.dVisualizer,
            S.current.iUsedToHaveToSpendHoursScouringForumsReading),
        ReviewModel(
            "assets/review_img/olga.png",
            S.current.olga22YearsOld,
            S.current.student,
            S.current.imStudyingToBecomeAnArchitectAndStartedUsingArchicad),
        ReviewModel(
            "assets/review_img/alexey.png",
            S.current.aleksey34YearsOld,
            S.current.architect,
            S.current.revitHasAlwaysSeemedComplicatedAndIveSpentMyEvenings),
        ReviewModel("assets/review_img/hizri.png", S.current.khizri30YearsOld,
            S.current.vfxArtist, S.current.iWorkWithUnrealEngine5AndIUsedTo),
        ReviewModel(
            "assets/review_img/kate.png",
            S.current.ekaterina25YearsOld,
            S.current.neuralNetworkSpecialist,
            S.current.itsGreatWhenANeuralNetworkPerfectlyTeachesYouHow),
      ];

  List<FeaturesCardModel> features() => [
        FeaturesCardModel(
            title: S.current.instantAnswersToAnyQuestion,
            description: S.current.askAQuestionGetAnAccurateAnswerInSeconds,
            imageUrl: "welcome_chat.svg"),
        FeaturesCardModel(
            title: S.current.clearSolutionsWithoutUnnecessaryText,
            description: S
                .current
                .stepbystepGifInstructionsInsteadOfLongVideosAndBoringLectures,
            imageUrl: "welcome_gif.svg"),
        FeaturesCardModel(
            title: S.current.supportWithNoWaiting,
            description: S.current.helpIsAlwaysAtHandWheneverYouNeedIt,
            imageUrl: "welcome_time.svg"),
        FeaturesCardModel(
            title: S.current.easyFileAndVoiceMessageSharing,
            description:
                S.current.sendScreenshotsAudioAndDocumentsInOneClickGetA,
            imageUrl: "welcome_swap.svg"),
        FeaturesCardModel(
            title: S.current.automationForWorkAndLearning,
            description: S
                .current
                .fastFileAnalysisTextGenerationSmartSuggestionsTranslationWebsiteAnalysis,
            imageUrl: "welcome_ai_chip.svg"),
        FeaturesCardModel(
            title: S.current.saveTimeAndEffort,
            description: S
                .current
                .forgetEndlessSearchesForInformationSolveTasksInstantly,
            imageUrl: "welcome_rocket.svg"),
      ];
}
