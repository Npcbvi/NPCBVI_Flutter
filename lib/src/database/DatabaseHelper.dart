import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:typed_data';
class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;
  static Database _db;

  // Database table names
  static final String ADD_PATIENT = "addPatient";

//  static final String VARIANT_Table = "Variant";

  // Database Columns
  static final String Favorite = "0";
  static final String ID = "id";
  static final String TITLE = "title";
  static final String VARIENT_ID = "variant_id";
  static final String PRODUCT_ID = "product_id";
  static final String WEIGHT = "weight";
  static final String MRP_PRICE = "mrp_price";
  static final String PRICE = "price";
  static final String DISCOUNT = "discount";
  static final String QUANTITY = "quantity";
  static final String isFavorite = "isfavorite";
  static final String Product_Json = "product_json";
  static final String IS_TAX_ENABLE = "isTaxEnable";
  static final String Product_Name = "product_name";
  static final String UNIT_TYPE = "unit_type";
  static final String nutrient = "nutrient";
  static final String description = "description";
  static final String imageType = "imageType";
  static final String imageUrl = "imageUrl";
  static final String image_100_80 = "image_100_80";
  static final String image_300_200 = "image_300_200";
  static final String ProductOffer = "product_offer";

  Future<Database> get db async {
    if (_db != null) return _db;
    // if _database is null we instantiate it
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    // Get the directory path for both Android and iOS to store database.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Npcbvi.db");
    // Open/create the database at a given path
    var theDb = await openDatabase(path,
        version: 3, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("""
    CREATE TABLE $ADD_PATIENT (
      id TEXT PRIMARY KEY, 
      registration_type INTEGER, 
      id_type TEXT, 
      id_number TEXT, 
      first_name TEXT, 
      last_name TEXT, 
      relation_type TEXT, 
      relation_name TEXT, 
      dependency_type TEXT, 
      dob TEXT,              
      age INTEGER,           
      gender TEXT,           
      relation_mobile_no TEXT,  
      from_date TEXT,           
      to_date TEXT,             
      disease_id INTEGER,       
      state_id INTEGER,         
      district_id INTEGER,      
      city_id INTEGER,          
      village_id INTEGER,       
      reporting_place TEXT,     
      house_address TEXT,        
      apartment_details TEXT,    
      landmark_area TEXT,        
      pin_code TEXT,             
      communication_language_id INTEGER,
      image BLOB                 -- ✅ Added Image Column
    )
  """);
  }






  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Existing fields
      await db.execute("ALTER TABLE $ADD_PATIENT ADD COLUMN dob TEXT");
      await db.execute("ALTER TABLE $ADD_PATIENT ADD COLUMN age INTEGER");
      await db.execute("ALTER TABLE $ADD_PATIENT ADD COLUMN gender TEXT");

      // ✅ New Fields for Address & Communication Language
      await db.execute("ALTER TABLE $ADD_PATIENT ADD COLUMN house_address TEXT");               // House/Flat Number
      await db.execute("ALTER TABLE $ADD_PATIENT ADD COLUMN apartment_details TEXT");           // Apartment/Building/Colony/Floor
      await db.execute("ALTER TABLE $ADD_PATIENT ADD COLUMN landmark_area TEXT");               // Area/Near Landmark
      await db.execute("ALTER TABLE $ADD_PATIENT ADD COLUMN pin_code TEXT");                    // Pin Code
      await db.execute("ALTER TABLE $ADD_PATIENT ADD COLUMN communication_language_id INTEGER"); // Communication Language ID
      await db.execute("ALTER TABLE $ADD_PATIENT ADD COLUMN image BLOB");
    }
  }

  Future<int> savePatientData({
    String id,                       // ✅ To identify if it's an update
     String idType,
     String idNumber,
     String firstName,
     String lastName,
     String relationType,
     String relationName,
     String dependencyType,
     String dob,
     int age,
     String gender,
     String relationMobileNo,
     String fromDate,
     String toDate,
     int diseaseId,
     int stateId,
     int districtId,
     int cityId,
     int villageId,
     String reportingPlace,
     String houseAddress,
     String apartmentDetails,
     String landmarkArea,
     String pinCode,
     int communicationLanguageId,
    Uint8List image,                 // ✅ Added Image Parameter
  }) async {
    var dbClient = await db;

    Map<String, dynamic> data = {
      'id': id ?? DateTime.now().millisecondsSinceEpoch.toString(), // ✅ Generate ID if new
      'registration_type': 1,
      'id_type': idType,
      'id_number': idNumber,
      'first_name': firstName,
      'last_name': lastName,
      'relation_type': relationType,
      'relation_name': relationName,
      'dependency_type': dependencyType,
      'dob': dob,
      'age': age,
      'gender': gender,
      'relation_mobile_no': relationMobileNo,
      'from_date': fromDate,
      'to_date': toDate,
      'disease_id': diseaseId,
      'state_id': stateId,
      'district_id': districtId,
      'city_id': cityId,
      'village_id': villageId,
      'reporting_place': reportingPlace,
      'house_address': houseAddress,
      'apartment_details': apartmentDetails,
      'landmark_area': landmarkArea,
      'pin_code': pinCode,
      'communication_language_id': communicationLanguageId,
      'image': image,                 // ✅ Saving Image Bytes
    };

    // ✅ Check if updating or inserting
    if (id != null) {
      return await dbClient.update(
        ADD_PATIENT,
        data,
        where: 'id = ?',
        whereArgs: [id],
      );
    } else {
      return await dbClient.insert(ADD_PATIENT, data);
    }
  }








// Get All Local Data
  Future<List<Map<String, dynamic>>> getAllLocalPatients() async {
    final dbClient = await db;
    return await dbClient.query(ADD_PATIENT);
  }

// Delete Data After Upload
  Future<void> deleteLocalPatient(String id) async {
    final dbClient = await db;
    await dbClient.delete(ADD_PATIENT, where: 'id = ?', whereArgs: [id]);
  }





















}
