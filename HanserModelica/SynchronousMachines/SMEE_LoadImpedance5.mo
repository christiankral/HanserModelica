within HanserModelica.SynchronousMachines;
model SMEE_LoadImpedance5 "Electrical excited synchronous machine operating at variable load impedance with angle 60° cap."
  import Modelica.Constants.pi;
  extends SMEE_LoadImpedance1( phi=45*pi/180);
end SMEE_LoadImpedance5;
