within HanserModelica.Electrical;
model TestBrush "Test of brush model"
  extends Modelica.Icons.Example;

  Components.Brush brush(ILinear=0.1, V=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,20})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-70,-20},{-50,0}})));
  Modelica.Electrical.Analog.Sources.RampCurrent rampCurrent(
    I=2,
    duration=1,
    offset=-1,
    startTime=0) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-60,20})));
equation
  connect(rampCurrent.p, ground.p) annotation (Line(points={{-60,30},{-60,0}}, color={0,0,255}));
  connect(ground.p, brush.n) annotation (Line(points={{-60,0},{-30,0},{-30,10}}, color={0,0,255}));
  connect(rampCurrent.n, brush.p) annotation (Line(points={{-60,10},{-60,40},{-30,40},{-30,30}}, color={0,0,255}));
  annotation (Documentation(info="<html>
<h4>Description</h4>

<p>This examples demonstrates the application of a 
<a href=\"modelica://HanserModelica.Electrical.Components.Brush\">brush</a> model.</p>

<h4>Plot the following variable(s)</h4>

<ul>
<li><code>brush.v</code> against <code>brush.i</code>: brush characteristic</li>
</ul>
</html>"));
end TestBrush;
