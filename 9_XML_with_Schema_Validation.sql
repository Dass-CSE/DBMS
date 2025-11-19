<!-- ====================================== -->
<!-- 10. XML with Schema Validation Example -->
<!-- ====================================== -->

<!-- Sample XML Document: students.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<students xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:noNamespaceSchemaLocation="students.xsd">
    <student>
        <rollNo>101</rollNo>
        <name>Arjun</name>
        <department>Computer Science</department>
        <cgpa>8.6</cgpa>
    </student>
    <student>
        <rollNo>102</rollNo>
        <name>Divya</name>
        <department>Information Technology</department>
        <cgpa>9.1</cgpa>
    </student>
</students>

<!-- Output:
Valid XML structure with nested <student> elements.
Each student has rollNo, name, department, and cgpa fields.
-->

<!-- Sample XSD File: students.xsd -->
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xs:element name="students">
    <xs:complexType>
      <xs:sequence>
        <xs:element name="student" maxOccurs="unbounded">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="rollNo" type="xs:integer"/>
              <xs:element name="name" type="xs:string"/>
              <xs:element name="department" type="xs:string"/>
              <xs:element name="cgpa" type="xs:decimal"/>
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
  </xs:element>

</xs:schema>

<!-- Output:
Validates:
- rollNo must be an integer
- name, department must be strings
- cgpa must be a decimal
-->

<!-- ❗ If any field in XML is missing or data type mismatched, validation will fail. -->

<!-- Example of Validation Error:
If <cgpa> tag contains text 'Nine point one' instead of 9.1 → ERROR: datatype mismatch.
-->
