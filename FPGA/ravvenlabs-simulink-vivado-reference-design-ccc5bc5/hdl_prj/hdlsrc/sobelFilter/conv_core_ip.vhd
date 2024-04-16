-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\sobelFilter\conv_core_ip.vhd
-- Created: 2024-04-16 16:13:22
-- 
-- Generated by MATLAB 24.1, HDL Coder 24.1, and Simulink 24.1
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: -1
-- Target subsystem base rate: -1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: conv_core_ip
-- Source Path: conv_core_ip
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY conv_core_ip IS
  PORT( IPCORE_CLK                        :   IN    std_logic;  -- ufix1
        IPCORE_RESETN                     :   IN    std_logic;  -- ufix1
        AXI4_Stream_Video_Master_TREADY   :   IN    std_logic;  -- ufix1
        AXI4_Stream_Video_Slave_TDATA     :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
        AXI4_Stream_Video_Slave_TVALID    :   IN    std_logic;  -- ufix1
        AXI4_Stream_Video_Slave_TLAST     :   IN    std_logic;  -- ufix1
        AXI4_Stream_Video_Slave_TUSER     :   IN    std_logic;  -- ufix1
        AXI4_Lite_ACLK                    :   IN    std_logic;  -- ufix1
        AXI4_Lite_ARESETN                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_AWADDR                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        AXI4_Lite_AWVALID                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_WDATA                   :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_WSTRB                   :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
        AXI4_Lite_WVALID                  :   IN    std_logic;  -- ufix1
        AXI4_Lite_BREADY                  :   IN    std_logic;  -- ufix1
        AXI4_Lite_ARADDR                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        AXI4_Lite_ARVALID                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_RREADY                  :   IN    std_logic;  -- ufix1
        AXI4_Stream_Video_Master_TDATA    :   OUT   std_logic_vector(63 DOWNTO 0);  -- ufix64
        AXI4_Stream_Video_Master_TVALID   :   OUT   std_logic;  -- ufix1
        AXI4_Stream_Video_Master_TLAST    :   OUT   std_logic;  -- ufix1
        AXI4_Stream_Video_Master_TUSER    :   OUT   std_logic;  -- ufix1
        AXI4_Stream_Video_Slave_TREADY    :   OUT   std_logic;  -- ufix1
        AXI4_Lite_AWREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_WREADY                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_BRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_BVALID                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_ARREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_RDATA                   :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_RRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_RVALID                  :   OUT   std_logic  -- ufix1
        );
END conv_core_ip;


