#include <iostream>

#include <tabulate/table.hpp>
using namespace tabulate;

int main() {
  Table universal_constants;

  universal_constants.add_row({"Quantity", "Value"});
  universal_constants.add_row({"Characteristic impedance of vacuum", "376.730 313 461... Ω"});
  universal_constants.add_row({"Electric constant (permittivity of free space)", "8.854 187 817... × 10⁻¹²F·m⁻¹"});
  universal_constants.add_row({"Magnetic constant (permeability of free space)", "4π × 10⁻⁷ N·A⁻² = 1.2566 370 614... × 10⁻⁶ N·A⁻²"});
  universal_constants.add_row({"Gravitational constant (Newtonian constant of gravitation)", "6.6742(10) × 10⁻¹¹m³·kg⁻¹·s⁻²"});
  universal_constants.add_row({"Planck's constant", "6.626 0693(11) × 10⁻³⁴ J·s"});
  universal_constants.add_row({"Dirac's constant", "1.054 571 68(18) × 10⁻³⁴ J·s"});
  universal_constants.add_row({"Speed of light in vacuum", "299 792 458 m·s⁻¹"});

  universal_constants.format()
      .font_style({FontStyle::bold})
      .border_top(" ")
      .border_bottom(" ")
      .border_left(" ")
      .border_right(" ")
      .corner(" ");

  universal_constants[0].format().padding_top(1).padding_bottom(1).font_align(FontAlign::center).font_style({FontStyle::underline}).font_background_color(Color::red);

  universal_constants.column(1).format().font_color(Color::yellow);

  universal_constants[0][1].format().font_background_color(Color::blue).font_color(Color::white);

  std::cout << universal_constants << std::endl;
}