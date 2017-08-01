within HanserModelica.Classes;
model MixedDeclaration
  extends Modelica.Icons.Example;
  parameter Integer m = 3 "Public Integer parameter";
protected
  parameter Integer n=2*m+1 "Protected Integer parameter";
public
  parameter Real y = 1 "Public Real parameter";
protected
  Modelica.Electrical.Analog.Basic.Ground ground "Protected ground";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end MixedDeclaration;
