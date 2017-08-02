within HanserModelica.Classes;
model UseVector2D "Application of Vector2D"
  extends Modelica.Icons.Example;
  parameter Vector2D a(x=3,y=4) "Vector";
  parameter Real aMag=sqrt(a.x^2+a.y^2) "Magnitude of a";
  parameter Modelica.SIunits.Time T=0.2 "Time constant";
  Vector2D v(x(start=0),y(start=0)) "Integral of a/T";
equation
  der(v.x)=a.x/T;
  der(v.y)=a.y/T;
end UseVector2D;
