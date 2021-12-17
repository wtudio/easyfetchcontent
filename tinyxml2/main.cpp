#include <filesystem>
#include <fstream>
#include <string>

#include "tinyxml2.h"

using namespace std;

int32_t main(int32_t argc, char** argv) {
  const std::filesystem::path& xml_file = std::filesystem::absolute("./test.xml");

  std::ofstream ofile(xml_file, std::ios::trunc);
  ofile << R"str(
<document>
	<data>1</data>
	<data>2</data>
	<data>3</data>
</document>
)str";
  ofile.close();

  tinyxml2::XMLDocument doc;
  tinyxml2::XMLError error = doc.LoadFile(xml_file.string().c_str());

  if (error != tinyxml2::XMLError::XML_SUCCESS) {
    printf("LoadFile error %d", error);
    return 0;
  }

  tinyxml2::XMLElement* root = doc.RootElement();
  printf("root name : %s\n", root->Name());

  doc.SaveFile(xml_file.string().c_str());

  return 0;
}
