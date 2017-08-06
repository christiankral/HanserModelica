within HanserModelica.Concepts;
model TablesFromFile "Application of tables read from file"
  parameter String fileName=Modelica.Utilities.Files.loadResource(
    "modelica://HanserModelica/Resources/Tables/table.txt") "File name";
  extends Tables(table(
      tableOnFile=true,
      tableName="resistor",
      fileName=fileName));
end TablesFromFile;
