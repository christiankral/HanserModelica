within HanserModelica.VariablesTypes;
model InitializationParameters
  extends Modelica.Icons.Example;
  parameter Integer a=5;                 // explicit assingment
  parameter Real b(start=0);             // not fixed
  parameter Real c(start=0,fixed=false); // not assigned here
  parameter Real d(start=0,fixed=false); // not assigned here
  parameter Real e(fixed=false);         // not assigned here
  parameter Real f(fixed=false,start=1); // not assigned here
  constant Real A[:,:]={{2,1},{3,4}};    // Matrix to be inverted
  parameter Real Ainv[2,2](fixed=fill(false,2,2));
  parameter Real Binv[2,2]=Modelica.Math.Matrices.inv(A);
initial equation
  c=0;
  d^2-10*d+9=0;                          // quadratic equation
  e=cos(e);                              // non-linear equation
  A*Ainv=identity(size(A,1));            // implicit calculation
initial algorithm
  for i in 1:a loop                      // i in 1:a = [1,2,...,a]
    f:=f*i;
  end for;
end InitializationParameters;
