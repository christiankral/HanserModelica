within HanserModelica.Electrical;
model TablesFromFile "Application of tables read from file"
  parameter String fileName=Modelica.Utilities.Files.loadResource(
    "modelica://HanserModelica/Resources/Tables/table.txt") "File name";
  extends Tables(table(
      tableOnFile=true,
      tableName="resistor",
      fileName=fileName));
  annotation(experiment(StopTime=4,Interval=0.001,Tolerance=1e-06));
end TablesFromFile;
