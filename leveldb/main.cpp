#include <filesystem>
#include <string>

#include "leveldb/db.h"

using namespace std;

int32_t main(int32_t argc, char** argv) {
  leveldb::DB* db;

  leveldb::Options options;
  options.create_if_missing = true;
  const std::filesystem::path& p = std::filesystem::absolute("./testdb");

  leveldb::Status status = leveldb::DB::Open(options, p.string(), &db);
  printf("Open status : %s\n", status.ok() ? "ok" : status.ToString().c_str());

  std::string key = "testkey";
  std::string val = "testval";

  status = db->Put(leveldb::WriteOptions(), key, val);
  printf("Put status : %s\n", status.ok() ? "ok" : status.ToString().c_str());

  std::string val_out;
  status = db->Get(leveldb::ReadOptions(), key, &val_out);
  printf("Get status : %s\n", status.ok() ? "ok" : status.ToString().c_str());
  printf("val_out : %s\n", val_out.c_str());

  status = db->Delete(leveldb::WriteOptions(), key);
  printf("Delete status : %s\n", status.ok() ? "ok" : status.ToString().c_str());

  status = db->Get(leveldb::ReadOptions(), key, &val_out);
  printf("Get status : %s\n", status.ok() ? "ok" : status.ToString().c_str());

  delete db;

  return 0;
}
