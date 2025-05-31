
#include <cmath>
#include <cstdlib>
#include <iostream>
#include <thread>

#include <entt/entt.hpp>

struct Position {
  int x, y;
};

struct Velocity {
  int dx, dy;
};

struct Health {
  int value;
};

struct Renderable {
  char symbol;
};

struct PlayerTag {};
struct EnemyTag {};

void InputSystem(entt::registry &registry) {
  char input;
  std::cout << "move (W/A/S/D): ";
  std::cin >> input;

  auto view = registry.view<Velocity, const PlayerTag>();
  view.each([&](Velocity &vel) {
    vel.dx = 0;
    vel.dy = 0;

    switch (input) {
      case 'w':
        vel.dy = -1;
        break;
      case 's':
        vel.dy = 1;
        break;
      case 'a':
        vel.dx = -1;
        break;
      case 'd':
        vel.dx = 1;
        break;
    }
  });
}

void AIMoveSystem(entt::registry &registry) {
  // Simple AI: move towards the player
  auto player = registry.view<const Position, const PlayerTag>().front();
  const Position &playerPos = registry.get<const Position>(player);

  auto enemies = registry.view<const Position, Velocity, const EnemyTag>();
  for (auto entity : enemies) {
    const Position &pos = enemies.get<const Position>(entity);
    Velocity &vel = enemies.get<Velocity>(entity);

    if (pos.x < playerPos.x)
      vel.dx = 1;
    else if (pos.x > playerPos.x)
      vel.dx = -1;
    else
      vel.dx = 0;

    if (pos.y < playerPos.y)
      vel.dy = 1;
    else if (pos.y > playerPos.y)
      vel.dy = -1;
    else
      vel.dy = 0;
  }
}

void MovementSystem(entt::registry &registry) {
  registry.view<Position, const Velocity>().each([](Position &pos, const Velocity &vel) {
    pos.x += vel.dx;
    pos.y += vel.dy;
  });
}

void CollisionSystem(entt::registry &registry) {
  auto players = registry.view<const Position, Health, const PlayerTag>();
  auto enemies = registry.view<const Position, const EnemyTag>();

  for (auto entity : players) {
    const Position &pos = players.get<const Position>(entity);
    Health &hp = players.get<Health>(entity);

    enemies.each([&](const Position &epos) {
      int dx = pos.x - epos.x;
      int dy = pos.y - epos.y;
      int distance = dx * dx + dy * dy;

      if (distance <= 1) {
        hp.value--;
        std::cout << "Player hit! Remaining Life: " << hp.value << std::endl;
      }
    });
  }
}

void RenderSystem(entt::registry &registry) {
  char canvas[20][20] = {0};

  for (int y = 0; y < 20; ++y)
    for (int x = 0; x < 20; ++x)
      canvas[y][x] = '.';

  registry.view<Position, Renderable>().each([&](const Position &pos, Renderable &ren) {
    int x = pos.x;
    int y = pos.y;
    if (x >= 0 && x < 20 && y >= 0 && y < 20)
      canvas[y][x] = ren.symbol;
  });

  for (int y = 0; y < 20; ++y) {
    for (int x = 0; x < 20; ++x)
      std::cout << canvas[y][x] << ' ';
    std::cout << '\n';
  }
}

int32_t main(int32_t argc, char **argv) {
  entt::registry registry;

  auto player = registry.create();
  registry.emplace<Position>(player, 10, 10);
  registry.emplace<Velocity>(player, 0, 0);
  registry.emplace<Renderable>(player, 'P');
  registry.emplace<Health>(player, 5);
  registry.emplace<PlayerTag>(player);

  for (int i = 0; i < 5; ++i) {
    auto enemy = registry.create();
    registry.emplace<Position>(enemy, rand() % 20, rand() % 20);
    registry.emplace<Velocity>(enemy, 0, 0);
    registry.emplace<Renderable>(enemy, 'E');
    registry.emplace<EnemyTag>(enemy);
  }

  while (true) {
    InputSystem(registry);
    AIMoveSystem(registry);
    MovementSystem(registry);
    CollisionSystem(registry);
    RenderSystem(registry);

    if (registry.get<Health>(player).value <= 0) {
      std::cout << "Game over!\n";
      break;
    }
  }

  return 0;
}
