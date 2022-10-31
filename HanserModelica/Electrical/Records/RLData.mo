within HanserModelica.Electrical.Records;
record RLData "Data of R-L series connection"
  extends Modelica.Icons.Record;
  parameter Modelica.Units.SI.Resistance R(start=1) "Resistance";
  parameter Modelica.Units.SI.Inductance L(start=1) "Inductance";
  parameter String componentName = "RLData" "Component name";
  annotation(defaultComponentName = "rlData", defaultComponentPrefixes = "parameter",
    Icon(graphics={
        Text(
          lineColor={0,0,255},
          extent={{-150,-150},{150,-110}},
          textString="%componentName")}));
end RLData;
