within HanserModelica.Classes;
model MixedDeclaration "Mixed declaration of public and private objects"
  extends Modelica.Icons.Example;
  parameter Integer m = 3 "Public Integer parameter";
protected
  parameter Integer n=2*m+1 "Protected Integer parameter";
public
  parameter Real y = 1 "Public Real parameter";
protected
  Modelica.Electrical.Analog.Basic.Ground ground "Protected ground";
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06),
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<h4>Description</h4>

<p>This example demonstrates the declaration of public and protected Modelica instances.</p>
</html>"));
end MixedDeclaration;
