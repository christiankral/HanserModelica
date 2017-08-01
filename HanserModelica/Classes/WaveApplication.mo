within HanserModelica.Classes;
model WaveApplication "Application of different sine waves"
  extends Modelica.Icons.Example;
  SineWave sineWave1(A=10,f=2);
  SineWave sineWave2(A=8,f=1);
  CosineWave cosineWave1(A=10,f=2);
  Real s1 "Alias variable of sine wave 1";
  Real s2=sineWave2.wave "Alias variable of sine wave 2";
equation
  s1=sineWave1.wave;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end WaveApplication;
