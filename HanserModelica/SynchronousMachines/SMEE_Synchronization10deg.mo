within HanserModelica.SynchronousMachines;
model SMEE_Synchronization10deg "Synchronizazion of electrical excited synchronous machine with 10° voltage phase shift"
  extends SMEE_Synchronization(phi=Modelica.SIunits.Conversions.from_deg(10));
end SMEE_Synchronization10deg;
