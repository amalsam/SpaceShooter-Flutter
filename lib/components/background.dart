

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/painting.dart';
import 'package:spaceshooter/game/configuration.dart';
import 'package:spaceshooter/game/space_shooter_game.dart';

class Background extends ParallaxComponent<SpaceShooterGame>{

  Background();

  @override
  Future<void> onLoad() async{
    final background = await Flame.images.load('bgweb.png');

    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(background,fill: LayerFill.width,repeat: ImageRepeat.repeatY),
        
      )
    ]);
  }

  @override
  void update(double dt){
    super.update(dt);
    parallax?.baseVelocity.y = Config.bgSpeed;
  }
}