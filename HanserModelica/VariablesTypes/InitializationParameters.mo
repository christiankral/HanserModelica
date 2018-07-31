within HanserModelica.VariablesTypes;
model InitializationParameters "Initialization of parameters"
  extends Modelica.Icons.Example;
  parameter Integer a=5;                 // Explicit assingment
  parameter Real b(start=0);             // Not fixed
  parameter Real c(fixed=false);         // Not assigned here
  parameter Real d(start=0,fixed=false); // Only start value is assigned here
  parameter Real e(fixed=false);         // Not assigned here
  parameter Real f(fixed=false,start=1); // Only start value is assigned here
  constant Real A[:,:]={{2,1},{3,4}};    // Matrix to be inverted
  parameter Real Ainv[2,2](fixed=fill(false,2,2));
  parameter Real Binv[2,2]=Modelica.Math.Matrices.inv(A);
initial equation
  c=0;
  d^2-10*d+9=0;                          // Quadratic equation
  e=cos(e);                              // Non-linear implicit equation
  A*Ainv=identity(size(A,1));            // Implicit calculation
initial algorithm
  for i in 1:a loop                      // i in 1:a = {1,2,...,a}
    f:=f*i;
  end for;
  annotation (Documentation(info="<html>
<h4>Description</h4>

<p>This simulation model shows different initialization methods of parameters.</p>
</html>"));
end InitializationParameters;
