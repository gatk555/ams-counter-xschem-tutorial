v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
B 2 495 -960 1295 -560 {flags=graph
y1=0
y2=2
ypos1=0.12703394
ypos2=1.7910429
divy=5
subdivy=1
unity=1
x1=8e-06
x2=4.8e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="clk
----
count_out; count_out3,count_out2,count_out1,count_out0
---
count_out3
count_out2
count_out1
count_out0"
color="8 9 11 9 11 11 11 11 4"
dataset=-1
unitx=1
logx=0
logy=0
digital=1
}
B 2 495 -1365 1295 -965 {flags=graph
y1=1e-6

ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=8e-06
x2=4.8e-05
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
dataset=-1
unitx=1
logx=0
logy=0
color=4
node=i(VAMM)
hilight_wave=-1
y2=100e-6}
N -180 -850 -130 -850 {lab=CLK}
N 230 -850 270 -850 {bus=1 lab=count_out[3..0]}
N 10 -850 230 -850 {bus=1 lab=count_out[3..0]}
N -340 -220 -340 -180 {
lab=CLK}
N -340 -120 -340 -90 {
lab=0}
N 90 -160 90 -120 {
lab=Vg}
N 90 -60 90 -20 {
lab=0}
N 90 -160 170 -160 {
lab=Vg}
N 170 -160 170 -90 {
lab=Vg}
N 130 -90 170 -90 {
lab=Vg}
N 0 -90 90 -90 {
lab=0}
N 0 -90 0 -20 {
lab=0}
N 0 -20 90 -20 {
lab=0}
N -70 -120 -70 -20 {
lab=0}
N -70 -20 0 -20 {
lab=0}
N 90 -440 90 -430 {
lab=#net1}
N -70 -440 90 -440 {
lab=#net1}
N 90 -370 90 -160 {
lab=Vg}
N -70 -440 -70 -180 {
lab=#net1}
N 270 -440 270 -430 {
lab=#net1}
N 90 -440 270 -440 {
lab=#net1}
N 270 -60 270 -20 {
lab=0}
N 270 -90 360 -90 {
lab=0}
N 360 -90 360 -20 {
lab=0}
N 270 -20 360 -20 {
lab=0}
N 270 -260 270 -240 {
lab=#net2}
N 270 -210 360 -210 {
lab=0}
N 360 -210 360 -90 {
lab=0}
N 430 -90 480 -90 {
lab=Vg}
N 520 -60 520 -20 {
lab=0}
N 520 -90 610 -90 {
lab=0}
N 610 -90 610 -20 {
lab=0}
N 520 -20 610 -20 {
lab=0}
N 520 -180 520 -120 {
lab=#net3}
N 520 -260 520 -240 {
lab=#net2}
N 430 -210 480 -210 {
lab=count_out1}
N 520 -210 610 -210 {
lab=0}
N 610 -210 610 -90 {
lab=0}
N 270 -260 520 -260 {
lab=#net2}
N 360 -20 520 -20 {
lab=0}
N 680 -90 730 -90 {
lab=Vg}
N 770 -60 770 -20 {
lab=0}
N 770 -90 860 -90 {
lab=0}
N 860 -90 860 -20 {
lab=0}
N 770 -20 860 -20 {
lab=0}
N 770 -180 770 -120 {
lab=#net4}
N 770 -260 770 -240 {
lab=#net2}
N 680 -210 730 -210 {
lab=count_out2}
N 770 -210 860 -210 {
lab=0}
N 860 -210 860 -90 {
lab=0}
N 520 -260 770 -260 {
lab=#net2}
N 610 -20 770 -20 {
lab=0}
N 930 -90 980 -90 {
lab=Vg}
N 1020 -60 1020 -20 {
lab=0}
N 1020 -90 1110 -90 {
lab=0}
N 1110 -90 1110 -20 {
lab=0}
N 1020 -20 1110 -20 {
lab=0}
N 1020 -180 1020 -120 {
lab=#net5}
N 1020 -260 1020 -240 {
lab=#net2}
N 930 -210 980 -210 {
lab=count_out3}
N 1020 -210 1110 -210 {
lab=0}
N 1110 -210 1110 -90 {
lab=0}
N 770 -260 1020 -260 {
lab=#net2}
N 860 -20 1020 -20 {
lab=0}
N 270 -430 270 -380 {lab=#net1}
N 270 -180 270 -120 {lab=#net6}
N 170 -90 230 -90 {lab=Vg}
N 210 -210 230 -210 {lab=count_out0}
N 170 -210 220 -210 {
lab=count_out0}
N 170 -210 220 -210 {
lab=count_out0}
N 170 -90 170 -60 {lab=Vg}
N 270 -330 270 -260 {lab=#net2}
N 90 -20 270 -20 {lab=0}
C {netlist.sym} 1240 -320 0 0 {name=NGSPICE only_toplevel=true 
value="
.temp 27

*.option method=gear
.param VCC=1.5

.control
save all
tran 1n 50u
*plot i(Vmeas) i(Vmeas1) 
remzerovec
write current_mirror_cosim.raw
.endc
"}
C {lab_pin.sym} -180 -850 0 0 {name=p3 lab=CLK}
C {lab_pin.sym} 270 -850 0 1 {name=p5 lab=count_out[3..0]}
C {launcher.sym} 1050 -435 0 0 {name=h5
descr="load waves" 
tclcommand="xschem raw_read $netlist_dir/[file tail [file rootname [xschem get current_name]]].raw tran"
}
C {launcher.sym} 1050 -385 0 0 {name=h1
descr="Icarusate Design" 
tclcommand="execute 1 sh -c \\"cd $netlist_dir; iverilog -o counter [abs_sym_path ./counter.v]\\""}
C {counter.sym} -60 -850 0 0 {name=a1 model=counter

device_model=".model counter d_cosim simulation=\\"ivlng\\" sim_args=[\\"counter\\"] delay=0"

tclcommand="edit_file [abs_sym_path counter.v]"}
C {vsource.sym} -340 -150 0 0 {name=V2 value="pulse 0 'VCC' 500n 10n 10n 490n 1u" savecurrent=false}
C {lab_wire.sym} -340 -210 0 0 {name=p2 sig_type=std_logic lab=CLK}
C {lab_wire.sym} -340 -90 0 0 {name=p10 sig_type=std_logic lab=0}
C {nmos4.sym} 110 -90 0 1 {name=M1
l=1u
w=2u
m=1
model=nm
device_model=".model nm nmos level=54 version=4.8.3"
}
C {isource.sym} 90 -400 0 0 {name=I0 value=10u}
C {vsource.sym} -70 -150 0 0 {name=V1 value=1.5 savecurrent=false}
C {lab_wire.sym} 25 -20 0 0 {name=p14 sig_type=std_logic lab=0}
C {ammeter.sym} 270 -360 0 0 {name=VAMM savecurrent=0 spice_ignore=0}
C {nmos4.sym} 250 -210 0 0 {name=M3
l=0.13u
w=10u
m=1
model=nm
}
C {nmos4.sym} 250 -90 0 0 {name=M4
l=1u
w=0.5u
m=1
model=nm
}
C {lab_wire.sym} 210 -210 0 0 {name=p13 sig_type=std_logic lab=count_out0}
C {nmos4.sym} 500 -210 0 0 {name=M5
l=0.13u
w=10u
m=1
model=nm
}
C {nmos4.sym} 500 -90 0 0 {name=M6
l=1u
w=1u
m=1
model=nm
}
C {lab_wire.sym} 450 -90 0 0 {name=p8 sig_type=std_logic lab=Vg}
C {lab_wire.sym} 460 -210 0 0 {name=p15 sig_type=std_logic lab=count_out1}
C {nmos4.sym} 750 -210 0 0 {name=M7
l=0.13u
w=10u
m=1
model=nm
}
C {nmos4.sym} 750 -90 0 0 {name=M8
l=1u
w=2u
m=1
model=nm
}
C {lab_wire.sym} 700 -90 0 0 {name=p7 sig_type=std_logic lab=Vg}
C {lab_wire.sym} 710 -210 0 0 {name=p16 sig_type=std_logic lab=count_out2}
C {nmos4.sym} 1000 -210 0 0 {name=M9
l=0.13u
w=10u
m=1
model=nm
}
C {nmos4.sym} 1000 -90 0 0 {name=M10
l=1u
w=4u
m=1
model=nm
}
C {lab_wire.sym} 950 -90 0 0 {name=p1 sig_type=std_logic lab=Vg}
C {lab_wire.sym} 960 -210 0 0 {name=p4 sig_type=std_logic lab=count_out3}
C {lab_wire.sym} 170 -60 2 1 {name=p6 sig_type=std_logic lab=Vg}
