import 'package:flutter/material.dart';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents(
      {required this.title, required this.image, required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "TROUVER DES DOCUMENTS",
    image: "images/Logo.png",
    desc: "Un processus simple, clair et pertinent Recherchez par mot clé, référence ...",
  ),
  OnboardingContents(
    title: "VOIR LE DOCUMENT ",
    image: "images/Logo.png",
    desc: "Un processus simple, clair et pertinent Recherchez par mot clé, référence ...",
  ),
  OnboardingContents(
    title: "AJOUTER AUX FAVORIS ",
    image: "images/Logo.png",
    desc: "Un processus simple, clair et pertinent Recherchez par mot clé, référence ...",
  ),
];
