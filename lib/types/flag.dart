import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Flag {
  // General Flags
  postponed(
    shortDescription: "Start Delayed",
    description: "Races not yet started are postponed.",
    assetName: "ics_answer.svg",
  ),
  classFlag(
    shortDescription: "Class Flag",
    description:
        "The Flag for the class or fleet to start next. This can be the symbol of the boat class, the race logo or any other symbol assigned for this purpose.",
    assetName: "class_flag_with_border.svg",
  ),
  allRacesAbandoned(
    shortDescription: "All Races Abandoned",
    description:
        "All races that have started are abandoned. Return to starting area for a new start. The first warning signal will be made 1 minute after N is removed. Additional Flags may be set in combination to indicate a different start time.",
    assetName: "ics_november.svg",
  ),

  // Start procedures
  normalStart(
    shortDescription: "Normal Start Rule",
    description:
        "Normal preparatory signal - no starting penalties are in effect. A boat over the line at the start can return through the line or round an end but must keep clear of boats not returning. If they fail to return through the line however they will be scored OCS (on course side).",
    assetName: "ics_papa.svg",
  ),
  roundAnEnd(
    shortDescription: "Round-an-End Rule ",
    description:
        "The Round-an-End Rule 30.1 will be in effect. A boat over the line during the minute before the start must sail to the pre-start side of the line around either end before starting. If they fail to do this they will be scored OCS.",
    assetName: "ics_india.svg",
  ),
  twentyPercent(
    shortDescription: "20 Percent Penalty",
    description:
        "The 20% Penalty Rule 30.2 will be in effect. A boat within the triangle formed by the ends of the line and the first mark during the minute before the start will receive a 20% scoring penalty.",
    assetName: "ics_zulu.svg",
  ),
  blackFlag(
    shortDescription: "Black Flag",
    description:
        "The Black Flag Rule 30.3 will be in effect. A boat within the triangle formed by the ends of the line and the first mark during the minute before the start will be disqualified without a hearing.",
    assetName: "black_flag.svg",
  ),
  uFlag(
    shortDescription: "U Flag Rule",
    description:
        "The U Flag Rule will be in effect. A boat within the triangle formed by the ends of the line and the first mark during the minute before the start will be disqualified without a hearing. If a restart or resail is called, the disqualification is rescinded, unlike the black-flag or Z-flag penalties.",
    assetName: "ics_uniform.svg",
  ),

  // Recalls
  individualRecall(
    shortDescription: "Individual Recall",
    description:
        "Individual recall. One or more boats did not start correctly and must return and do a proper start. The X flag is displayed until the earliest of the following: all boats over the line early have returned correctly, 4 minutes from the start or until one minute before the next start.",
    assetName: "ics_x-ray.svg",
  ),
  generalRecall(
    shortDescription: "General Recall",
    description:
        "General recall. All boats are to return and then a new start sequence will begin. Signaled when there are unidentified boats over the line or subject to one of the starting penalties, or there has been an error in the starting procedure. The new warning signal for the recalled class will be made 1 minute after the general recall flag is removed.",
    assetName: "ics_repeat_one.svg",
  ),

  // Miscellaneous
  shortenedCourse(
    shortDescription: "Shortened Course",
    description:
        "Shortened Course. When displayed at a rounding mark the finish is between the nearby mark and the mast displaying the S flag. When displayed at a line that boats are required to cross at the end of each lap the finish is that line. When displayed at a gate the finish is between the gate marks.",
    assetName: "ics_sierra.svg",
  ),
  personalBuoyancy(
    shortDescription: "Personal Buoyancy Device",
    description: "All people on board should wear a personal life jacket or personal buoyancy.",
    assetName: "ics_yankee.svg",
  );

  const Flag({
    required this.shortDescription,
    required this.description,
    required this.assetName,
  });

  final String shortDescription;
  final String description;
  final String assetName;

  Widget get svgImage => SvgPicture.asset(
        "assets/flags/$assetName",
        semanticsLabel: shortDescription,
        height: 40,
        width: 40,
      );
}
