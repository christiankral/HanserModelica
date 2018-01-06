within HanserModelica.SynchronousMachines;
model SMEE_ShortCircuit1 "0ne phase short circuit of electrical excited synchronous machine "
  extends HanserModelica.SynchronousMachines.Templates.SMEE_ShortCircuit;
  extends Modelica.Icons.Example;
equation
  connect(ground.p, pin1.pin_p) annotation (Line(points={{-60,50},{-60,70},{-42,70}}, color={0,0,255}));
  annotation(experiment(StopTime=0.3,Interval=0.0001,Tolerance=1e-08));
end SMEE_ShortCircuit1;
