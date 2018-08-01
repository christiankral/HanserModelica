within HanserModelica.Classes;
model TestVector2D "Application of Vector2D"
  extends Modelica.Icons.Example;
  parameter Vector2D a(x=3,y=4) "Vector";
  parameter Real aMag=sqrt(a.x^2+a.y^2) "Magnitude of a";
  parameter Modelica.SIunits.Time T=0.2 "Time constant";
  Vector2D v(x(start=0,fixed=true),y(start=0,fixed=true)) "Integral of a/T";
equation
  der(v.x)=a.x/T;
  der(v.y)=a.y/T;
  annotation (experiment(StopTime=1, Interval=0.001, Tolerance=1e-06),
    Documentation(info="<html>
<h4>Description</h4>

<p>This example tests the record <a href=\"modelica://HanserModelica.Classes.Vector2D\">Vector2D</a>.</p>
</html>"));
end TestVector2D;
