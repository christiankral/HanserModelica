within HanserModelica.Electrical;
model TestRLSeriesRecord "Testing component RLSeriesRecord"
  extends Modelica.Icons.Example;
  Components.RLSeriesRecord rlSeries(rlData=rlData) annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Modelica.Electrical.Analog.Sources.StepVoltage stepVoltage(V=10, startTime=0.2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,0})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  parameter Records.RLDataElectrical1 rlData annotation (Placement(transformation(extent={{20,-8},{40,12}})));
equation
  connect(ground.p, stepVoltage.n) annotation (Line(
      points={{-30,-20},{-30,-15},{-30,-10}},
      color={0,0,255},
      smooth=Smooth.Bezier));
  connect(stepVoltage.p, rlSeries.p) annotation (Line(points={{-30,10},{-30,10},{-30,20},{-20,20}}, color={0,0,255}));
  connect(rlSeries.n, ground.p) annotation (Line(points={{0,20},{10,20},{10,-20},{-30,-20}}, color={0,0,255}));
  annotation (experiment(Interval=0.001, Tolerance=1e-06), Documentation(info="<html>
<h5>Plot the following variable(s)</h5>

<ul>
<li><code>rlSeries.i</code>: current of circuit</li>
</ul>
</html>"));
end TestRLSeriesRecord;
