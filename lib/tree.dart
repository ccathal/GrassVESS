import 'dart:io';

class Link {
  String id;
  String data;
  String picture;
  String instruction;

  Link left;
  Link right;
  Link previous;

  Link(this.id){}

  String getLinkName() {
    return this.id;
  }

  void displayLink() {
    stdout.write('$id ');
  }
}

class LinkdList {
  List linkedList;

  LinkdList() {
    this.linkedList = [];
  }

  List getLinkedList() {
    return this.linkedList;
  }

  void initialiseLinkedList() {
    Link root = initialiseLinks();
    this.linkedList.add(root);
  }

  void addLinkElement(Link addElement) {
    this.linkedList.add(addElement);
  }

  void removeLastLinkElement() {
    this.linkedList.removeLast();
  }

  void clearLinkedList() {
    this.linkedList.clear();
  }

  Link getPreviousElement() {
    return this.linkedList[linkedList.length - 1];
  }

  Link getFirstElement() {
    return this.linkedList[0];
  }

  bool isEmpty() {
    return this.linkedList.isEmpty;
  }

}

/*
  Initialise Links
 */

Link null_link = new Link('null_link');

Link link1_1 = new Link('link1_1');
Link link1_2 = new Link('link1_2');
Link link1_3 = new Link('link1_3');

Link link2_1 = new Link('link2_1');
Link link2_2 = new Link('link2_2');
Link link2_3 = new Link('link2_3');
Link link2_4 = new Link('link2_4');
Link link2_5 = new Link('link2_5');
Link link2_6 = new Link('link2_6');

Link link3_1 = new Link('link3_1');
Link link3_2 = new Link('link3_2');
Link link3_3 = new Link('link3_3');
Link link3_4 = new Link('link3_4');
Link link3_5 = new Link('link3_5');
Link link3_6 = new Link('link3_6');
Link link3_7 = new Link('link3_7');
Link link3_8 = new Link('link3_8');
Link link3_9 = new Link('link3_9');
Link link3_10 = new Link('link3_10');

Link link4_1 = new Link('link4_1');
Link link4_2 = new Link('link4_2');
Link link4_3 = new Link('link4_3');
Link link4_4 = new Link('link4_4');

Link initialiseLinks() {
  /*
  First Instruction
 */
  link1_1.left = link1_2;
  link1_1.right = link2_1;

  link1_2.left = link1_3;
  link1_2.right = link2_2;

  link1_3.left = null_link; // this should be NULL
  link1_3.right = link2_3;

  /*
    Second Instruction
   */

  link2_1.left = link2_2;
  link2_1.right = link3_1;

  link2_2.left = link2_3; // also 'No' to link2_1
  link2_2.right = link2_4;

  link2_3.left = link2_2;
  link2_3.right = link2_6;

  link2_4.left = link2_5;
  link2_4.right = link3_2;

  link2_5.left = link2_6;
  link2_5.right = link3_3;

  link2_6.left = null_link;
  link2_6.right = link3_4;

  /*
    Third Instruction
   */

  link3_1.left = link3_2;
  link3_1.right = link3_5;

  link3_2.left = link3_3;
  link3_2.right = link3_6;

  link3_3.left = link3_4; // also 'No' link to link3_2
  link3_3.right = link3_7;

  link3_4.left = link3_3;
  link3_4.right = link3_8;

  link3_5.left = null_link;
  link3_5.right = link4_1;

  link3_6.left = link3_7;
  link3_6.right = link4_2;

  link3_7.left = null_link;
  link3_7.right = link3_9;

  link3_8.left = null_link;
  link3_8.right = link3_10;

  link3_9.left = link3_10;
  link3_9.right = link4_3;

  link3_10.left = null_link;
  link3_10.right = link4_4;

  return link1_1;
}

void setLinkCondition2_2(Link link) {
  if(link.id == "link1_2" || link.id == 'link2_3') {
    link2_2.left = link2_1;
  }
  else {
    link2_2.left = link2_3;
  }
}

void setLinkCondition3_3(Link link) {
  if(link.id == 'link2_5' || link.id == 'link3_4') {
    link3_3.left = link3_2;
  }
  else {
    link3_3.left = link3_4;
  }
}

