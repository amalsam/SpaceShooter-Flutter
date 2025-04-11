

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';


class Bullet extends SpriteComponent with CollisionCallbacks{
  Bullet({
    required this.bulletX,
    required this.bulletY
    });

    final double bulletX;
    final double bulletY;

    @override
    Future<void> onLoad() async{
      position.x = bulletX;
      position.y =bulletY;

      final bullet = await Flame.images.load('bullet1.png');
      
      size = Vector2(10, 30);
      sprite= Sprite(bullet);
      add(CircleHitbox());
    }

    @override
    void update(dt){
      super.update(dt);

      position.y -= 5;

      if(position.y < -10){
        removeFromParent();
      }
    }

}