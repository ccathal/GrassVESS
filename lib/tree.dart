
///
/// Class: Link
///
/// A link is an individual node in the GrassVESS flowchart.
/// Each link has an id (own name), data, instruction and picture.
/// Additionally, each link can be assigned a left and right link which
/// correspond to the 'yes' and 'no' path to another link in the flowchart.
///
/// Input: [id] identifier String value of the link name.
///
class Link {

  String id, data, picture, instruction;
  Link left, right, previous;
  Link(this.id);

  ///
  /// Returns the string value of the link name.
  ///
  String getLinkName() {
    return this.id;
  }
}

///
/// Class: LinkdList
///
/// Stores [Link] data as we progress through the flowchart.
///
class LinkdList {

  List linkedList;

  ///
  /// Constructor initialises an empty linked list.
  ///
  LinkdList() {
    this.linkedList = [];
  }

  ///
  /// All links and their corresponding left and right nodes are initialised.
  /// Additionally, the root link is added to the linkedlist.
  ///
  void initialiseLinkedList() {
    Link root = initialiseLinks();
    this.linkedList.add(root);
  }

  ///
  /// Adds [addElement] link to the linked list.
  ///
  void addLinkElement(Link addElement) {
    this.linkedList.add(addElement);
  }

  ///
  /// Removes last link element from the linked list.
  ///
  void removeLastLinkElement() {
    this.linkedList.removeLast();
  }

  ///
  /// Gets the last link element from the linked list.
  ///
  Link getPreviousElement() {
    return this.linkedList[linkedList.length - 1];
  }

  ///
  /// Gets the first link element from the linked list.
  ///
  Link getFirstElement() {
    return this.linkedList[0];
  }

  ///
  /// Checks if the linked list is empty.
  ///
  bool isEmpty() {
    return this.linkedList.isEmpty;
  }
}

///
/// Declare all links.
///

Link nullLink = new Link('null_link');

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

///
/// Initialise all left and right links of each link.
///
Link initialiseLinks() {


  /// First Instruction.

  link1_1.left = link1_2;
  link1_1.right = link2_1;

  link1_2.left = link1_3;
  link1_2.right = link2_2;

  link1_3.left = nullLink;
  link1_3.right = link2_3;

  /// Second Instruction.

  link2_1.left = link2_2;
  link2_1.right = link3_1;

  link2_2.left = link2_3;
  link2_2.right = link2_4;

  link2_3.left = link2_2;
  link2_3.right = link2_6;

  link2_4.left = link2_5;
  link2_4.right = link3_2;

  link2_5.left = link2_6;
  link2_5.right = link3_3;

  link2_6.left = nullLink;
  link2_6.right = link3_4;

  /// Third Instruction.

  link3_1.left = link3_2;
  link3_1.right = link3_5;

  link3_2.left = link3_3;
  link3_2.right = link3_6;

  link3_3.left = link3_4;
  link3_3.right = link3_7;

  link3_4.left = link3_3;
  link3_4.right = link3_8;

  link3_5.left = nullLink;
  link3_5.right = link4_1;

  link3_6.left = link3_7;
  link3_6.right = link4_2;

  link3_7.left = nullLink;
  link3_7.right = link3_9;

  link3_8.left = nullLink;
  link3_8.right = link3_10;

  link3_9.left = link3_10;
  link3_9.right = link4_3;

  link3_10.left = nullLink;
  link3_10.right = link4_4;

  return link1_1;
}

///
/// Method to change the left link for link2_2 as this link as 3 incoming arrows.
/// I assume if coming from the bottom or side (links 1_2 and 2_3) we go up (link 2_1).
/// If coming from the top (link 2_1) we go down (link 2_3) from link2_2.
///
void setLinkCondition2_2(Link link) {
  if(link.id == "link1_2" || link.id == 'link2_3') {
    link2_2.left = link2_1;
  }
  else {
    link2_2.left = link2_3;
  }
}

///
/// Method to change the left link for link3_3 as this link as 3 incoming arrows.
/// I assume if coming from the bottom or side (links 2_5 and 3_4) we go up (link 3_2).
/// If coming from the top (link 3_2) we go down (link 3_4) from link3_3.
///
void setLinkCondition3_3(Link link) {
  if(link.id == 'link2_5' || link.id == 'link3_4') {
    link3_3.left = link3_2;
  }
  else {
    link3_3.left = link3_4;
  }
}