ARCHITECTURE rtl OF conv_core_ip IS

  -- Component Declarations
  COMPONENT conv_core_ip_reset_sync
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset_in                        :   IN    std_logic;  -- ufix1
          reset_out                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT conv_core_ip_axi_lite
    PORT( reset                           :   IN    std_logic;
          AXI4_Lite_ACLK                  :   IN    std_logic;  -- ufix1
          AXI4_Lite_ARESETN               :   IN    std_logic;  -- ufix1
          AXI4_Lite_AWADDR                :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          AXI4_Lite_AWVALID               :   IN    std_logic;  -- ufix1
          AXI4_Lite_WDATA                 :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_WSTRB                 :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
          AXI4_Lite_WVALID                :   IN    std_logic;  -- ufix1
          AXI4_Lite_BREADY                :   IN    std_logic;  -- ufix1
          AXI4_Lite_ARADDR                :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          AXI4_Lite_ARVALID               :   IN    std_logic;  -- ufix1
          AXI4_Lite_RREADY                :   IN    std_logic;  -- ufix1
          read_ip_timestamp               :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_AWREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_WREADY                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_BRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_BVALID                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_ARREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_RDATA                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_RRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_RVALID                :   OUT   std_logic;  -- ufix1
          write_axi_enable                :   OUT   std_logic;  -- ufix1
          write_axi4_stream_video_slave_image_width :   OUT   std_logic_vector(12 DOWNTO 0);  -- ufix13
          write_axi4_stream_video_slave_image_height :   OUT   std_logic_vector(12 DOWNTO 0);  -- ufix13
          write_axi4_stream_video_slave_hporch :   OUT   std_logic_vector(12 DOWNTO 0);  -- ufix13
          write_axi4_stream_video_slave_vporch :   OUT   std_logic_vector(12 DOWNTO 0);  -- ufix13
          reset_internal                  :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT conv_core_ip_axi4_stream_video_slave
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          AXI4_Stream_Video_Slave_TDATA   :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
          AXI4_Stream_Video_Slave_TVALID  :   IN    std_logic;  -- ufix1
          AXI4_Stream_Video_Slave_TLAST   :   IN    std_logic;  -- ufix1
          AXI4_Stream_Video_Slave_TUSER   :   IN    std_logic;  -- ufix1
          auto_ready                      :   IN    std_logic;  -- ufix1
          write_axi4_stream_video_slave_image_width :   IN    std_logic_vector(12 DOWNTO 0);  -- ufix13
          write_axi4_stream_video_slave_image_height :   IN    std_logic_vector(12 DOWNTO 0);  -- ufix13
          write_axi4_stream_video_slave_hporch :   IN    std_logic_vector(12 DOWNTO 0);  -- ufix13
          write_axi4_stream_video_slave_vporch :   IN    std_logic_vector(12 DOWNTO 0);  -- ufix13
          AXI4_Stream_Video_Slave_TREADY  :   OUT   std_logic;  -- ufix1
          user_pixel                      :   OUT   std_logic_vector(63 DOWNTO 0);  -- ufix64
          user_ctrl_hStart                :   OUT   std_logic;  -- ufix1
          user_ctrl_hEnd                  :   OUT   std_logic;  -- ufix1
          user_ctrl_vStart                :   OUT   std_logic;  -- ufix1
          user_ctrl_vEnd                  :   OUT   std_logic;  -- ufix1
          user_ctrl_valid                 :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT conv_core_ip_dut
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          dut_enable                      :   IN    std_logic;  -- ufix1
          Video_in                        :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
          ctrl_hStart                     :   IN    std_logic;  -- ufix1
          ctrl_hEnd                       :   IN    std_logic;  -- ufix1
          ctrl_vStart                     :   IN    std_logic;  -- ufix1
          ctrl_vEnd                       :   IN    std_logic;  -- ufix1
          ctrl_valid                      :   IN    std_logic;  -- ufix1
          ce_out                          :   OUT   std_logic;  -- ufix1
          Video_out                       :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          valid_out_hStart                :   OUT   std_logic;  -- ufix1
          valid_out_hEnd                  :   OUT   std_logic;  -- ufix1
          valid_out_vStart                :   OUT   std_logic;  -- ufix1
          valid_out_vEnd                  :   OUT   std_logic;  -- ufix1
          valid_out_valid                 :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT conv_core_ip_axi4_stream_video_master
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          AXI4_Stream_Video_Master_TREADY :   IN    std_logic;  -- ufix1
          user_pixel                      :   IN    std_logic_vector(63 DOWNTO 0);  -- ufix64
          user_ctrl_hStart                :   IN    std_logic;  -- ufix1
          user_ctrl_hEnd                  :   IN    std_logic;  -- ufix1
          user_ctrl_vStart                :   IN    std_logic;  -- ufix1
          user_ctrl_vEnd                  :   IN    std_logic;  -- ufix1
          user_ctrl_valid                 :   IN    std_logic;  -- ufix1
          AXI4_Stream_Video_Master_TDATA  :   OUT   std_logic_vector(63 DOWNTO 0);  -- ufix64
          AXI4_Stream_Video_Master_TVALID :   OUT   std_logic;  -- ufix1
          AXI4_Stream_Video_Master_TLAST  :   OUT   std_logic;  -- ufix1
          AXI4_Stream_Video_Master_TUSER  :   OUT   std_logic;  -- ufix1
          auto_ready                      :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : conv_core_ip_reset_sync
    USE ENTITY work.conv_core_ip_reset_sync(rtl);

  FOR ALL : conv_core_ip_axi_lite
    USE ENTITY work.conv_core_ip_axi_lite(rtl);

  FOR ALL : conv_core_ip_axi4_stream_video_slave
    USE ENTITY work.conv_core_ip_axi4_stream_video_slave(rtl);

  FOR ALL : conv_core_ip_dut
    USE ENTITY work.conv_core_ip_dut(rtl);

  FOR ALL : conv_core_ip_axi4_stream_video_master
    USE ENTITY work.conv_core_ip_axi4_stream_video_master(rtl);

  -- Signals
  SIGNAL reset                            : std_logic;
  SIGNAL enb                              : std_logic;
  SIGNAL ip_timestamp                     : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reset_cm                         : std_logic;  -- ufix1
  SIGNAL reset_internal                   : std_logic;  -- ufix1
  SIGNAL reset_before_sync                : std_logic;  -- ufix1
  SIGNAL AXI4_Lite_BRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL AXI4_Lite_RDATA_tmp              : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL AXI4_Lite_RRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL write_axi_enable                 : std_logic;  -- ufix1
  SIGNAL write_axi4_stream_video_slave_image_width : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL write_axi4_stream_video_slave_image_height : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL write_axi4_stream_video_slave_hporch : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL write_axi4_stream_video_slave_vporch : std_logic_vector(12 DOWNTO 0);  -- ufix13
  SIGNAL const_1_1                        : std_logic;  -- ufix1
  SIGNAL auto_ready_axi4_stream_video_master : std_logic;  -- ufix1
  SIGNAL top_user_pixel                   : std_logic_vector(63 DOWNTO 0);  -- ufix64
  SIGNAL top_user_ctrl_hStart             : std_logic;  -- ufix1
  SIGNAL top_user_ctrl_hEnd               : std_logic;  -- ufix1
  SIGNAL top_user_ctrl_vStart             : std_logic;  -- ufix1
  SIGNAL top_user_ctrl_vEnd               : std_logic;  -- ufix1
  SIGNAL top_user_ctrl_valid              : std_logic;  -- ufix1
  SIGNAL auto_ready_dut_enb               : std_logic;  -- ufix1
  SIGNAL dut_enable                       : std_logic;  -- ufix1
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL Video_out_sig                    : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL valid_out_hStart_sig             : std_logic;  -- ufix1
  SIGNAL valid_out_hEnd_sig               : std_logic;  -- ufix1
  SIGNAL valid_out_vStart_sig             : std_logic;  -- ufix1
  SIGNAL valid_out_vEnd_sig               : std_logic;  -- ufix1
  SIGNAL valid_out_valid_sig              : std_logic;  -- ufix1
  SIGNAL Video_out_sig_unsigned           : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL top_user_pixel_1                 : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL AXI4_Stream_Video_Master_TDATA_tmp : std_logic_vector(63 DOWNTO 0);  -- ufix64

BEGIN
  u_conv_core_ip_reset_sync_inst : conv_core_ip_reset_sync
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset_in => reset_before_sync,  -- ufix1
              reset_out => reset
              );

  u_conv_core_ip_axi_lite_inst : conv_core_ip_axi_lite
    PORT MAP( reset => reset,
              AXI4_Lite_ACLK => AXI4_Lite_ACLK,  -- ufix1
              AXI4_Lite_ARESETN => AXI4_Lite_ARESETN,  -- ufix1
              AXI4_Lite_AWADDR => AXI4_Lite_AWADDR,  -- ufix16
              AXI4_Lite_AWVALID => AXI4_Lite_AWVALID,  -- ufix1
              AXI4_Lite_WDATA => AXI4_Lite_WDATA,  -- ufix32
              AXI4_Lite_WSTRB => AXI4_Lite_WSTRB,  -- ufix4
              AXI4_Lite_WVALID => AXI4_Lite_WVALID,  -- ufix1
              AXI4_Lite_BREADY => AXI4_Lite_BREADY,  -- ufix1
              AXI4_Lite_ARADDR => AXI4_Lite_ARADDR,  -- ufix16
              AXI4_Lite_ARVALID => AXI4_Lite_ARVALID,  -- ufix1
              AXI4_Lite_RREADY => AXI4_Lite_RREADY,  -- ufix1
              read_ip_timestamp => std_logic_vector(ip_timestamp),  -- ufix32
              AXI4_Lite_AWREADY => AXI4_Lite_AWREADY,  -- ufix1
              AXI4_Lite_WREADY => AXI4_Lite_WREADY,  -- ufix1
              AXI4_Lite_BRESP => AXI4_Lite_BRESP_tmp,  -- ufix2
              AXI4_Lite_BVALID => AXI4_Lite_BVALID,  -- ufix1
              AXI4_Lite_ARREADY => AXI4_Lite_ARREADY,  -- ufix1
              AXI4_Lite_RDATA => AXI4_Lite_RDATA_tmp,  -- ufix32
              AXI4_Lite_RRESP => AXI4_Lite_RRESP_tmp,  -- ufix2
              AXI4_Lite_RVALID => AXI4_Lite_RVALID,  -- ufix1
              write_axi_enable => write_axi_enable,  -- ufix1
              write_axi4_stream_video_slave_image_width => write_axi4_stream_video_slave_image_width,  -- ufix13
              write_axi4_stream_video_slave_image_height => write_axi4_stream_video_slave_image_height,  -- ufix13
              write_axi4_stream_video_slave_hporch => write_axi4_stream_video_slave_hporch,  -- ufix13
              write_axi4_stream_video_slave_vporch => write_axi4_stream_video_slave_vporch,  -- ufix13
              reset_internal => reset_internal  -- ufix1
              );

  u_conv_core_ip_axi4_stream_video_slave_inst : conv_core_ip_axi4_stream_video_slave
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              enb => const_1_1,
              AXI4_Stream_Video_Slave_TDATA => AXI4_Stream_Video_Slave_TDATA,  -- ufix64
              AXI4_Stream_Video_Slave_TVALID => AXI4_Stream_Video_Slave_TVALID,  -- ufix1
              AXI4_Stream_Video_Slave_TLAST => AXI4_Stream_Video_Slave_TLAST,  -- ufix1
              AXI4_Stream_Video_Slave_TUSER => AXI4_Stream_Video_Slave_TUSER,  -- ufix1
              auto_ready => auto_ready_axi4_stream_video_master,  -- ufix1
              write_axi4_stream_video_slave_image_width => write_axi4_stream_video_slave_image_width,  -- ufix13
              write_axi4_stream_video_slave_image_height => write_axi4_stream_video_slave_image_height,  -- ufix13
              write_axi4_stream_video_slave_hporch => write_axi4_stream_video_slave_hporch,  -- ufix13
              write_axi4_stream_video_slave_vporch => write_axi4_stream_video_slave_vporch,  -- ufix13
              AXI4_Stream_Video_Slave_TREADY => AXI4_Stream_Video_Slave_TREADY,  -- ufix1
              user_pixel => top_user_pixel,  -- ufix64
              user_ctrl_hStart => top_user_ctrl_hStart,  -- ufix1
              user_ctrl_hEnd => top_user_ctrl_hEnd,  -- ufix1
              user_ctrl_vStart => top_user_ctrl_vStart,  -- ufix1
              user_ctrl_vEnd => top_user_ctrl_vEnd,  -- ufix1
              user_ctrl_valid => top_user_ctrl_valid  -- ufix1
              );

  u_conv_core_ip_dut_inst : conv_core_ip_dut
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              dut_enable => dut_enable,  -- ufix1
              Video_in => top_user_pixel,  -- ufix64
              ctrl_hStart => top_user_ctrl_hStart,  -- ufix1
              ctrl_hEnd => top_user_ctrl_hEnd,  -- ufix1
              ctrl_vStart => top_user_ctrl_vStart,  -- ufix1
              ctrl_vEnd => top_user_ctrl_vEnd,  -- ufix1
              ctrl_valid => top_user_ctrl_valid,  -- ufix1
              ce_out => ce_out_sig,  -- ufix1
              Video_out => Video_out_sig,  -- ufix32
              valid_out_hStart => valid_out_hStart_sig,  -- ufix1
              valid_out_hEnd => valid_out_hEnd_sig,  -- ufix1
              valid_out_vStart => valid_out_vStart_sig,  -- ufix1
              valid_out_vEnd => valid_out_vEnd_sig,  -- ufix1
              valid_out_valid => valid_out_valid_sig  -- ufix1
              );

  u_conv_core_ip_axi4_stream_video_master_inst : conv_core_ip_axi4_stream_video_master
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              enb => const_1_1,
              AXI4_Stream_Video_Master_TREADY => AXI4_Stream_Video_Master_TREADY,  -- ufix1
              user_pixel => std_logic_vector(top_user_pixel_1),  -- ufix64
              user_ctrl_hStart => valid_out_hStart_sig,  -- ufix1
              user_ctrl_hEnd => valid_out_hEnd_sig,  -- ufix1
              user_ctrl_vStart => valid_out_vStart_sig,  -- ufix1
              user_ctrl_vEnd => valid_out_vEnd_sig,  -- ufix1
              user_ctrl_valid => valid_out_valid_sig,  -- ufix1
              AXI4_Stream_Video_Master_TDATA => AXI4_Stream_Video_Master_TDATA_tmp,  -- ufix64
              AXI4_Stream_Video_Master_TVALID => AXI4_Stream_Video_Master_TVALID,  -- ufix1
              AXI4_Stream_Video_Master_TLAST => AXI4_Stream_Video_Master_TLAST,  -- ufix1
              AXI4_Stream_Video_Master_TUSER => AXI4_Stream_Video_Master_TUSER,  -- ufix1
              auto_ready => auto_ready_axi4_stream_video_master  -- ufix1
              );

  ip_timestamp <= unsigned'(X"8F4C984D");

  reset_cm <=  NOT IPCORE_RESETN;

  reset_before_sync <= reset_cm OR reset_internal;

  const_1_1 <= '1';

  enb <= const_1_1;

  reg_process : PROCESS (IPCORE_CLK)
  BEGIN
    IF IPCORE_CLK'EVENT AND IPCORE_CLK = '1' THEN
      IF reset = '1' THEN
        auto_ready_dut_enb <= '0';
      ELSIF enb = '1' THEN
        auto_ready_dut_enb <= auto_ready_axi4_stream_video_master;
      END IF;
    END IF;
  END PROCESS reg_process;


  dut_enable <= write_axi_enable AND auto_ready_dut_enb;

  Video_out_sig_unsigned <= unsigned(Video_out_sig);

  top_user_pixel_1 <= resize(Video_out_sig_unsigned, 64);

  AXI4_Stream_Video_Master_TDATA <= AXI4_Stream_Video_Master_TDATA_tmp;

  AXI4_Lite_BRESP <= AXI4_Lite_BRESP_tmp;

  AXI4_Lite_RDATA <= AXI4_Lite_RDATA_tmp;

  AXI4_Lite_RRESP <= AXI4_Lite_RRESP_tmp;

END rtl;

