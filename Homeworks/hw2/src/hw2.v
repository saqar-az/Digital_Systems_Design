module out (
    input a, b, c, d, e,
    output out
);
    supply1 Vdd;  
    supply0 Gnd; 
    wire ab_plus, cd_plus, w1, w2;

    nmos (ab_plus, Gnd, a);
    nmos (ab_plus, Gnd, b);
    nmos (cd_plus, ab_plus, c);
    nmos (cd_plus, ab_plus, d);
    nmos (out, cd_plus, e);

    pmos (out, w1, a);
    pmos (w1, Vdd, b);
    pmos (out, w2, c);
    pmos (w2, Vdd, d);
    pmos (out, Vdd, e);

endmodule


module tb_out;
    reg a, b, c, d, e;
    wire out;

    out ex (.a(a), .b(b), .c(c), .d(d), .e(e), .out(out));

    initial begin
        a=0; b=0; c=0; d=0; e=0; #5;
        a=0; b=0; c=0; d=0; e=1; #5;
        a=1; b=0; c=0; d=0; e=0; #5;
        a=1; b=0; c=0; d=0; e=1; #5;
        a=1; b=0; c=1; d=0; e=1; #5;
        a=0; b=1; c=0; d=1; e=1; #5;
        a=1; b=1; c=1; d=1; e=1; #5;
        $finish;
    end
endmodule


