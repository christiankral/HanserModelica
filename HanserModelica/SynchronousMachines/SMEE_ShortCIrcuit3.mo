within HanserModelica.SynchronousMachines;
model SMEE_ShortCIrcuit3 "Three phase short circuit of electrical excited synchronous machine "
  extends HanserModelica.SynchronousMachines.Templates.SMEE_ShortCIrcuit;
equation
  connect(pin1.pin_p, pin2.pin_p) annotation (Line(points={{-42,70},{-50,70},{-50,50},{-42,50}}, color={0,0,255}));
  connect(pin2.pin_p, pin3.pin_p) annotation (Line(points={{-42,50},{-50,50},{-50,30},{-42,30}}, color={0,0,255}));
  annotation(experiment(StopTime=0.3,Interval=0.0001,Tolerance=1e-08));
end SMEE_ShortCIrcuit3;
