import 'package:flutter_test/flutter_test.dart';
import 'package:college_data_local_storage/models/college_model.dart';

void main() {
  group('CollegeModel Tests', () {
    test('CollegeModel converts to and from Map correctly', () {
      final college = CollegeModel(
        id: 1,
        name: 'ITM Skills University',
        description: 'Premier university for skills education.',
        location: 'Navi Mumbai',
        star: 5,
      );

      final map = college.toMap();
      expect(map['id'], 1);
      expect(map['name'], 'ITM Skills University');
      expect(map['description'], 'Premier university for skills education.');
      expect(map['location'], 'Navi Mumbai');
      expect(map['star'], 5);

      final fromMapCollege = CollegeModel.fromMap(map);
      expect(fromMapCollege.id, 1);
      expect(fromMapCollege.name, 'ITM Skills University');
      expect(fromMapCollege.description, 'Premier university for skills education.');
      expect(fromMapCollege.location, 'Navi Mumbai');
      expect(fromMapCollege.star, 5);
    });
  });
}
