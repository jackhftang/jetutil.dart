import 'package:test/test.dart';
import 'package:jetutil/jetutil.dart';

main() {
  test('LeaseCommonAncestor', () {
    var lca = new LeastCommonAncestor(5);
    lca.add(0, 1);
    lca.add(0, 2);
    lca.add(2, 3);
    lca.add(2, 4);
    /*
      0
      | \
      1  2
         | \
         3  4
     */

    lca.build();

    expect(lca.query(1, 2), equals(0));
    expect(lca.query(2, 1), equals(0));

    expect(lca.query(1, 3), equals(0));
    expect(lca.query(1, 4), equals(0));
    expect(lca.query(3, 4), equals(2));
    expect(lca.query(2, 3), equals(2));
    expect(lca.query(2, 4), equals(2));

    expect(lca.query(0, 1), equals(0));
    expect(lca.query(0, 2), equals(0));
    expect(lca.query(0, 3), equals(0));
    expect(lca.query(0, 4), equals(0));

    expect(lca.query(1, 0), equals(0));
    expect(lca.query(2, 0), equals(0));
    expect(lca.query(3, 0), equals(0));
    expect(lca.query(4, 0), equals(0));

    for (var i = 0; i < 5; i++)
      expect(lca.query(i, i), equals(i));
  });
}