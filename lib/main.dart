import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:spaceshooter/game/space_shooter_game.dart';



void main() {
  final game = SpaceShooterGame();
  runApp(GameWidget(game: game));
}


