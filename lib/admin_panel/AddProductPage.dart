






import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:sizer/sizer.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({ Key? key }) : super(key: key);

  static const String id = "addProductPage"; 
  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  
  String selectFile = "";
  String deafaultUrl = "https://cdn.pixabay.com/photo/2023/01/01/23/37/woman-7691013_1280.jpg";

  Uint8List? selectedImageInBytes;

  String? selectedValue;

 List categories = [
   "CHAIR",
   "BED",
   "TABLE",
   "SOFA",
   "WARDROBE",
   "DESK"
  ];

  final imagepicker = ImagePicker();
  List<XFile> images = [];

  pickglbFile() async {
   
    FilePickerResult? result = await FilePicker.platform.pickFiles();
  
    if (result != null) {
      setState(() {
        selectFile = result.files.first.name;
        selectedImageInBytes = result.files.first.bytes;
      });
    } else {
      // User canceled the picker
    }
    
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            children: [
              const Text(
                "ADD PRODUCT",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              DropdownButtonFormField(
                validator: (value){
                  if(value == null){
                    "Category must be selected";
                  }
                  return null;
                },
                value: selectedValue,
                items: categories.map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e)
                  )
                  ).toList(), 
              onChanged: (value){
                setState(() {
                  selectedValue = value.toString();
                });
              }),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () async {
                    // pickImage();
                    pickglbFile();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: const Center(child: 
                    Text(
                      "PICK IMAGE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 15.0
                        ),
                      )
                    )
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: const Center(child: 
                    Text(
                      "UPLOAD IMAGE",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 15.0
                        ),
                      )
                    )
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 35.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey.withOpacity(0.3)
                  ),
                  child: selectFile.isEmpty ? Image.network(deafaultUrl, fit: BoxFit.cover,) : ModelViewer(
                    src: "/Users/faizan/Desktop/furniture models/chair2.glb",
                   // alt: "chair",
                    autoRotate: true,
                  )
                  )
                ),
            ],
          ),
        )
      ),
    );
  }
  pickImage() async {
    final List<XFile> pickImage = await imagepicker.pickMultiImage();
    if(pickImage != null){
      setState(() {
        images.addAll(pickImage);
      });
    }
    else{
      print("no images selected");
    }
  }
}


// GridView.builder(
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     ),
//                     itemCount: images.length,
//                     itemBuilder: (BuildContext context, index) {
//                       return Image.network(File(images[index].path).path);
//                     })