library verilog;
use verilog.vl_types.all;
entity p8086_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        entradaAX       : in     vl_logic_vector(15 downto 0);
        entradaBP       : in     vl_logic_vector(15 downto 0);
        entradaBX       : in     vl_logic_vector(15 downto 0);
        entradaCS       : in     vl_logic_vector(15 downto 0);
        entradaCX       : in     vl_logic_vector(15 downto 0);
        entradaDI       : in     vl_logic_vector(15 downto 0);
        entradaDS       : in     vl_logic_vector(15 downto 0);
        entradaDX       : in     vl_logic_vector(15 downto 0);
        entradaES       : in     vl_logic_vector(15 downto 0);
        entradaI1       : in     vl_logic_vector(15 downto 0);
        entradaI2       : in     vl_logic_vector(15 downto 0);
        entradaI3       : in     vl_logic_vector(15 downto 0);
        entradaIP       : in     vl_logic_vector(15 downto 0);
        entradaSI       : in     vl_logic_vector(15 downto 0);
        entradaSP       : in     vl_logic_vector(15 downto 0);
        entradaSS       : in     vl_logic_vector(15 downto 0);
        reset           : in     vl_logic;
        wDEBUG          : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end p8086_vlg_sample_tst;
