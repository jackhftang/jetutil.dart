import 'dart:math';
import 'dart:collection';

const DUMMY_LEVEL = -1;

// self-balanced binary search tree, AATree
class OrderStatisticTree<T> {
  int level = DUMMY_LEVEL;
  int size = 0; // = isDummy ? 0 : left.size + right.size + 1
  T value;
  Function cmp;
  OrderStatisticTree left, right;

  OrderStatisticTree([this.cmp = Comparable.compare]);

  get isValid1 => left.level == level - 1;

  get isNotValid1 => !isValid1;

  get isValid2 =>
      right.level == level - 1 ||
          right.level == level && right.right.level == level - 1;

  get isNotValid2 => !isValid2;

  // for testing
  get isAllValid =>
      isDummy || isValid1 && isValid2 && left.isAllValid && right.isAllValid;

  get isDummy => level == DUMMY_LEVEL;

  get isNotDummy => level != DUMMY_LEVEL;

  toDummy() {
    level = DUMMY_LEVEL;
    size = 0;
    value = left = right = null;
  }

  updateSize() {
    size = left.size + right.size + 1;
  }

  rotateRight() {
    var a = this,
        b = right;
    var c = left,
        d = b.left,
        e = b.right;

    // swap value of a and b
    var t = a.value;
    a.value = b.value;
    b.value = t;

    // reassign children
    a.left = b;
    a.right = e;
    b.left = c;
    b.right = d;

    a.updateSize();
    b.updateSize();
  }

  rotateLeft() {
    var a = this,
        b = left;
    var c = right,
        d = b.left,
        e = b.right;

    // swap value of a and b
    var t = a.value;
    a.value = b.value;
    b.value = t;

    // reassign children
    a.right = b;
    a.left = d;
    b.left = e;
    b.right = c;

    a.updateSize();
    b.updateSize();
  }

  rightRise() {
    if (isValid2) return;
    rotateRight();
    level += 1;
  }

  leftRise() {
    if (isValid1) return;
    rotateLeft();
    right.leftRise();
    right.rightRise();
    rightRise();
  }

  rightFall() {
    if (isValid2) return;
    level -= 1;
    leftRise();
  }

  leftFall() {
    if (isValid1) return;
    if (right.level == level) {
      rotateRight();
      left.level -= 1;
      left.rightRise();
      leftRise();
    }
    else {
      level -= 1;
      rightRise();
    }
  }

  // NOTE: modify should not change the order
  // return true if already exist, otherwise false
  bool modify(v, T modify(T old)) {
    if (isDummy) {
      value = v;
      level = DUMMY_LEVEL + 1;
      size = 1;
      this.left = new OrderStatisticTree(cmp);
      this.right = new OrderStatisticTree(cmp);
      return true;
    }

    var c = cmp(v, value);
    if (c < 0) {
      var res = left.modify(v, modify); // v < value
      if (res) leftRise();
      updateSize();
      return res;
    }
    else if (c > 0) {
      var res = right.modify(v, modify); // v > value
      if (res) rightRise();
      updateSize();
      return res;
    }

    //  c == 0
    value = modify(value);
    return false; // already added
  }

  // if already exist, remain unchanged
  bool add(v) => modify(v, (x) => x);

  bool contains(v) {
    var x = this;
    while (x.isNotDummy) {
      var c = cmp(v, x.value);
      if (c < 0)
        x = x.left;
      else if (c > 0)
        x = x.right;
      else
        return true; // c == 0
    }
    return false;
  }

  T get(T v) {
    var x = this;
    while (x.isNotDummy) {
      var c = cmp(v, x.value);
      if (c < 0)
        x = x.left;
      else if (c > 0)
        x = x.right;
      else
        return x.value; // c == 0
    }
    return null;
  }

  T select(int i) {
    if (i < 0 || i >= size) return null;

    var x = this;
    while (true) {
      var l = x.left.size;
      if (i > l) {
        i -= l + 1;
        x = x.right;
      }
      else if (i < l)
        x = x.left;
      else
        return x.value; // r == l
    }
  }

  int rank(T v) {
    var r = 0;
    var x = this;
    while (x.isNotDummy) {
      var c = cmp(v, x.value);
      if (c < 0)
        x = x.left;
      else if (c > 0) {
        r += x.left.size + 1;
        x = x.right;
      }
      else
        return r + x.left.size;
    }
    return -1;
  }

