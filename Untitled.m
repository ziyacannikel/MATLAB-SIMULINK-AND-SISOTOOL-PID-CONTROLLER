%% ROOT LOCUS
% The root locus is a graphical representation in s-domain and it
% is symetrical about the reel aXis. Because the open loop poles
% and zeros exist in the s-domain having the values either as real
% or as copmlex conjugate pairs.
%% DÝSTURBANCE D(S)
G=tf([1 5], [1 14 40 ]);         %G(s)
d1=tf([3],[1 0],'inputdelay',4); %First part of D(s)
d2=tf([3],[1 0],'inputdelay',5); %Second part of D(s) 
D=d1-d2;                         %Defining of disturbance function 
%% PID 

kp=1;
ki=0;
kd=0;
% Only kp = 1 
MyPID=tf(pid(kp,ki,kd));
%% SYSTEM DEFÝNATÝON

sys=feedback(series(MyPID+D,G),1);%%System 
sysp=pade(sys);                   %%Approximation with delays
rlocus(sysp);                     %%Sketching of rlocus 
grid on;

%% STEP RESPONSE :
% Since assumed that PID controller contains only proportional constant Kp 
% and ignored disturbance D(s)

%%
G=tf([1 5], [1 14 40 ]); % G(s) defination
%% PID 
kp=1;
ki=0;
kd=0;
MyPID=tf(pid(kp,ki,kd));
%%SYSTEM
sys=feedback(series(MyPID,G),1);
step(sys); %% plot
grid on:

%% SISOTOOL

% The PID controller is a combination of PD and PI controllers
% PID CONTROLLER WÝTH SISOTOOL USÝNG ZÝEGLER-NÝCHOLS METHOD:
% According to classic ziegler-nichols method:
% Kp=0.6*Ku  ,  Ti=0.5*Tu , Td=0,125*Tu
% Tu :The period of the oscilation frequency stability Limit
% Ku :The gain margin for loop stability
% Ti :The controller's integrator time constant 
% Td :The controller's derrivative time constant
%% SISOTOOL CODE
s=tf('s');
sysG=(s+5)/(s^2+14*s+40 );
kp=1;
ki=0;
kd=0;
PidKp=pid(Kp,Ki,Kd);
sys=feedback(PidKp*sysG,1);
sisotool(sys);
