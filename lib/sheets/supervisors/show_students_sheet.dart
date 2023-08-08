import 'package:flutter/material.dart';
import 'package:get/get.dart';
//@models
import '/models/student.dart';
import '/widgets/global/no_data_widget.dart';
import '/widgets/global/avatar_widget.dart';

class ShowStudentsSheet extends StatefulWidget {
  //@instances
  final List<Student>? students;
  //@construct
  const ShowStudentsSheet({Key? key, this.students}) : super(key: key);
  @override
  _ShowStudentsSheetState createState() => _ShowStudentsSheetState();
}

class _ShowStudentsSheetState extends State<ShowStudentsSheet> {
  //@attributes
  String _searchQuery = '';

  //@getter
  List<Student> get filteredStudents {
    // Filter the list of students based on the search query
    return widget.students!.where((student) => student.fullName!.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: Get.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  filled: true,
                  hintText: 'Rechercher',
                ),
              ),
            ),
            Expanded(
              child: filteredStudents.isNotEmpty
                  ? ListView(
                      children: [
                        ...filteredStudents.map(
                          (student) => ListTile(
                            leading: AvatarWidget(
                              elevation: 1,
                              path: student.avatar,
                            ),
                            title: Text(student.fullName.toString()),
                          ),
                        ),
                      ],
                    )
                  : const NoDataWidget(
                      hint: 'Aucun écolier n\'est trouvé',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