  maxUnder(T up) {
    var x = this,
        mx;
    while (x.isNotDummy) {
      var c = cmp(x.value, up);
      if (c >= 0)
        x = x.left;
      else {
        // x.value < up
        mx = x.value;
        x = x.right;
      }
    }
    return mx;
  }

  maxUnderEqual(T up) {
    var x = this,
        mx;
    while (x.isNotDummy) {
      var c = cmp(x.value, up);
      if (c > 0)
        x = x.left;
      else {
        // x.value < up
        mx = x.value;
        x = x.right;
      }
    }
    return mx;
  }

  minOver(T lo) {
    var x = this,
        mi;
    while (x.isNotDummy) {
      var c = cmp(x.value, lo);
      if (c <= 0)
        x = x.right;
      else {
        // x.value > lo
        mi = x.value;
        x = x.left;
      }
    }
    return mi;
  }

  minOverEqual(T lo) {
    var x = this,
        mi;
    while (x.isNotDummy) {
      var c = cmp(x.value, lo);
      if (c < 0)
        x = x.right;
      else {
        // x.value > lo
        mi = x.value;
        x = x.left;
      }
    }
    return mi;
  }

  T peekMin() {
    if (isDummy) throw new StateError('Cannot peek minimum from empty tree');
    var n = this;
    while (n.left.isNotDummy) n = n.left;
    return n.value;
  }

  T peekMax() {
    if (isDummy) throw new StateError('Cannot peek maximum from empty tree');
    var n = this;
    while (n.right.isNotDummy) n = n.right;
    return n.value;
  }

  T removeMin() {
    if (isDummy) throw new StateError('Cannot take minimum from empty tree');

    T run(OrderStatisticTree<T> n) {
      if (n.left.isDummy) {
        var t = n.value;
        if (n.right.isDummy)
          n.toDummy();
        else {
          n.value = n.right.value;
          n.right.toDummy();
          n.updateSize();
        }
        return t;
      }
      var ret = run(n.left);
      n.leftFall();
      n.updateSize();
      return ret;
    }

    return run(this);
  }

  T removeMax() {
    if (isDummy) throw new StateError('Cannot take maximum from empty tree');

    T run(OrderStatisticTree<T> n) {
      if (n.right.isDummy) {
        var t = n.value;
        n.toDummy();
        return t;
      }
      var ret = run(n.right);
      n.rightFall();
      n.updateSize();
      return ret;
    }

    return run(this);
  }

  T remove(v) {
    if (isDummy) return null;

    var c = cmp(v, value);
    if (c < 0) {
      var res = left.remove(v);
      if (res != null) leftFall();
      updateSize();
      return res;
    }
    else if (c > 0) {
      var res = right.remove(v);
      if (res != null) rightFall();
      updateSize();
      return res;
    }

    // c == 0
    if (right.isNotDummy) {
      var t = value;
      value = right.removeMin();
      rightFall();
      updateSize();
      return t;
    }
    else {
      // if right is dummy, left is also dummy
      var t = value;
      toDummy();
      return t;
    }
  }

  String toString() {
    int width(n) {
      if (n.isDummy) return 0;
      var a = width(n.left);
      var b = width(n.right);
      var strLen = '${n.value} (${n.level},${n.size})'.length;
      return a + b + strLen;
    };
    int height(n) {
      if (n.isDummy) return 0;
      var a = height(n.left);
      var b = height(n.right);
      return max(a, b) + 2;
    };
    var w = width(this);
    var h = height(this);
    var canvas = new List(h);
    for (var i = 0; i < h; i++)
      canvas[i] = new List(w);
    for (var i = 0; i < h; i++)
      for (var j = 0; j < w; j++) {
        canvas[i][j] = ' ';
      }

    void draw(n, dir, h, shift) {
      if (n.isDummy) return;
      var x = width(n.left);
      var label = '${n.value} (${n.level},${n.size})';
      canvas[h][shift + x + label.length ~/ 2] =
      (dir == null) ? '|' : dir ? '\\' : '/';
      for (var i = 0; i < label.length; i++)
        canvas[h + 1][shift + x + i] = label[i];
      draw(n.left, false, h + 2, shift);
      draw(n.right, true, h + 2, shift + x + label.length);
    }


    draw(this, null, 0, 0);
    return canvas.map((row) => row.join('')).join('\n');
  }

  // all values should between lo and up exclusively
  bool verify(lo, up) {
    if (isDummy) return true;
    var b = cmp(value, lo) > 0 && cmp(value, up) < 0;
    return b && left.verify(lo, this.value) && right.verify(this.value, up);
  }
}


