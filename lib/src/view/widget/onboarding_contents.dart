class OnboardingContents {
  final String title;
  final String animation;
  final String desc;

  OnboardingContents(
      {required this.title, required this.animation, required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
      title: 'Welcome to the most exciting video game app on the market!',
      animation: './assets/images/playing-video-games.json',
      desc: 'Get ready for the adventure of your life with our games!'),
  OnboardingContents(
      title: 'Explore our games and discover worlds full of surprises.',
      animation: './assets/images/future-man-exploring.json',
      desc: 'Enter our games and live experiences you never imagined before.'),
  OnboardingContents(
      title:
          'Challenge your friends and show off your skills in our multiplayer games.',
      animation: './assets/images/friends-playing-video-game.json',
      desc:
          'Every game is an opportunity to improve and become the best player.'),
  OnboardingContents(
      title:
          'Personalize your profile and make it unique with our customization options.',
      animation: './assets/images/profile.json',
      desc:
          'The fun does not stop here! We constantly update our games to offer you new adventures.'),
  OnboardingContents(
      title: 'Let the fun begin! See you in the games!',
      animation: './assets/images/142258-start-up.json',
      desc:
          'Thank you for choosing us! Get ready to experience incredible emotions in our games!'),
];
