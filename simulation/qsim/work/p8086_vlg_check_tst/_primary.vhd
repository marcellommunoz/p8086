library verilog;
use verilog.vl_types.all;
entity p8086_vlg_check_tst is
    port(
        saidaAX         : in     vl_logic_vector(15 downto 0);
        saidaBP         : in     vl_logic_vector(15 downto 0);
        saidaBX         : in     vl_logic_vector(15 downto 0);
        saidaCS         : in     vl_logic_vector(15 downto 0);
        saidaCX         : in     vl_logic_vector(15 downto 0);
        saidaDI         : in     vl_logic_vector(15 downto 0);
        saidaDS         : in     vl_logic_vector(15 downto 0);
        saidaDX         : in     vl_logic_vector(15 downto 0);
        saidaES         : in     vl_logic_vector(15 downto 0);
        saidaI1         : in     vl_logic_vector(15 downto 0);
        saidaI2         : in     vl_logic_vector(15 downto 0);
        saidaI3         : in     vl_logic_vector(15 downto 0);
        saidaIP         : in     vl_logic_vector(15 downto 0);
        saidaIQ         : in     vl_logic_vector(7 downto 0);
        saidaMem        : in     vl_logic_vector(7 downto 0);
        saidaQueueFull  : in     vl_logic;
        saidaQueueR     : in     vl_logic;
        saidaQueueVazia : in     vl_logic;
        saidaQueueW     : in     vl_logic;
        saidaSI         : in     vl_logic_vector(15 downto 0);
        saidaSP         : in     vl_logic_vector(15 downto 0);
        saidaSS         : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end p8086_vlg_check_tst;
